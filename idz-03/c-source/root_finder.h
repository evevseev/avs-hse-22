//
// Created by efmprof on 25.11.2022.
//

#ifndef IDZ_3_C_ROOT_FINDER_H
#define IDZ_3_C_ROOT_FINDER_H

typedef double (*rf_function)(double);

double find_root(rf_function func, double a, double b, double eps);

#endif //IDZ_3_C_ROOT_FINDER_H
