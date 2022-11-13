#include <stdlib.h>
#include <stdio.h>
#include <string.h>

void generate_random_string(char *substr, char* str, int size, int seed) {
    int i;
    int generated_size;
    int substr_size;

    srand(seed);
    substr_size = strlen(substr);
    generated_size = 0;

    while(generated_size < size - 1) {
        if (rand() % 2 == 0) {
            for (i = 0; i < substr_size && generated_size < size; i++) {
                str[generated_size] = substr[i];
                generated_size++;
            }
        } else {
            char ch = 32 + rand() % (128 - 32);
            if(ch != '\0') {
                str[generated_size] = ch;
                generated_size++;
            }
        }
    }
    str[generated_size] = '\0';
}