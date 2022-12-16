//
// Created by efmprof on 12/15/22.
//

#ifndef CPP_SOURCE_STORE_H
#define CPP_SOURCE_STORE_H


#include "../utils/Logger.h"
#include "Department.h"

class Store {
public:
    Store(Logger *logger) : logger(logger), milk_department("Milk", logger), bread_department("Bread", logger) {
        // logger->log("[Store] Created");
    };

    ~Store() {
        // logger->log("[Store] Deleted");
    }

    void open() {
        milk_department.open();
        bread_department.open();
        logger->log("[Store] Opened its doors");
    }

    void close() {
        logger->log("[Store] Manager went to close shop");
        milk_department.close();
        bread_department.close();
        logger->log("[Store] Closed!");
    }

   Department bread_department;
   Department milk_department;
private:
    Logger *logger;
};


#endif //CPP_SOURCE_STORE_H
