#include "NesFile.hpp"
#include <algorithm>
#include <iterator>
#include <iostream>
#include <stdint.h>
#include <iomanip>
#include <array>

#define ROM_SIZE 524304
#define BANK_SIZE 0x2000
#define HEADER_SIZE 0x10
#define TOTAL_LEVEL_COUNT 21

static constexpr uint32_t CHARACTER_SELECT_PAL_ADDR = (HEADER_SIZE + BANK_SIZE * 0x1E) + (0xE0D5 - 0xC000);
static constexpr uint32_t CHARACTER_SELECT_PAL_ADDR_DST = CHARACTER_SELECT_PAL_ADDR + 0x1B;
static constexpr uint32_t WORLD_PAL_ADDR = (HEADER_SIZE + BANK_SIZE * 0x6) + (0x801C - 0x8000);
static constexpr uint32_t WORLD_PAL_DST_ADDR = WORLD_PAL_ADDR + 0x40C;
static constexpr uint32_t CHAR_PAL_ADDR = (HEADER_SIZE + BANK_SIZE * 0xA) + (0x8429 - 0x8000);
static constexpr uint32_t CHAR_PAL_DST_ADDR = (HEADER_SIZE + BANK_SIZE * 0xA) + (0x8429 - 0x8000) + 0x10;
static constexpr uint32_t BACKGROUND_PALETTE_ADDR = (HEADER_SIZE + BANK_SIZE * 0xC) + (0xA1B8 - 0x8000);
static constexpr uint32_t BACKGROUND_PALETTE_ADDR_DST = (HEADER_SIZE + BANK_SIZE * 0xC) + (0xBAD0 - 0x8000);
static constexpr uint32_t SPRITE_PALETTE_ADDR = (HEADER_SIZE + BANK_SIZE * 0xE) + (0x81B8 - 0x8000);
static constexpr uint32_t SPRITE_PALETTE_ADDR_DST = (HEADER_SIZE + BANK_SIZE * 0xE) + (0x8B30 - 0x8000);
static constexpr uint32_t BANK_8_STARTING_ADDR = HEADER_SIZE + BANK_SIZE * 0x8;
static constexpr uint32_t BANK_A_STARTING_ADDR = HEADER_SIZE + BANK_SIZE * 0xA;
static constexpr uint32_t LEVEL_DATA_PTR_LO = BANK_8_STARTING_ADDR + (7 * 3);
static constexpr uint32_t LEVEL_DATA_PTR_HI = LEVEL_DATA_PTR_LO + (21 * 10);
static constexpr uint32_t ENEMY_POINTER_HIHI_ADDR = (0xA500 - 0x8000) + BANK_8_STARTING_ADDR;
static constexpr uint32_t ENEMY_POINTER_HILO_ADDR = (0xA515 - 0x8000) + BANK_8_STARTING_ADDR;
static constexpr uint32_t ENEMY_POINTER_LOHI_ADDR = (0xA52A - 0x8000) + BANK_8_STARTING_ADDR;
static constexpr uint32_t ENEMY_POINTER_LOLO_ADDR = (0xA53F - 0x8000) + BANK_8_STARTING_ADDR;

constexpr std::array<uint8_t, 2> end_level = {0xF2, 0xFF};
constexpr std::array<uint8_t, 2> level_error = {0xFF, 0xFF};

static constexpr uint32_t Wrapper_FB70_addr = (HEADER_SIZE + BANK_SIZE * 0x1E) + (0xEEDE - 0xC000);
static constexpr std::array<uint8_t, 10> Wrapper_FB70 = {
  0x20, 0xF4, 0xEE, // JSR Wrapper_DisableNMI
  0x20, 0x70, 0xFB, // JSR $FB70
  0x20, 0x00, 0xEF, // JSR Wrapper_RestoreNMI
  0x60              // RTS
};

static constexpr uint32_t Wrapper_EBB0_addr = (HEADER_SIZE + BANK_SIZE * 0x1E) + (0xEEE8 - 0xC000);
static constexpr std::array<uint8_t, 12> Wrapper_EBB0 = {
  0x20, 0xF4, 0xEE, // JSR Wrapper_DisableNMI
  0x4C, 0xB0, 0xEE, // JMP bank_e_EBB0
  0x20, 0x00, 0xEF, // JSR Wrapper_RestoreNMI
  0x4C, 0x7D, 0xF7  // JMP CopyEnemyDataToMemory
};

