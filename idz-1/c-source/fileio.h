#ifndef FIRST_IDZ_FILEIO_H
#define FIRST_IDZ_FILEIO_H

#include <stdio.h>

int read_array_from_file(int *array, char *filepath, int max_size);

void save_array_to_file(int *array, int size, char *filepath);

#endif
