#include "ConfigParser.hpp"
#include "Config.h"
#include <filesystem>

void ConfigParser::ParseConfigFile(Config &config) {
  (void)config;
  if (!std::filesystem::exists("config.txt")) {
    std::cerr << "Couldn't locate config file" << std::endl;
    return;
  }
  
}
