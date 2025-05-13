// BUFFER OVERFLOW CITY, if you go past 10k for a line you're in trouble. GG NOOB
// By Producks

#include <stdio.h>
#include <fcntl.h>
#include <stdlib.h>
#include <string.h>


static const int area_table[] = {
  5, 4, 4, // w1
  4, 5, 7, // w2
  4, 2, 8, // w3
  1, 4, 7, // w4
  2, 5, 5, // w5
  6, 2, 6, // w6
  5, 9, 1  // w7
};


#define STARTING_POS 0x101C9
#define END_POS 0x12510 // Has to be exact or segfault, too lazy to fix it :)

static void header_handler(FILE *save) {
  static int world = 1;
  static int level = 1;
  static int area = 0;
  static int area_counter = 0;

  unsigned char header_buffer[100];

  if (world == 8)
    return;
  sprintf(header_buffer, "\nLevelData_%d_%d_Area%d:\n", world, level, area);
  fwrite(header_buffer, 1, strlen(header_buffer), save);

  area++;
  if (area == area_table[area_counter]){
    area_counter++;
    area = 0;
    level++;
    if (level > 3) {
      level = 1;
      world++;
    }
  }
}

static void format_hex(unsigned char *formated_buffer, size_t *format_buffer_index, unsigned char *buffer, size_t *index, const char *arg) {
  *format_buffer_index += sprintf(formated_buffer + *format_buffer_index, arg, buffer[*index]);
  *index += 1;
}

static void write_to_file(FILE *save, unsigned char *buffer, size_t *index) {
  unsigned char formated_buffer[10000];
  size_t temp_buffer_index = 0;

  header_handler(save);
  fwrite(".db", 1, 3, save);
  while (buffer[*index] != 0xFF)
    format_hex(formated_buffer, &temp_buffer_index, buffer, index, " $%02X,");
  format_hex(formated_buffer, &temp_buffer_index, buffer, index, " $%02X"); // For the 0xFF
  formated_buffer[temp_buffer_index++] = '\n';
  formated_buffer[temp_buffer_index] = '\0';
  fwrite(formated_buffer, 1, strlen(formated_buffer), save);
}

static void reading(FILE *file, FILE *save) {
  unsigned char *buffer = malloc((END_POS - STARTING_POS) + 1);
  if (buffer == NULL) {
    perror("Malloc:");
    return;
  }
  size_t length_read = fread(buffer, 1, END_POS - STARTING_POS, file);
  printf("Length read %ld\n", length_read);
  size_t index = 0;

  while (index < length_read) {
    write_to_file(save, buffer, &index);
    printf("index value %ld\n", index);
  }
  free(buffer);
}

int main(int argc, char **argv)
{
  if (argc == 1)
    return 1;
  FILE *file = fopen(argv[1], "r");
  if (file == NULL){
    perror("file open");
    return 1;
  }
  FILE *save = fopen("dump_result", "w");
  if (save == NULL) {
    perror("Save file:");
    fclose(file);
    return 1;
  }
  if (fseek(file, STARTING_POS, SEEK_SET)) {
    perror("fseek:");
    return 1;
  }
  reading(file, save);
  fclose(file);
  fclose(save);
  return 0;
}
