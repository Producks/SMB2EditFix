// By Producks 2025/05/09

#include <iostream>
#include <fstream>
#include "NesFile.hpp"

static void prompt_user(std::ifstream &rom) {
  std::string file_name;

  std::cout << "Enter the rom path/name:";
  std::getline(std::cin, file_name);
  if (std::cin.fail())
    std::cerr << "\nInvalid input" << std::endl;
  rom.open(file_name, std::ios::binary);
}

// https://www.nesdev.org/wiki/INES
static const int nes_header[] {0x4E, 0x45, 0x53, 0x1A};

static bool valid_file(std::ifstream &rom) {
	if (rom.fail())
		return false;
	char buffer[4];
	if (!rom.read(buffer, sizeof(buffer))){
		std::cerr << "Invalid size for the file" << std::endl;
		return false;
	}
	for (int index = 0; index < 4; index++)
		if (buffer[index] != nes_header[index]) {
			std::cerr << "Error looking for the nes header" << std::endl;
			return false;
	}
	rom.clear();
	rom.seekg(0, std::ios_base::beg);
	rom.seekg(0, std::ios_base::end);
	int length = rom.tellg();
	if (length != 524304)
		return false;
	rom.seekg(0, std::ios_base::beg);
  return true;
}

static inline void print_intro() { std::cout << "Smb2EditFix v1.0\n By Producks" << std::endl; }

int main(int argc, char **argv) {
  std::ifstream rom;
	NesFile nes_file;

  if (argc == 1)
    prompt_user(rom);
  else
    rom.open(argv[1], std::ios::binary);
	if (!valid_file(rom))
		return 1;
	nes_file.create_copy(rom);
  if (!nes_file.apply_fixes()) {
    nes_file.save_file();
    nes_file.print_summary();    
  }
  rom.close();
  return 0;
}
