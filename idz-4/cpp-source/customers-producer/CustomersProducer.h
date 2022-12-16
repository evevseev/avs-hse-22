//
// Created by efmprof on 12/16/22.
//

#ifndef CPP_SOURCE_CUSTOMERSPRODUCER_H
#define CPP_SOURCE_CUSTOMERSPRODUCER_H

#include "vector"
#include "../customer/Customer.h"

class CustomersProducer {
public:
    CustomersProducer(Store *store, Logger *logger) : store(store), logger(logger) {
    }
    virtual std::vector<Customer> getCustomers(size_t qnt) = 0;

protected:
    Store *store;
    Logger *logger;
};


#endif //CPP_SOURCE_CUSTOMERSPRODUCER_H
