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
        //  logger->log("[Departament #" + std::to_string(id) + "] Created");
        pthread_mutex_init(&processing_mutex, nullptr);
    }

    ~Department() {
        pthread_mutex_destroy(&processing_mutex);
        // logger->log("[Departament #" + std::to_string(id) + "] Deleted");
    }

    void open() {
        logger->log("[Departament #" + name + "] Opened");
        consultant.startWork();
    }

    void close() {
        logger->log("[Departament #" + name + "] Boss goes to consultant");
        consultant.stopWork();
        logger->log("[Departament #" + name + "] Closed");
    }

    void processClient() {
        pthread_t thread = pthread_self();
        queue.push(thread);

        // awaiting when queue front = this
        pthread_mutex_lock(&consultant.consultant_mutex);

        // logger->log("[Departament #" + name + "] Notify consultant");
        // pthread_cond_signal(&consultant.action_required);
        do {
            //sem_wait(&consultant.free_for_customers);
            logger->log("[Departament #" + name + "] Notify that we need attention");
            pthread_cond_signal(&consultant.action_required);
            logger->log("[Departament #" + name + "] Wait when avaiable");
            pthread_cond_wait(&consultant.avaiable_for_customer, &consultant.consultant_mutex);
            logger->log("[Departament #" + name + "] Consultant avaiable!!! I m coming");
        } while (consultant.previous_client != thread);

        queue.pop();
        logger->log("[Departament #" + name + "] Client served");
        pthread_mutex_unlock(&consultant.consultant_mutex);
    }

    SafeQueue<pthread_t> queue;
    pthread_mutex_t processing_mutex;

private:
    std::string name;
    Logger *logger;
    Consultant consultant;
};


#endif //CPP_SOURCE_DEPARTMENT_H
