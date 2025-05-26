#pragma once

#include <fstream>
#include <vector>
#include <stdint.h>
#include "Config.h"

struct Area {
  uint8_t  page_count;
  uint32_t raw_level_data_address;
  uint32_t level_data_address;
  uint32_t enemy_data_address;
  uint32_t color_address;
};

struct Level {
  uint8_t   current_world;
  uint8_t   level;
  uint32_t  enemy_ptr_table_hi;
  uint32_t  enemy_ptr_table_lo;
  Area      area[10];
};

class NesFile{
public:
  NesFile() = default;
  ~NesFile() = default;
  void create_copy(std::ifstream &rom);
  bool apply_fixes(const Config &config);
  bool save_file(std::string &file_name);
  void print_summary(void) const;

private:
  uint8_t subroutine_injection(const uint8_t *begin, const uint8_t *end, const uint8_t size, const uint32_t addr, const std::string &context);
  uint8_t override_subroutine_call(const std::array<uint8_t, 3> &wrapper, const std::array<uint8_t, 3> &original, const uint32_t addr, const std::string &context);
  uint8_t apply_sei_wrappers(void);
  bool apply_sprite_color_fix(void);
  uint8_t get_first_level_page_length(void) const;
  void fix_level_issues(const uint8_t starting_level, const uint8_t ending_level);
  void extract_level_content(void);
  void apply_color_fix(void);
  void apply_level_data_fix(void);
  void apply_sprite_data_fix(void);
  bool apply_chr_a12_inversion(void);
  bool apply_auto_bomb_fix(void);
  bool apply_mono_flash(void);
  bool apply_no_sound_quick_respawn(void);
  bool apply_no_intro_fall_sound(void);
  void fix_colors(uint32_t starting_adr, uint32_t length);
  void extract_area_data(Level &level, uint32_t current_level, uint8_t area_index);
  void extract_enemy_data(Level &level, uint32_t current_level, uint8_t area_index);
  bool code_injection(const uint8_t *code_begin, const uint8_t *code_end, const uint8_t *original_code_begin, const uint8_t *original_code_end, uint32_t addr, const std::string &context);
  bool apply_quick_respawn(void);
  uint32_t traverse_sprite_data(uint32_t current_addr, uint8_t current_level, uint8_t current_area);
  bool apply_no_drop(void);
  bool apply_fix_chr_cycle(void);
  bool apply_disable_bonus_chance(void);
  bool apply_char_select_after_death(void);
  std::vector<uint8_t> rom_data_;
  std::vector<Level> levels_;
  uint32_t color_fix_count_ = 0;
  uint32_t level_fix_count_ = 0;
  uint32_t sprite_fix_count_ = 0;
  uint32_t original_sprice_space_ = 0;
  uint32_t code_injection_count_ = 0;
  uint32_t new_sprite_space_ = 0;
};
