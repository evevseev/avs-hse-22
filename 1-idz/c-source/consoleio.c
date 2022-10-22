#include "stdio.h"

int read_array_from_console(int *array, int max_size) {
    int n;
    while (1) {
        printf("Enter n: ");
        scanf("%d", &n);
        if (n < 1 || n > 300000) {
            printf("n must be in range [1, %d]\n", max_size);
        } else {
            break;
        }
    }
    for (int i = 0; i < n; i++) {
        scanf("%d", &array[i]);
    }
    return n;
}

void print_array(int *array, int size) {
    for (int i = 0; i < size; i++) {
        printf("%d ", array[i]);
    }
    printf("\n");
}
