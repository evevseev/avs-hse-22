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

class Customer {
public:
    Customer(uint id, Logger *logger, const std::queue<Product> &list, Store *store) : id(id), logger(logger),
                                                                                       list(list), store(store) {
        logger->log("[Customer #" + std::to_string(id) + "] Created");
    }

    ~Customer() {
    }

    void visitStore() {
        logger->log("[Customer #" + std::to_string(id) + "] Went to shop");
        pthread_create(&thread, nullptr, threadFunction, this);
    }

    void await() {
        pthread_join(thread, nullptr);
    }

private:
    uint id;
    SafeQueue<Product> list;

    pthread_t thread;

    Logger *logger;
    Store *store;

    static void *threadFunction(void *params) {
        Customer &cust = *(Customer *) params;
        while (!cust.list.empty()) {
            Product product_to_buy = cust.list.front();
            switch (product_to_buy.type) {
                case Product::BREAD:
                    cust.logger->log("[Customer #" + std::to_string(cust.id) + "] Go in queue for Bread");
                    cust.store->bread_department.processClient();
                    break;
                case Product::MILK:
                    cust.logger->log("[Customer #" + std::to_string(cust.id) + "] Go in queue for Milk");
                    cust.store->milk_department.processClient();
                    break;
            }
            cust.logger->log("[Customer #" + std::to_string(cust.id) + "] Bought something");
            cust.list.pop();
        }
        cust.logger->log("[Customer #" + std::to_string(cust.id) + "] Went out of shop");
        return nullptr;
    }

};


#endif //CPP_SOURCE_CUSTOMER_H
