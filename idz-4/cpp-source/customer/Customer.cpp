//
// Created by efmprof on 12/15/22.
//

#include "Customer.h"

void Customer::visitStore() {
    logger->log("[Customer #" + std::to_string(id) + "] Went to the shop");
    pthread_create(&thread, nullptr, threadFunction, this);
}

void Customer::await() {
    pthread_join(thread, nullptr);
}

void *Customer::threadFunction(void *params) {
    Customer &customer = *(Customer *) params;
    // Пока что-то не купленно
    while (!customer.list.empty()) {
        // Смотрим на первый невычеркнутый товар
        Product product_to_buy = customer.list.front();
        // Отправляемся в соответствубщий отдел и встаем в очередь
        switch (product_to_buy.type) {
            case Product::BREAD:
                customer.logger->log("[Customer #" + std::to_string(customer.id) + "] Goes in queue for Bread");
                customer.store->bread_department.processClient();
                break;
            case Product::MILK:
                customer.logger->log("[Customer #" + std::to_string(customer.id) + "] Goes in queue for Milk");
                customer.store->milk_department.processClient();
                break;
        }

        customer.logger->log("[Customer #" + std::to_string(customer.id) + "] Bought something");
        // Вычеркиваем
        customer.list.pop();
    }
    customer.logger->log("[Customer #" + std::to_string(customer.id) + "] Went out of shop");
    return nullptr;
}