static constexpr uint32_t Wrapper_DisableNMI_addr = (HEADER_SIZE + BANK_SIZE * 0x1E) + (0xEEF4 - 0xC000);
static constexpr std::array<uint8_t, 12> Wrapper_DisableNMI {
  0x08,             // PHP
  0x48,             // PHA
  0xA5, 0xFF,       // LDA PPUCtrlMirror
  0x29, 0x7F,       // AND #$7F
  0x8D, 0x00, 0x20, // STA PPUCTRL
  0x68,             // PLA
  0x28,             // PLP
  0x60              // RTS
};

static constexpr uint32_t Wrapper_RestoreNMI_addr = (HEADER_SIZE + BANK_SIZE * 0x1E) + (0xEF00 - 0xC000);
static constexpr std::array<uint8_t, 7> Wrapper_RestoreNMI {
  0x08,             // PHP
  0x48,             // PHA
  0xA5, 0xFF,       // LDA PPUCtrlMirror
  0x4C, 0xFA, 0xEE  // JMP WrapperSetPPUCTRL
};

static constexpr uint32_t LoadCurrentPalette_AreaOffset_FB70_addr = (HEADER_SIZE + BANK_SIZE * 0x6) + (0x93B4 - 0x8000);
static constexpr uint32_t LoadCurrentArea_FB70_addr = (HEADER_SIZE + BANK_SIZE * 0x6) + (0x9580 - 0x8000);
static constexpr uint32_t ReadLevelForegroundData_FB70_addr = (HEADER_SIZE + BANK_SIZE * 0x6) + (0x95EC - 0x8000);
static constexpr std::array<uint8_t, 3> Add_Wrapper_FB70 {
  0x20, 0xDE, 0xEE  // JSR Wrapper_FB70
}; 
static constexpr std::array<uint8_t, 3> Original_FB70 {
  0x20, 0x70, 0xFB  // JSR $FB70
};

uint8_t NesFile::override_subroutine_call(const std::array<uint8_t, 3> &wrapper, const std::array<uint8_t, 3> &original, const uint32_t addr) {
  if (std::equal(wrapper.begin(), wrapper.end(), rom_data_.begin() + addr))
    return 0;
  if (std::equal(original.begin(), original.end(), rom_data_.begin() + addr)) {
    std::copy(wrapper.begin(), wrapper.end(), rom_data_.begin() + addr);
    code_injection_count_ += 3;
    return 0;
  }
  std::cerr << "Invalid code when trying to override the subroutine call at address: 0x" << std::hex << addr << std::endl;
  return 1;
}

uint8_t NesFile::subroutine_injection(const uint8_t *begin, const uint8_t *end, const uint8_t size, const uint32_t addr) {
  if (std::all_of(rom_data_.begin() + addr, rom_data_.begin() + addr + size, [](uint8_t i){return i == 0xFF;})) {
    std::copy(begin, end, rom_data_.begin() + addr);
    code_injection_count_ += size;
  }
  if (!std::equal(begin, end, rom_data_.begin() + addr)) {
    std::cerr << "Space taken for the wrapper subroutine at address: 0x" << std::hex << addr << std::endl;
    return 1;
  }
  return 0;
}

uint8_t NesFile::apply_subroutine_fixes(void) {
  uint8_t result = 0;
  result += subroutine_injection(Wrapper_FB70.begin(), Wrapper_FB70.end(), Wrapper_FB70.size(), Wrapper_FB70_addr);
  result += subroutine_injection(Wrapper_EBB0.begin(), Wrapper_EBB0.end(), Wrapper_EBB0.size(), Wrapper_EBB0_addr);
  result += subroutine_injection(Wrapper_DisableNMI.begin(), Wrapper_DisableNMI.end(), Wrapper_DisableNMI.size(), Wrapper_DisableNMI_addr);
  result += subroutine_injection(Wrapper_RestoreNMI.begin(), Wrapper_RestoreNMI.end(), Wrapper_RestoreNMI.size(), Wrapper_RestoreNMI_addr);
  result += override_subroutine_call(Add_Wrapper_FB70, Original_FB70, ReadLevelForegroundData_FB70_addr);
  result += override_subroutine_call(Add_Wrapper_FB70, Original_FB70, LoadCurrentArea_FB70_addr);
  result += override_subroutine_call(Add_Wrapper_FB70, Original_FB70, LoadCurrentPalette_AreaOffset_FB70_addr);
  if (result) {
    std::cerr << "Use this tool again without the patch that modify code at the address location" << std::endl;
    return 1;
  }
  return 0;
}


