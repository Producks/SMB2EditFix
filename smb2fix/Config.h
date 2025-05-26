#pragma once

#include <string>
#include <stdint.h>

struct Config {
  uint16_t patches = 0;
  uint16_t program = 0;
  std::string output_name;
};

constexpr uint16_t COLOR_FIX = 1 << 0;
constexpr uint16_t SPRITE_COLOR_FIX = 1 << 1;
constexpr uint16_t LEVEL_FIX = 1 << 2;
constexpr uint16_t SPRITE_DATA_FIX = 1 << 3;
constexpr uint16_t SEI_WRAPPER = 1 << 4;
constexpr uint16_t CHR_A12_INVERSION_FIX = 1 << 5;
constexpr uint16_t NO_DROP_SUPER_JUMP = 1 << 6;
constexpr uint16_t FIX_CHR_CYCLE = 1 << 7;
constexpr uint16_t DISABLE_BONUS_CHANCE = 1 << 8;
constexpr uint16_t CHARACTER_SELECT_AFTER_DEATH = 1 << 9;
constexpr uint16_t AUTO_BOMB_FIX = 1 << 10;
constexpr uint16_t QUICK_RESPAWN = 1 << 11;
constexpr uint16_t MUTE_QUICK_RESPAWN = 1 << 12;
constexpr uint16_t MONO_BOMB_FLASH = 1 << 13;
constexpr uint16_t DISABLE_FALLING_SOUND = 1 << 14;

constexpr uint16_t OVERWRITE_FILE = 1 << 0;
constexpr uint16_t SAME_FILE_OUT = 1 << 1;
constexpr uint16_t SKIP_ENTER_ON_SUCCESS = 1 << 2;
