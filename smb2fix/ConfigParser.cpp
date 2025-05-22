#include "ConfigParser.hpp"
#include "Config.h"
#include "Io.hpp"
#include <filesystem>
#include <fstream>
#include <algorithm>
#include <ctype.h>
#include <map>
#include <functional>

static void set_bool_config(bool &config, const std::string &value) { config = value == "1"; }

static std::map<const std::string, std::function<void(Config&, const std::string&)>> func_map { 
  {"Colorfix", [](Config &config, const std::string &value) {set_bool_config(config.color_fix, value);}},
  {"Spritecolorfix", [](Config &config, const std::string &value) {set_bool_config(config.sprite_color_fix, value);}},
  {"Levelfix", [](Config &config, const std::string &value) {set_bool_config(config.level_fix, value);}},
  {"Codeinjection", [](Config &config, const std::string &value) {set_bool_config(config.code_injection, value);}},
  {"Alwaysoverwrite", [](Config &config, const std::string &value) {set_bool_config(config.overwrite_file, value);}},
  {"Samefileoutput", [](Config &config, const std::string &value) {set_bool_config(config.same_file_out, value);}},
  {"Skipenteronsuccess", [](Config &config, const std::string &value) {set_bool_config(config.skip_enter_on_success, value);}}
};

static void sanitize_line(std::string &line) {
  std::size_t index = line.find('#');
  if (index != std::string::npos)
    line = line.substr(0, index);
  line.erase(std::remove_if(line.begin(), line.end(), isspace), line.end());
  if (line.empty())
    return;
  std::size_t seperator = line.find('=');
  if (seperator == std::string::npos || line.begin() + seperator + 1 == line.end()) {
    Io::print_error_message("With config line \"" + line + "\" it will be ignored");
    line.clear();
  }
}

void ConfigParser::ParseConfigFile(Config &config) {
  std::ifstream config_file;
  std::string line;

  if (!std::filesystem::exists("config.txt")) {
    std::cerr << "Couldn't locate config file" << std::endl;
    return;
  }
  config_file.open("config.txt");
  if (config_file.fail()) {
    std::cerr << "Error when opening the file" << std::endl;
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
  std::cout << config.overwrite_file << std::endl;
}
