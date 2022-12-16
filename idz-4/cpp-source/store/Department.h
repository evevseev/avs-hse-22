//
// Created by efmprof on 12/15/22.
//

#ifndef CPP_SOURCE_DEPARTMENT_H
#define CPP_SOURCE_DEPARTMENT_H

#include "queue"
#include "../consultant/Consultant.h"
#include "../utils/SafeQueue.h"

class Department {
public:
    Department(std::string name, Logger *logger) : name(name), logger(logger), consultant(name, logger, &queue) {
        // pthread_mutex_init(&processing_mutex, nullptr);
    }

    // Открыть отдел для покупателей
    void open();

    // Закрыть отдел
    void close();

    // Обработать покупателя
    void processClient();

    // Очередь покупателей в отделе
    SafeQueue<pthread_t> queue;


    // pthread_mutex_t processing_mutex{};

private:
    std::string name;
    Logger *logger;
    Consultant consultant;
};


#endif //CPP_SOURCE_DEPARTMENT_H
