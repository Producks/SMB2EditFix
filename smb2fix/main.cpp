// By Producks
// 2025/05/16

#include <iostream>
#include <fstream>
#include <filesystem>
#include <string_view>
#include "NesFile.hpp"
#include "Io.hpp"
#include "FileValidator.hpp"
#include "ConfigParser.hpp"
#include "Config.h"

static void print_intro(void) { std::cout << "SMB2EditFix by Producks version 1.0\nSource code: https://github.com/Producks/SMB2EditFix\n" << std::endl; }

int main(int argc, char **argv) {
  NesFile nes_file;
  std::ifstream rom;
  std::string file_name;
  Config config;

  print_intro();
  ConfigParser::ParseConfigFile(config);
  // return 0;
  if (argc == 1)
    Io::prompt_user(file_name, "Enter the rom name: ");
  else
    file_name = argv[1];
	if (!FileValidator::valid_file(rom, file_name))
		return 1;
	nes_file.create_copy(rom);
  if (nes_file.apply_fixes()) {
    Io::press_enter_to_continue();
    return 1;
  }
  nes_file.print_summary();
  std::string save_file_name;
  Io::prompt_user(save_file_name, "\nEnter a name for the modified rom: ");
  if (!FileValidator::validate_out_file(save_file_name))
    return 1;
  if (!nes_file.save_file(save_file_name)) {
    rom.close();
    Io::print_error_message("Couldn't save the new file");
    return 1;
  }
  std::cout << "Success!" << std::endl;
  Io::press_enter_to_continue();
  rom.close();
  return 0;
}
