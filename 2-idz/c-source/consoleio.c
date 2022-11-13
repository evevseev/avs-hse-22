#include <malloc.h>
#include <stdlib.h>
#include "stdio.h"

char* read_string_from_console(int max_size) {
    int i, eof_flag;
    char *str;

    str = (char *) malloc(max_size * sizeof(char));

    i = 0;
    eof_flag = 0;
    while (eof_flag != EOF) {
        // Reading string with scanf
        // Although it is not a fast solutions, but it handles '\n' correctly
        if(i >= max_size) {
            printf("String is too big\n");
            exit(5);
        }
        eof_flag = scanf("%c", &str[i]);
        i++;
    }
    return str;
}