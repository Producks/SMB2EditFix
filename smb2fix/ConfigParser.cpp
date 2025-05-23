#include "ConfigParser.hpp"
#include "Config.h"
#include "Io.hpp"
#include <filesystem>
#include <fstream>
#include <algorithm>
#include <ctype.h>
#include <map>
#include <functional>
#include <stdint.h>

static void config_bool_setter(uint16_t expression, const std::string &value, uint16_t &variable) { variable |= value == "1" ? expression : 0x00; }

static void set_string_config(std::string &result, uint16_t &set, const std::string &value) {
  if (set & SAME_FILE_OUT) {
    std::size_t first_quote = value.find('\"');
    std::size_t second_quote = value.rfind('\"');
    if (first_quote == std::string::npos || second_quote == std::string::npos || first_quote == second_quote) {
      Io::print_error_message("When reading the file output name");
      set ^= SAME_FILE_OUT;
    }
    else {
      result = value.substr(first_quote + 1, second_quote - (first_quote + 1));
      if (result.empty()) {
        Io::print_error_message("The file output name can't be empty");
        set ^= SAME_FILE_OUT;
      }
    }
  }
}

static std::map<const std::string, std::function<void(Config&, const std::string&)>> func_map {
  // Rom modifications
  {"Colorfix", [](Config &config, const std::string &value) {config_bool_setter(COLOR_FIX, value, config.patches);}},
  {"Spritecolorfix", [](Config &config, const std::string &value) {config_bool_setter(SPRITE_COLOR_FIX, value, config.patches);}},
  {"Levelfix", [](Config &config, const std::string &value) {config_bool_setter(LEVEL_FIX, value, config.patches);}},
  {"Spriteleveldatafix", [](Config &config, const std::string &value) {config_bool_setter(SPRITE_DATA_FIX, value, config.patches);}},
  {"Wrappersinjection", [](Config &config, const std::string &value) {config_bool_setter(SEI_WRAPPER, value, config.patches);}},
  {"CHRA12inversion", [](Config &config, const std::string &value) {config_bool_setter(CHR_A12_INVERSION_FIX, value, config.patches);}},

  // Misc patches
  {"Noitemdropfromsuperjump", [](Config &config, const std::string &value) {config_bool_setter(NO_DROP_SUPER_JUMP, value, config.patches);}},
  {"FixCHRcycle", [](Config &config, const std::string &value) {config_bool_setter(FIX_CHR_CYCLE, value, config.patches);}},
  {"Disablebonuschance", [](Config &config, const std::string &value) {config_bool_setter(DISABLE_BONUS_CHANCE, value, config.patches);}},
  {"Characterselectafterdeath", [](Config &config, const std::string &value) {config_bool_setter(CHARACTER_SELECT_AFTER_DEATH, value, config.patches);}},
  {"Fixautobomb", [](Config &config, const std::string &value) {config_bool_setter(AUTO_BOMB_FIX, value, config.patches);}},

  // Program options 
  {"Alwaysoverwrite", [](Config &config, const std::string &value) {config_bool_setter(OVERWRITE_FILE, value, config.program);}},
  {"Samefileoutput", [](Config &config, const std::string &value) {config_bool_setter(SAME_FILE_OUT, value, config.program);}},
  {"Skipenteronsuccess", [](Config &config, const std::string &value) {config_bool_setter(SKIP_ENTER_ON_SUCCESS, value, config.program);}},
  {"Savefilename", [](Config &config, const std::string &value) {set_string_config(config.output_name, config.program, value);}}
};

static void sanitize_line(std::string &line) {
  std::size_t index = line.find('#');
  if (index != std::string::npos)
    line = line.substr(0, index);
  line.erase(std::remove_if(line.begin(), line.end(), isspace), line.end());
  if (line.empty())
    return;
  std::size_t separator = line.find('=');
  if (separator == std::string::npos || line.begin() + separator + 1 == line.end()) {
    Io::print_error_message("With config line \"" + line + "\" it will be ignored");
    line.clear();
  }
}

void ConfigParser::ParseConfigFile(Config &config) {
  std::ifstream config_file;
  std::string line;

  if (!std::filesystem::exists("config.txt")) {
    Io::print_error_message("Couldn't locate config file");
    return;
  }
  config_file.open("config.txt");
  if (config_file.fail()) {
    Io::print_error_message("When opening the config file");
    return;
  }
  while (std::getline(config_file, line)) {
    sanitize_line(line);
    if (line.empty())
      continue;
    std::pair<std::string, std::string> splice = std::make_pair(line.substr(0, line.find('=')), line.substr(line.find('=') + 1, std::string::npos));
    if (func_map.find(splice.first) != func_map.end())
      func_map[splice.first](config, splice.second);
  }
  config_file.close();
}
