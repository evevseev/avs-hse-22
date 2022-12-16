//
// Created by efmprof on 12/15/22.
//

#ifndef CPP_SOURCE_PRODUCT_H
#define CPP_SOURCE_PRODUCT_H


struct Product {
    enum Type {
        BREAD, MILK
    };

    Product(Type type) : type(type) {}

    Type type;
};


#endif //CPP_SOURCE_PRODUCT_H
