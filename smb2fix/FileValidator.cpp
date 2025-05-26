// By Producks
// 2025/05/16

#include "FileValidator.hpp"
#include "Io.hpp"
#include "Config.h"
#include <iostream>
#include <filesystem>
#include <fstream>

bool FileValidator::validate_out_file(std::string &out_file_name, const Config &config) {
  if (std::cin.fail() || out_file_name.empty())
    return Io::print_error_message("With the file name! It can't be empty!");
  if (!out_file_name.ends_with(".nes"))
    out_file_name += ".nes";
  if (std::filesystem::exists(out_file_name) && !(config.program & OVERWRITE_FILE)) {
    std::string confirmation;
    Io::prompt_user(confirmation, "\nWarning: This file exists. To overwrite, type 'y' or 'Y' and press enter:");
    if (confirmation != "y" && confirmation != "Y") {
      std::cerr << "Relaunch the program with another file name" << std::endl;
      Io::press_enter_to_continue();
      return false;
    }
  }
  return true;
}

bool FileValidator::does_file_exist(std::string &file_name) {
  if (!std::filesystem::exists(file_name)) {
    file_name += ".nes";
    if (!std::filesystem::exists(file_name))
      return false;
  }
  return true;
}

// https://www.nesdev.org/wiki/INES
static const int nes_header[] {0x4E, 0x45, 0x53, 0x1A};

bool FileValidator::valid_file(std::ifstream &rom, std::string &file_name) {
  if (std::cin.fail())
    return Io::print_error_message("Cin failure");
  if (file_name.empty())
    return Io::print_error_message("Empty prompt");
  if (!does_file_exist(file_name))
    return Io::print_error_message("Couldn't locate the rom file");
  rom.open(file_name, std::ios::binary);
	if (rom.fail())
    return Io::print_error_message("Couldn't open the rom file");
	char buffer[4];
	if (!rom.read(buffer, sizeof(buffer)))
    return Io::print_error_message("Invalid size for the rom file");
	for (int index = 0; index < 4; index++)
		if (buffer[index] != nes_header[index]) {
      return Io::print_error_message("When looking for the nes header");
	}
	rom.clear();
	rom.seekg(0, std::ios_base::beg);
	rom.seekg(0, std::ios_base::end);
	int length = rom.tellg();
	if (length != 524304)
    return Io::print_error_message("Invalid size for the rom");
	rom.seekg(0, std::ios_base::beg);
  return true;
}
