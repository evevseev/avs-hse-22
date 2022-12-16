//
// Created by efmprof on 12/15/22.
//

#ifndef CPP_SOURCE_PRODUCT_H
#define CPP_SOURCE_PRODUCT_H

/**
 * Товар
 */
struct Product {
    enum Type {
        BREAD, MILK
    };

    explicit Product(Type type) : type(type) {}

    Type type;
};

#endif //CPP_SOURCE_PRODUCT_H
