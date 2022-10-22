void process_array(int* array, int size) {
    int i;
    for (i = 0; i < size; ++i) {
        if (array[i] > 0) {
            break;
        }
        array[i] -= 5;
    }
}
