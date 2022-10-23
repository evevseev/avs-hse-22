#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "consoleio.h"
#include "fileio.h"
#include "arrayprocessor.h"
#include "random.h"
#include "time.h"

#define MAX_SIZE 300000

// Вариант 18
// Сформировать массив B из элементов массива A уменьшением всех элементов
// до первого положительного на 5.

static int ARRAY[MAX_SIZE * 4];

int main(int argc, char *argv[]) {
    int array_size;
    int rand_seed;
    int input_mode; // 0 - console, 1 - file, 2 - random, 3 - test
    int clocks_elapsed;
    char *file_path;
    clock_t start_time, end_time;

    // input
    if (argc == 1) {
        input_mode = 0;
        array_size = read_array_from_console(ARRAY, MAX_SIZE);
    } else {
        if (strcmp(argv[1], "-file") == 0) {
            if (argc <= 2) {
                printf("Usage: %s -file <input_file_path> [output_file_path]\n", argv[0]);
                return 1;
            }
            file_path = argv[2];
            array_size = read_array_from_file(ARRAY, file_path, MAX_SIZE);
            input_mode = 1;
        } else if (strcmp(argv[1], "-random") == 0) {
            if (argc <= 3) {
                printf("Usage: %s -random <from 0 to 300.000 array_size> <rand_seed>\n", argv[0]);
                return 1;
            }
            array_size = atoi(argv[2]);
            rand_seed = atoi(argv[3]);
            random_fill_array(ARRAY, array_size, rand_seed);
            print_array(ARRAY, array_size);
            input_mode = 2;
        } else if (strcmp(argv[1], "-test") == 0) {
            if (argc <= 2) {
                printf("Usage: %s -test <seed>\n", argv[0]);
                return 1;
            }
            rand_seed = atoi(argv[2]);
            input_mode = 3;
        } else {
            printf("Unknown arguments: %s\n", argv[1]);
            return 1;
        }
    }

    // processing of array
    clocks_elapsed = 0;
    if (input_mode == 3) {
        for (int i = 0; i < 5000; ++i) {
            random_fill_array(ARRAY, MAX_SIZE, rand_seed);
            start_time = clock();
            process_array(ARRAY, MAX_SIZE);
            end_time = clock();
            clocks_elapsed += (end_time - start_time);
        }
    } else {
        start_time = clock();
        process_array(ARRAY, array_size);
        end_time = clock();
        clocks_elapsed += (end_time - start_time);
    }

    // output
    if (input_mode == 0 || input_mode == 2 || (input_mode == 1 && argc == 3)) {
        print_array(ARRAY, array_size);
    } else if (input_mode == 1) {
        file_path = argv[3];
        save_array_to_file(ARRAY, array_size, file_path);
    }

    printf("Time elapsed: %ld microseconds\n", clocks_elapsed * 1000000 / CLOCKS_PER_SEC);
    return 0;
}
