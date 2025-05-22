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

static void set_string_config(std::string &result, bool &set, const std::string &value) {
  if (set) {
    std::size_t first_quote = value.find('\"');
    std::size_t second_quote = value.rfind('\"');
    if (first_quote == std::string::npos || second_quote == std::string::npos || first_quote == second_quote) {
      Io::print_error_message("When reading the file output name");
      set = false;
    }
    else {
      result = value.substr(first_quote + 1, second_quote - (first_quote + 1));
      if (result.empty()) {
        Io::print_error_message("The file output name can't be empty");
        set = false;
      }
      std::cout << "result:" << result << std::endl;
    }
  }
}

static std::map<const std::string, std::function<void(Config&, const std::string&)>> func_map {
  // Rom modifications
  {"Colorfix", [](Config &config, const std::string &value) {set_bool_config(config.color_fix, value);}},
  {"Spritecolorfix", [](Config &config, const std::string &value) {set_bool_config(config.sprite_color_fix, value);}},
  {"Levelfix", [](Config &config, const std::string &value) {set_bool_config(config.level_fix, value);}},
  {"Spriteleveldatafix", [](Config &config, const std::string &value) {set_bool_config(config.sprite_data_fix, value);}},
  {"Wrappersinjection", [](Config &config, const std::string &value) {set_bool_config(config.sei_wrapper, value);}},
  {"CHRA12inversion", [](Config &config, const std::string &value) {set_bool_config(config.chr_a12_inversion_fix, value);}},

  // Program options
  {"Alwaysoverwrite", [](Config &config, const std::string &value) {set_bool_config(config.overwrite_file, value);}},
  {"Samefileoutput", [](Config &config, const std::string &value) {set_bool_config(config.same_file_out, value);}},
  {"Skipenteronsuccess", [](Config &config, const std::string &value) {set_bool_config(config.skip_enter_on_success, value);}},
  {"Savefilename", [](Config &config, const std::string &value) {set_string_config(config.output_name, config.same_file_out, value);}}
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
