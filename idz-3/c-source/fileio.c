#include "fileio.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

double write_number_to_file(const char *filename, double number) {
  FILE *file = fopen(filename, "w");
  if (file == NULL) {
    printf("Error opening file!\n");
    exit(1);
  }
  fprintf(file, "%.25f\n", number);
  fclose(file);
  return number;
}

double read_number_from_file(const char *filename) {
  FILE *file = fopen(filename, "r");
  if (file == NULL) {
    printf("Error opening file!\n");
    exit(1);
  }
  double number;
  fscanf(file, "%lf", &number);
  fclose(file);
  return number;
}

