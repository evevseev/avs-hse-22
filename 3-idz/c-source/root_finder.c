#include "root_finder.h"
#include <math.h>

// Finds root of a function in a given interval.
// ~ Do not use this code in real projects, as it needs optimization.
// ~ Some specific cases are not handled properly.
double find_root(rf_function func, double a, double b, double eps) {
    double x = (a + b) / 2;
    while (fabs(func(x)) > eps) {
        if (func(a) * func(x) < 0) {
            b = x;
        } else {
            a = x;
        }
        x = (a + b) / 2;
    }
    return x;
}