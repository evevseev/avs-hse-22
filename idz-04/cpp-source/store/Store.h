//
// Created by efmprof on 12/15/22.
//

#ifndef CPP_SOURCE_STORE_H
#define CPP_SOURCE_STORE_H


#include "../utils/Logger.h"
#include "Department.h"

class Store {
public:
    explicit Store(Logger *logger) : logger(logger), milk_department("Milk", logger),
                                     bread_department("Bread", logger) {
    };

    // Открыть магазин
    void open();

    // Закрыть магазин
    void close();

    // Отдел хлеба
    Department bread_department;

    // Отдел молока
    Department milk_department;
private:
    Logger *logger;
};


#endif //CPP_SOURCE_STORE_H
