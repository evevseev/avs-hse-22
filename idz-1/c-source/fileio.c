#include <stdio.h>
#include <stdlib.h>

int read_array_from_file(int *array, char *filepath, int max_size) {
    int n;
    int i;
    FILE *in_file;
    in_file = fopen(filepath, "r");
    fscanf(in_file, "%d", &n);
    if (n < 1 || n > max_size) {
        printf("n must be in range [1, %d]\n", max_size);
        fclose(in_file);
        exit(1);
    }
    for (i = 0; i < n; i++) {
        fscanf(in_file, "%d", &array[i]);
    }
    fclose(in_file);
    return n;
}

void save_array_to_file(int *array, int size, char *filepath) {
    FILE *out_file;
    int i;
    out_file = fopen(filepath, "w");
    fprintf(out_file, "%d ", size);
    for (i = 0; i < size; i++) {
        fprintf(out_file, "%d ", array[i]);
    }
    fprintf(out_file, "\n");
    fclose(out_file);
}