void NesFile::fix_level_issues(const uint8_t starting_level, const uint8_t ending_level) {
  std::vector<uint8_t>::iterator out_of_bound_addr = levels_[ending_level].area[0].level_data_address + rom_data_.begin();
  for (uint8_t current_level = starting_level; current_level < ending_level; current_level++) {
    for (uint8_t current_area = 0; current_area < 10; current_area++) {
      std::vector<uint8_t>::iterator beg_addr = levels_[current_level].area[current_area].level_data_address + rom_data_.begin();
      std::vector<uint8_t>::iterator end_addr = (current_area + 1 < 10)
        ? levels_[current_level].area[current_area + 1].level_data_address + rom_data_.begin()
          : levels_[current_level + 1].area[0].level_data_address + rom_data_.begin();
      if (end_addr == out_of_bound_addr) {
        std::cout << "OOB " << std::hex << (int)current_level / 3 + 1 << "-" << (int)current_level % 3 + 1 << " area " << (int)current_area << std::endl;
        end_addr = std::search(beg_addr, rom_data_.end(), end_level.begin(), end_level.end()) + 2; // High chance this breaks, TODO add bounds checking?
      }
      std::vector<uint8_t>::iterator it = std::search(beg_addr, end_addr, level_error.begin(), level_error.end());
      if (it != end_addr) {
        std::cout << "Fixed level format error found in " << std::hex << (int)current_level / 3 + 1 << "-" << (int)current_level % 3 + 1 << " area " << (int)current_area << std::endl;
        std::rotate(it, it + 2, end_addr);
        level_fix_count_++;
      }
    }
  }
}

uint8_t NesFile::get_first_level_page_length(void) const {
  uint8_t current_level = 0;
  uint8_t current_area = 0;
  while (levels_[current_level].area[current_area].raw_level_data_address < 0xA500) {
    current_area++;
    if (current_area == 10) {
      current_area = 0;
      current_level++;
    }
  }
  return current_level;
}

/*
  Levels seems to be scattered around 3 part
  1-1 to 3-3 seems to be contained in 0x81B9-0xA500 in bank 8/9
  4-1 to 5-3 seems to be contained in 0xA6F8-0xc000 in bank 8/9
  6-1 to 7-2 seems to be contained in 0x8654-0x in bank A/B

  Going with the assumption that levels always end with $F2 $FF for now, if it doesn't i'll update the logic in the future
  What a mess...
*/
void NesFile::apply_level_data_fix(void) {
  uint8_t first_level_table_length = get_first_level_page_length();
  fix_level_issues(0, first_level_table_length);
  fix_level_issues(first_level_table_length, 0x0F);
  fix_level_issues(0x0F, 0x14);
}

uint32_t NesFile::traverse_sprite_data(uint32_t current_addr, uint8_t current_level, uint8_t current_area) {
  uint8_t area_count_end = levels_[current_level].area[current_area].page_count;
  for (uint8_t area_count = 0; area_count <= area_count_end; area_count++)
    current_addr += rom_data_[current_addr];
  return current_addr;
}

void NesFile::apply_sprite_data_fix(void) {
  std::vector<uint8_t> buffer;

  for (uint8_t current_level = 0; current_level < 20; current_level++) {
    for (uint8_t current_area = 0; current_area < 10; current_area++) {
      uint32_t current_address = levels_[current_level].area[current_area].enemy_data_address;
      uint32_t end_addr = traverse_sprite_data(current_address, current_level, current_area);
      buffer.insert(buffer.cend(), rom_data_.cbegin() + current_address, rom_data_.cbegin() + end_addr);
      buffer.push_back(0x01);
      sprite_fix_count_++;
    }
  }
  original_sprice_space_ =
    (traverse_sprite_data(levels_[19].area[9].enemy_data_address, 19, 9) + 1) -  levels_[0].area[0].enemy_data_address;
  new_sprite_space_ = buffer.size();
  std::copy(buffer.cbegin(), buffer.cend(), rom_data_.begin() + levels_[0].area[0].enemy_data_address);

  uint16_t sprite_ptr_addr = 0xA000;
  uint32_t current_addr = levels_[0].area[0].enemy_data_address;
  for (uint8_t current_level = 0; current_level < 20; current_level++) {
    for (uint8_t current_area = 0; current_area < 10; current_area++) {
      rom_data_[levels_[current_level].enemy_ptr_table_hi + current_area] = sprite_ptr_addr >> 8;
      sprite_fix_count_++;
      rom_data_[levels_[current_level].enemy_ptr_table_lo + current_area] = sprite_ptr_addr & 0xFF;
      sprite_fix_count_++;
      for (uint8_t area_count = 0; area_count <= levels_[current_level].area[current_area].page_count + 1; area_count++) {
        sprite_ptr_addr += rom_data_[current_addr];
        current_addr += rom_data_[current_addr];
      }
    }
  }
}

