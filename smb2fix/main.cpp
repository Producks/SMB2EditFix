// By Producks 2025/05/13

#include <iostream>
#include <fstream>
#include <filesystem>
#include <limits>
#include <string_view>
#include "NesFile.hpp"

static void prompt_user(std::string &input, const std::string message) {
  std::cout << message;
  std::getline(std::cin, input);
}

static void press_enter_to_continue(void) {
  std::cout << "Press enter to quit the program...";
  std::cin.ignore(std::numeric_limits<std::streamsize>::max(),'\n');
}

static bool validate_out_file(std::string &out_file_name) {
  if (!out_file_name.ends_with(".nes"))
    out_file_name += ".nes";
  if (std::filesystem::exists(out_file_name)) {
    std::string confirmation;
    prompt_user(confirmation, "Warning: This file exists. To overwrite, type 'y' or 'Y' and press Enter:");
    if (confirmation != "y" && confirmation != "Y") {
      std::cerr << "Relaunch the program with another file name" << std::endl;
      press_enter_to_continue();
      return false;
    }
  }
  return true;
}

static bool does_file_exist(std::string &file_name) {
  if (!std::filesystem::exists(file_name)) {
    file_name += ".nes";
    if (!std::filesystem::exists(file_name))
      return false;
  }
  return true;
}

static bool print_error_message(const std::string error_msg) {
  std::cerr << "Error! " << error_msg << std::endl;
  press_enter_to_continue();
  return false;
}

// https://www.nesdev.org/wiki/INES
static const int nes_header[] {0x4E, 0x45, 0x53, 0x1A};

static bool valid_file(std::ifstream &rom, std::string &file_name) {
  if (std::cin.fail())
    return print_error_message("Cin failure");
  if (file_name.empty())
    return print_error_message("Empty prompt");
  if (!does_file_exist(file_name))
    return print_error_message("Couldn't locate the rom file");
  rom.open(file_name, std::ios::binary);
	if (rom.fail())
    return print_error_message("Couldn't open the rom file");
	char buffer[4];
	if (!rom.read(buffer, sizeof(buffer)))
    return print_error_message("Invalid size for the rom file");
	for (int index = 0; index < 4; index++)
		if (buffer[index] != nes_header[index]) {
      return print_error_message("When looking for the nes header");
	}
	rom.clear();
	rom.seekg(0, std::ios_base::beg);
	rom.seekg(0, std::ios_base::end);
	int length = rom.tellg();
	if (length != 524304)
    return print_error_message("Invalid size for the rom");
	rom.seekg(0, std::ios_base::beg);
  return true;
}

static void print_intro(void) { std::cout << "SMB2EditFix by Producks version 1.0\nSource code: https://github.com/Producks/SMB2EditFix\n" << std::endl; }

int main(int argc, char **argv) {
  std::string file_name;
  NesFile nes_file;
  std::ifstream rom;

  print_intro();
  if (argc == 1)
    prompt_user(file_name, "Enter the rom name: ");
  else
    file_name = argv[1];
	if (!valid_file(rom, file_name))
		return 1;
	nes_file.create_copy(rom);
  if (nes_file.apply_fixes()) {
    press_enter_to_continue();
    return 1;
  }
  nes_file.print_summary();
  std::string save_file_name ("result");
  if (!validate_out_file(save_file_name))
    return 1;
  nes_file.save_file(save_file_name);
  rom.close();
  return 0;
}
