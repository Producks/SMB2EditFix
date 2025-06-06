// By Producks
// 2025/05/24

#include <iostream>
#include <fstream>
#include <filesystem>
#include <string_view>
#include "NesFile.hpp"
#include "Io.hpp"
#include "FileValidator.hpp"
#include "ConfigParser.hpp"
#include "Config.h"

static void print_intro(void) { std::cout << "SMB2EditFix by Producks version 1.3\nSource code: https://github.com/Producks/SMB2EditFix\n" << std::endl; }

static bool save_result(Config &config, NesFile &nes_file) {
  std::string save_file_name;

  if (config.program & SAME_FILE_OUT)
    save_file_name = config.output_name;
  else
    Io::prompt_user(save_file_name, "\nEnter a name for the modified rom: ");

  if (!FileValidator::validate_out_file(save_file_name, config))
    return false;
  if (!nes_file.save_file(save_file_name)) {
    Io::print_error_message("Couldn't save the new file");
    return false;
  }
  if (!(config.program & SKIP_ENTER_ON_SUCCESS)) {
    std::cout << "Success!" << std::endl;
    Io::press_enter_to_exit();
  }
  return true;
}

static bool init(Config &config, NesFile &nes_file, int argc, char **argv) {
  std::string file_name;
  std::ifstream rom;

  ConfigParser::ParseConfigFile(config);
  if (config.patches == 0) {
    std::cerr << "No patches were found to be applied from the config file" << std::endl;
    Io::press_enter_to_exit();
    return false;
  }
  if (argc == 1)
    Io::prompt_user(file_name, "Enter the rom name: ");
  else
    file_name = argv[1];
  if (!FileValidator::valid_file(rom, file_name))
	  return false;
  nes_file.create_copy(rom);
  rom.close();
  return true;
}

int main(int argc, char **argv) {
  NesFile nes_file;
  Config config;

  print_intro();
  if (!init(config, nes_file, argc, argv))
    return 1;
  if (!nes_file.apply_fixes(config)) {
    Io::press_enter_to_exit();
    return 1;
  }
  nes_file.print_summary();
  if (!save_result(config, nes_file))
    return 1;
  return 0;
}
