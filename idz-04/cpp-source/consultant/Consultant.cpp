//
// Created by efmprof on 12/15/22.
//

#include "Consultant.h"

void Consultant::startWork() {
    logger->log("[Consultant #" + name + "] Begins to work...");
    pthread_create(&thread, nullptr, threadFunction, this);
}

void Consultant::stopWork() {
    working = false;
    // Будим консултанта, чтобы тот обратил внимание, на то, что рабочий день закончился
    pthread_cond_signal(&action_required);
    // Ждем пока он прекратит работу
    pthread_join(thread, nullptr);
    logger->log("[Consultant #" + name + "] Finished work");
}

void *Consultant::threadFunction(void *params) {
    Consultant &cons = *(Consultant *) params;
    pthread_mutex_lock(&cons.consultant_mutex);
    // Пока не было команды на остановку
    while (cons.working) {
        do {
            // Говорим, что готовы обслуживать
            cons.logger->log("[Consultant #" + cons.name + "] Notifies that he avaiable");
            pthread_cond_broadcast(&cons.available_for_customer);
            // Ждем пока нас не разбудят
            cons.logger->log("[Consultant #" + cons.name + "] Waits for action command");
            pthread_cond_wait(&cons.action_required, &cons.consultant_mutex);
        } while (cons.queue->empty() && cons.working);

        cons.logger->log("[Consultant #" + cons.name + "] Is doing work");

        // Проверяем появились ли люди в очереди или просто проснулись
        if (!cons.queue->empty()) {
            // Обрабатываем покупателя
            cons.logger->log("[Consultant #" + cons.name + "] Customer came, working with him...");
            usleep(1000);
            cons.previous_client = cons.queue->front();
        } else {
            cons.logger->log("[Consultant #" + cons.name + "] Woke up, but it was not customer");
        }
    }
    pthread_mutex_unlock(&cons.consultant_mutex);
    return nullptr;
}
