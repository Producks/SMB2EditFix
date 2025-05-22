#pragma once

#include <string>
#include <stdint.h>

struct Config {
  bool color_fix = true;
  bool level_fix = true;
  bool sprite_color_fix = true;
  bool code_injection = true;


  bool overwrite_file = false;
  bool same_file_out = false;
  bool skip_enter_on_success = false;
  std::string output_name;
};
