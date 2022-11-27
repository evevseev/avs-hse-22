#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "time.h"
#include "root_finder.h"
#include "fileio.h"

// Вариант 33
// Разработать программу, определяющую корень уравнения x^3−0.5x^2+0.2x − 4 = 0 методом половинного деления
// с точностью от 0,001 до 0,00000001 в диапазоне [1;3].
// Если диапазон некорректен, то подобрать корректный диапазон.

double f(double x) {
  return x * x * x - 0.5 * x * x + 0.2 * x - 4;
}

double get_random_double(double min, double max) {
  return min + (double) rand() / RAND_MAX * (max - min);
}

// ./a.out eps -argument param param
//  1 ----- 2 - 3 --- 4 ---- 5 argc
//  0 ----- 1 - 2 --- 3 ---- 6 argv indexes
int main(int argc, char *argv[]) {
  int input_mode; // 0 - console, 1 - file, 2 - random, 3 - test
  unsigned int clocks_elapsed;
  clock_t start_time, end_time;
  char *file_path;
  int i, passes;
  double epsilon, answer;
  rf_function func = &f;
  double a = 1;
  double b = 3;

  if (argc < 2) {
    printf("Not enough arguments. Please specify epsilon.\n");
    return 1;
  } else if (argc == 2) {
    input_mode = 0;
    epsilon = atof(argv[1]);
  } else {
    if (strcmp(argv[2], "-file") == 0) {
      if (argc < 4) {
        printf("Usage: %s <epsilon> -file <input_file_path> [output_file_path]\n", argv[0]);
        return 1;
      }
      file_path = argv[3];
      epsilon = read_number_from_file(file_path);
      input_mode = 1;
    } else if (strcmp(argv[1], "-random") == 0) {
      if (argc < 3) {
        printf("Usage: %s -random <seed>\n", argv[0]);
        return 1;
      }
      srand(atoi(argv[2]));
      epsilon = get_random_double(0.001, 0.00000001);
      input_mode = 2;
    } else if (strcmp(argv[1], "-test") == 0) {
      if (argc < 3) {
        printf("Usage: %s -test <seed>\n", argv[0]);
        return 1;
      }
      srand(atoi(argv[2]));
      epsilon = get_random_double(0.001, 0.00000001);
      input_mode = 3;
    } else {
      printf("Unknown argument or in wrong position");
      return 1;
    }
  }

  if (epsilon < 0) {
    printf("Epsilon must be positive.\n");
    return 1;
  }

  clocks_elapsed = 0;
  passes = input_mode == 3 ? 4000000 : 1;

  for (i = 0; i < passes; i++) {
    start_time = clock();

    answer = find_root(func, a, b, epsilon);

    end_time = clock();
    clocks_elapsed += (end_time - start_time);
  }

  // ===== OUTPUT =====
  if (input_mode == 1 && argc >= 5) {
    file_path = argv[4];
    write_number_to_file(file_path, answer);
  } else {
    if (input_mode == 2) {
      printf("Epsilon: %.15f\n", epsilon);
    }
    if (input_mode != 3) {
      printf("%.25f\n", answer);
    }
  }

  printf("Time elapsed: %u microseconds\n", clocks_elapsed * 1000000 / CLOCKS_PER_SEC);
  return 0;
}
