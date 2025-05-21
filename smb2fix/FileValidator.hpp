#pragma once

#include <iostream>
#include <fstream>

class FileValidator{
public:
  static bool does_file_exist(std::string &file_name);
  static bool validate_out_file(std::string &out_file_name);
  static bool valid_file(std::ifstream &rom, std::string &file_name);
private:
};
