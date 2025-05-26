#pragma once

#include <iostream>

class Io{
public:
  static void prompt_user(std::string &input, const std::string message);
  static void press_enter_to_exit(void);
  static bool print_error_message(const std::string error_msg);
  static void press_enter_to_continue(void);
private:
};
