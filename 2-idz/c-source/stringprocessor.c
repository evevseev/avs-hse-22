
#include <stddef.h>

char *my_strstr(char *str, const char *substr) {
    int i = 0;
    int j = 0;
    int k = 0;

    while (str[i] != '\0') {
        if (str[i] == substr[j]) {
            k = i;
            while (str[k] == substr[j]) {
                k++;
                j++;
                if (substr[j] == '\0') {
                    return &str[i];
                }
            }
            j = 0;
        }
        i++;
    }
    return NULL;
}