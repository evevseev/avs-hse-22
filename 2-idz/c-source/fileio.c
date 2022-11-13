#include <stdio.h>
#include <stdlib.h>

char* read_string_from_file(char *file_path, int max_size) {
    FILE *file;
    long file_size;
    char *str;
    int i, eof_flag;

    file = fopen(file_path, "r");
    fseek(file, 0 , SEEK_END);
    file_size = ftell(file);
    fseek(file, 0 , SEEK_SET);

    str = (char *) malloc(file_size * sizeof(char));

    i = 0;
    eof_flag = 0;

    while (eof_flag != EOF) {
        if(i >= max_size) {
            printf("File is too big\n");
            fclose(file);
            exit(5);
        }

        eof_flag = fscanf(file, "%c", &str[i]);
        i++;
    }

    fclose(file);
    return str;
}