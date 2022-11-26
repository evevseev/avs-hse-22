#include <stdio.h>
#include "root_finder.h"

// Вариант 33
// Разработать программу, определяющую корень уравнения x^3−0.5x^2+0.2x − 4 = 0 методом половинного деления
// с точностью от 0,001 до 0,00000001 в диапазоне [1;3].
// Если диапазон некорректен, то подобрать корректный диапазон.

double f(double x) {
    return x * x * x - 0.5 * x * x + 0.2 * x - 4;
}

int main() {
    rf_function func = &f;
    double a = 1;
    double b = 3;
    double eps;
    scanf("%lf", &eps);
    double root = find_root(func, a, b, eps);
    printf("%.25f\n", root);
    return 0;
}
