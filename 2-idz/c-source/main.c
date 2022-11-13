#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "stringprocessor.h"
#include "random.h"
#include "time.h"
#include "consoleio.h"
#include "fileio.h"

#define MAX_SIZE 300000

// Вариант 24
// Разработать программу, которая ищет в ASCII-строке заданную
// подстроку и возвращает список индексов первого символа для
// всех вхождений подстроки в строке. Подстрока вводится как параметр.


int main(int argc, char *argv[]) {
    int rand_seed;
    int input_mode; // 0 - console, 1 - file, 2 - random, 3 - test
    int clocks_elapsed;
    int passes;
    char *file_path;
    char *str_to_find;
    char *str_to_search_in;
    int i;
    char *found_substr_start;
    clock_t start_time, end_time;
    int string_size_to_generate;
    int eof_flag;
    FILE *output_file;

    // ===== INPUT =====
    if (argc < 2) {
        printf("String to find was not provided\n");
        exit(1);
    }

    str_to_find = argv[1];
    if (argc == 2) {
        str_to_search_in = read_string_from_console(MAX_SIZE);
        input_mode = 0;
    } else {
        if (strcmp(argv[2], "-file") == 0) {
            if (argc < 4) {
                printf("Usage: %s <substr> -file <input_file_path> [output_file_path]\n", argv[0]);
                return 1;
            }
            file_path = argv[3];
            str_to_search_in = read_string_from_file(file_path, MAX_SIZE);
            input_mode = 1;

        } else if (strcmp(argv[2], "-random") == 0) {
            if (argc < 5) {
                printf("Usage: %s <substr> -random <seed> <from 0 to 300.000 string_size>\n", argv[0]);
                return 1;
            }
            string_size_to_generate = atoi(argv[4]);
            rand_seed = atoi(argv[3]);

            str_to_search_in = (char *) malloc(string_size_to_generate * sizeof(char));
            generate_random_string(argv[1], str_to_search_in, string_size_to_generate, rand_seed);

            printf("%s\n", str_to_search_in);
            input_mode = 2;
        } else if (strcmp(argv[2], "-test") == 0) {
            if (argc < 4) {
                printf("Usage: %s <substr> -test <seed>\n", argv[0]);
                return 1;
            }
            rand_seed = atoi(argv[3]);
            str_to_search_in = (char *) malloc(MAX_SIZE * sizeof(char));
            generate_random_string(argv[1], str_to_search_in, 30000, rand_seed);
            input_mode = 3;
        } else {
            printf("Unknown argument or in wrong position: %s\n", argv[1]);
            return 1;
        }
    }

    // ===== PROCESSING =====
    output_file = NULL;
    if (input_mode == 1 && argc == 5) {
        file_path = argv[4];
        output_file = fopen(file_path, "w");
    }

    clocks_elapsed = 0;
    passes = input_mode == 3 ? 40000 : 1;

    for (i = 0; i < passes; i++) {
        start_time = clock();
        found_substr_start = my_strstr(str_to_search_in, str_to_find);
        end_time = clock();
        clocks_elapsed += (end_time - start_time);

        while (found_substr_start != NULL) {
            if (input_mode == 0 || input_mode == 2 || input_mode == 1 && argc == 4) {
                printf("%ld ", found_substr_start - str_to_search_in);
            } else if (input_mode == 1) {
                fprintf(output_file, "%ld ", found_substr_start - str_to_search_in);
            }

            start_time = clock();
            found_substr_start = my_strstr(found_substr_start + 1, str_to_find);
            end_time = clock();
            clocks_elapsed += (end_time - start_time);
        }
    }

    if (output_file != NULL) {
        fclose(output_file);
    }

    if (!(input_mode == 1 && argc == 5)) { 
        printf("\n");
    }

    // ===== OUTPUT =====
    // deallocate memory
    free(str_to_search_in);

    printf("Time elapsed: %ld microseconds\n", clocks_elapsed * 1000000 / CLOCKS_PER_SEC);
    return 0;
}
