//
// Created by efmprof on 12/15/22.
//

#ifndef CPP_SOURCE_CONSULTANT_H
#define CPP_SOURCE_CONSULTANT_H


#include "../utils/Logger.h"
#include "../utils/SafeQueue.h"
#include <unistd.h>
#include <queue>
#include <semaphore.h>


class Consultant {
public:
    Consultant(std::string name, Logger *logger, SafeQueue<pthread_t> *queue) {
        this->logger = logger;
        this->name = name;
        this->queue = queue;

        pthread_cond_init(&avaiable_for_customer, nullptr);
        pthread_cond_init(&action_required, nullptr);

        // sem_init(&free_for_customers, 0, 0); // check second attrbute
        pthread_mutex_init(&consultant_mutex, nullptr);
        // logger->log("[Consultant #" + std::to_string(id) + "] Created");
    }


    ~Consultant() {
        pthread_cond_destroy(&avaiable_for_customer);
        pthread_cond_destroy(&action_required);

        pthread_mutex_destroy(&consultant_mutex);

        // logger->log("[Consultant #" + std::to_string(id) + "] Deleted");

    }

    pthread_cond_t avaiable_for_customer;
    sem_t free_for_customers;
    pthread_cond_t action_required;
    pthread_mutex_t consultant_mutex;

    // pthread_mutex_t *consultant_work;
    void startWork() {
        logger->log("[Consultant #" + name + "] Work start");
        pthread_create(&thread, nullptr, threadFunction, this);
    }

    void stopWork() {
        working = false;
        pthread_cond_signal(&action_required);
        pthread_join(thread, nullptr);
        logger->log("[Consultant #" + name + "] Work finish");
    }

    pthread_t previous_client;

private:
    Logger *logger;
    std::string name;
    pthread_t thread;
    SafeQueue<pthread_t> *queue;
    bool working = true;


    static void *threadFunction(void *params) {
        Consultant &cons = *(Consultant *) params;
        pthread_mutex_lock(&cons.consultant_mutex);
        //sem_post(&cons.free_for_customers);
        while (cons.working) {
            do {
                cons.logger->log("[Consultant #" + cons.name + "] Notifies that he avaiable");
                pthread_cond_broadcast(&cons.avaiable_for_customer);
                cons.logger->log("[Consultant #" + cons.name + "] Waits for action command");
                pthread_cond_wait(&cons.action_required, &cons.consultant_mutex);
                cons.logger->log("[Consultant #" + cons.name + "] Command recieved");
            } while (cons.queue->empty() && cons.working);

            cons.logger->log("[Consultant #" + cons.name + "] Do work");

            // Проверяем появились ли люди или просто проснулись
            if (!cons.queue->empty()) {
                // Обрабатываем пользователя
                cons.logger->log("[Consultant #" + cons.name + "] Customer came, working with him...");
                usleep(1000);
                cons.previous_client = cons.queue->front();
                //sem_post(&cons.free_for_customers);
            } else {
                cons.logger->log("[Consultant #" + cons.name + "] O. someone called");
            }
        }
        pthread_mutex_unlock(&cons.consultant_mutex);
        return nullptr;
    }
};


#endif //CPP_SOURCE_CONSULTANT_H
