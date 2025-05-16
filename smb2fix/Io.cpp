// By Producks
// 2025/05/16

#include "Io.hpp"
#include <iostream>
#include <limits>

bool Io::print_error_message(const std::string error_msg) {
  std::cerr << "Error! " << error_msg << std::endl;
  press_enter_to_continue();
  return false;
}

void Io::prompt_user(std::string &input, const std::string message) {
  std::cout << message;
  std::getline(std::cin, input);
}

void Io::press_enter_to_continue(void) {
  std::cout << "Press enter to quit the program...";
  std::cin.ignore(std::numeric_limits<std::streamsize>::max(),'\n');
}
