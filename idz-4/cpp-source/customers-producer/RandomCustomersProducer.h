//
// Created by efmprof on 12/16/22.
//

#ifndef CPP_SOURCE_RANDOMCUSTOMERSPRODUCER_H
#define CPP_SOURCE_RANDOMCUSTOMERSPRODUCER_H


#include "CustomersProducer.h"
#include "iostream"

class RandomCustomersProducer : CustomersProducer {
public:
    RandomCustomersProducer(Store *store, Logger *logger) : CustomersProducer(store, logger) {
    }

    std::vector<Customer> getCustomers(size_t qnt) override {
        srand(time(nullptr));

        std::vector<Customer> data;
        std::list<Product> products;
        size_t counter = 0;
        char ch;
        while (counter < qnt) {
            for (int i = 1; i < rand() % 10 + 1; ++i) {
                products.emplace_back(rand() % 2 == 0 ? Product::MILK : Product::BREAD);
            }
            data.emplace_back(counter++, logger, products, store);
            products.clear();
        }
        return data;
    }
};


#endif //CPP_SOURCE_RANDOMCUSTOMERSPRODUCER_H
