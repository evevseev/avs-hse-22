#include <stdlib.h>
#include <stdio.h>

int random_fill_array(int *array, int size, int seed) {
    srand(seed);
    int i;
    for (i = 0; i < size * 3 / 4; i++) {
        array[i] = -rand() % 100;
    }
    for (; i < size; i++) {
        array[i] = rand() % 200 - 100;
    }
    return size;
}