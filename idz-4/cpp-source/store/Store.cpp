//
// Created by efmprof on 12/15/22.
//

#include "Store.h"

void Store::open() {
    milk_department.open();
    bread_department.open();
    logger->log("[Store] Opened its doors for customer");
}

void Store::close() {
    logger->log("[Store] Manager went to close shop");
    milk_department.close();
    bread_department.close();
    logger->log("[Store] Closed!");
}
