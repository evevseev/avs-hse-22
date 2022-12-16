//
// Created by efmprof on 12/15/22.
//

#include "Department.h"

void Department::open() {
    logger->log("[Departament #" + name + "] Opened");
    consultant.startWork();
}

void Department::close() {
    consultant.stopWork();
    logger->log("[Departament #" + name + "] Closed");
}

void Department::processClient() {
    pthread_t thread = pthread_self();
    queue.push(thread);

    // Блокируем мьютекс работы Клиента-Консультанта
    pthread_mutex_lock(&consultant.consultant_mutex);
    do {
        logger->log("[Departament #" + name + "] Notifies Consultant that Customer need attention");
        // Отправляем уведомление о том, что нам нужна помощь, и ждем когда освободится Консультант
        pthread_cond_signal(&consultant.action_required);
        pthread_cond_wait(&consultant.available_for_customer, &consultant.consultant_mutex);
        logger->log("[Departament #" + name + "] Consultant if free. Client is coming!");

        // Повторяем, пока последний обслуженный человеком (потоком) не будет наш
    } while (consultant.previous_client != thread);

    queue.pop();
    logger->log("[Departament #" + name + "] Client has been served");
    pthread_mutex_unlock(&consultant.consultant_mutex);
}
