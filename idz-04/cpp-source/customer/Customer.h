//
// Created by efmprof on 12/15/22.
//

#ifndef CPP_SOURCE_CUSTOMER_H
#define CPP_SOURCE_CUSTOMER_H


#include <cstdlib>
#include <list>
#include <utility>
#include <thread_db.h>
#include "../utils/Logger.h"
#include "../utils/SafeQueue.h"
#include "../product/Product.h"
#include "../store/Store.h"

/**
 * Покупатель
 */
class Customer {
public:
    Customer(uint id, Logger *logger, const std::list<Product> &list, Store *store) : id(id), logger(logger),
                                                                                       list(list), store(store) {
    }

    // Отправить покупателя в магазин
    void visitStore();

    // Дождаться пока он не выйдет
    void await();

private:
    uint id;
    SafeQueue<Product> list;

    pthread_t thread{};

    Logger *logger;
    Store *store;

    // Функция потока - что будет делать покупатель
    static void *threadFunction(void *params);

};

#endif //CPP_SOURCE_CUSTOMER_H