void NesFile::apply_color_fix(void) {
  fix_colors(CHAR_PAL_ADDR, CHAR_PAL_DST_ADDR);
  fix_colors(WORLD_PAL_ADDR, WORLD_PAL_DST_ADDR);
  fix_colors(CHARACTER_SELECT_PAL_ADDR, CHARACTER_SELECT_PAL_ADDR_DST);
  fix_colors(BACKGROUND_PALETTE_ADDR, BACKGROUND_PALETTE_ADDR_DST);
  fix_colors(SPRITE_PALETTE_ADDR, SPRITE_PALETTE_ADDR_DST);
}

void NesFile::fix_colors(uint32_t current_addr, uint32_t dst_addr) {
  for (; current_addr < dst_addr; current_addr++)
    if (rom_data_[current_addr] == 0x0D) {
      rom_data_[current_addr] = 0x0F;
      color_fix_count_++;
    }
}

void NesFile::create_copy(std::ifstream &rom) {
  rom.unsetf(std::ios::skipws);
  rom_data_.reserve(ROM_SIZE);
  std::copy(std::istream_iterator<uint8_t>(rom),
    std::istream_iterator<uint8_t>(), std::back_inserter(rom_data_));
}

void NesFile::save_file(std::string &file_name) {
  std::ofstream dst(file_name + ".nes", std::ios::binary);
  dst.write(reinterpret_cast<const char *>(rom_data_.data()),
            static_cast<std::streamsize>(rom_data_.size() * sizeof(uint8_t)));
}

void NesFile::print_summary(void) const {
  std::cout << "~ Summary ~\n";
  std::cout << "Color fixes applied: " << std::dec << color_fix_count_ << "\n";
  std::cout << "Sprite level data fixes applied: " << std::dec << sprite_fix_count_ << "\n";
  std::cout << "Level data fixes applied: " << std::dec << level_fix_count_ << "\n";
  std::cout << "Old sprite level data size: " << std::dec << original_sprice_space_ << "\n";
  std::cout << "New sprite level data size: " << std::dec << new_sprite_space_ << "\n";
  std::cout << "Code injection: " << std::dec << code_injection_count_ << std::endl;
}

void NesFile::extract_level_content(void) {
  for (uint32_t current_level = 0; current_level < TOTAL_LEVEL_COUNT; current_level++) {
    Level level;
    level.current_world = (current_level / 3) + 1;
    level.level = (current_level % 3) + 1;
    
    for (uint8_t area_index = 0; area_index < 10; area_index++) {
      extract_area_data(level, current_level, area_index);
      extract_enemy_data(level, current_level, area_index);
    }
    levels_.push_back(level);
  }
}

void NesFile::extract_area_data(Level &level, uint32_t current_level, uint8_t area_index) {
  uint32_t level_data_addr = 
    (rom_data_[LEVEL_DATA_PTR_HI + rom_data_[BANK_8_STARTING_ADDR + current_level] + area_index] << 8) 
      + (rom_data_[LEVEL_DATA_PTR_LO + rom_data_[BANK_8_STARTING_ADDR + current_level] + area_index]);
  level.area[area_index].raw_level_data_address = level_data_addr;
  level.area[area_index].level_data_address =
    (level.current_world < 6) ? (level_data_addr - 0x8000) + BANK_8_STARTING_ADDR : (level_data_addr - 0x8000) + BANK_A_STARTING_ADDR;
  level.area[area_index].page_count = rom_data_[level.area[area_index].level_data_address + 2] >> 4 & 0x0F;
}

void NesFile::extract_enemy_data(Level &level, uint32_t current_level, uint8_t area_index) {
  level.enemy_ptr_table_hi = 
    ((rom_data_[ENEMY_POINTER_HIHI_ADDR + current_level] << 8) + (rom_data_[ENEMY_POINTER_HILO_ADDR + current_level]) - 0x8000)
      + BANK_8_STARTING_ADDR;
  level.enemy_ptr_table_lo = 
    ((rom_data_[ENEMY_POINTER_LOHI_ADDR + current_level] << 8) + (rom_data_[ENEMY_POINTER_LOLO_ADDR + current_level]) - 0x8000)
      + BANK_8_STARTING_ADDR;
  level.area[area_index].enemy_data_address = 
    ((rom_data_[level.enemy_ptr_table_hi + area_index] << 8) + (rom_data_[level.enemy_ptr_table_lo + area_index]) - 0x8000) + BANK_A_STARTING_ADDR;
}

uint8_t NesFile::apply_fixes(void) {
  if (apply_subroutine_fixes())
    return 1;
  extract_level_content();
	apply_color_fix();
  apply_sprite_data_fix();
  apply_level_data_fix();
  return 0;
}
