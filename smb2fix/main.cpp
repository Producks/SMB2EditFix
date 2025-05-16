// By Producks 2025/05/16

#include <iostream>
#include <fstream>
#include <filesystem>
#include <string_view>
#include "NesFile.hpp"
#include "Io.hpp"
#include "FileValidator.hpp"

static void print_intro(void) { std::cout << "SMB2EditFix by Producks version 1.0\nSource code: https://github.com/Producks/SMB2EditFix\n" << std::endl; }

int main(int argc, char **argv) {
  NesFile nes_file;
  std::ifstream rom;
  std::string file_name;

  print_intro();
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
  std::string save_file_name ("result");
  if (!FileValidator::validate_out_file(save_file_name))
    return 1;
  nes_file.save_file(save_file_name);
  rom.close();
  return 0;
}
