//
// Created by efmprof on 12/15/22.
//

#ifndef CPP_SOURCE_CONSULTANT_H
#define CPP_SOURCE_CONSULTANT_H


#include "../utils/Logger.h"
#include "../utils/SafeQueue.h"
#include <unistd.h>
#include <queue>
#include <utility>
#include <semaphore.h>


/**
 * Консультант
 */
class Consultant {
public:
    Consultant(std::string name, Logger *logger, SafeQueue<pthread_t> *queue) {
        this->logger = logger;
        this->name = std::move(name);
        this->queue = queue;

        pthread_cond_init(&available_for_customer, nullptr);
        pthread_cond_init(&action_required, nullptr);
        pthread_mutex_init(&consultant_mutex, nullptr);
    }


    ~Consultant() {
        pthread_cond_destroy(&available_for_customer);
        pthread_cond_destroy(&action_required);

        pthread_mutex_destroy(&consultant_mutex);
    }

    // Условная переменная, отправляет сигнал о том, что Консультант готов обслуживать следующего Покупателя
    pthread_cond_t available_for_customer{};

    // Условная переменная, которая будет Консультанта
    pthread_cond_t action_required{};

    // Мьютекс на работу Консультанта (с клиентом)
    pthread_mutex_t consultant_mutex{};

    // Хранит последний обработанный поток
    pthread_t previous_client{};



    // Отправить Консультанта на работу
    void startWork();

    // Отправить Консультанта на работу
    void stopWork();

private:
    Logger *logger;
    std::string name;
    bool working = true;

    pthread_t thread{};

    // Указатель на очередь отдела
    SafeQueue<pthread_t> *queue;

    // Функция потока - работа консультанта на посту
    static void *threadFunction(void *params);
};


#endif //CPP_SOURCE_CONSULTANT_H
