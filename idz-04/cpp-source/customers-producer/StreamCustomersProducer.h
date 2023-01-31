//
// Created by efmprof on 12/16/22.
//

#ifndef CPP_SOURCE_STREAMCUSTOMERSPRODUCER_H
#define CPP_SOURCE_STREAMCUSTOMERSPRODUCER_H


#include "CustomersProducer.h"
#include "iostream"

class StreamCustomersProducer : CustomersProducer {
public:
    StreamCustomersProducer(std::istream *stream, Store *store, Logger* logger) : CustomersProducer(store, logger), stream(stream) {
    }

    std::vector<Customer> getCustomers(size_t qnt) override {
        std::vector<Customer> data;

        std::list<Product> products;
        size_t counter = 0;
        char ch;
        while (counter < qnt && *stream >> ch) {
            ch = (char) tolower(ch);
            if (ch == ';') {
                data.emplace_back(counter++, logger, products, store);
                products.clear();
            } else if (ch == 'm') {
                products.emplace_back(Product::MILK);
            } else if (ch == 'b') {
                products.emplace_back(Product::BREAD);
            }
        }
        return data;
    }

private:
    std::istream *stream;
};


#endif //CPP_SOURCE_STREAMCUSTOMERSPRODUCER_H
