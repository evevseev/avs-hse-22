//
// Created by efmprof on 12/15/22.
//

#ifndef CPP_SOURCE_SAFEQUEUE_H
#define CPP_SOURCE_SAFEQUEUE_H


#include <queue>
#include <pthread.h>

template<class T>
class SafeQueue {
public:
    SafeQueue() {
        pthread_mutex_init(&mutex, nullptr);
    }

    explicit SafeQueue(const std::queue<T> &data) : queue(data) {}

    ~SafeQueue() {
        pthread_mutex_destroy(&mutex);
    }

    void push(T val) {
        pthread_mutex_lock(&mutex);
        queue.push(val);
        pthread_mutex_unlock(&mutex);

    }

    T front() {
        pthread_mutex_lock(&mutex);
        T val = queue.front();
        pthread_mutex_unlock(&mutex);
        return val;
    }

    void pop() {
        pthread_mutex_lock(&mutex);
        queue.pop();
        pthread_mutex_unlock(&mutex);

    }

    size_t size() {
        pthread_mutex_lock(&mutex);
        T val = queue.size();
        pthread_mutex_unlock(&mutex);

        return val;
    }

    bool empty() {
        pthread_mutex_lock(&mutex);
        bool val = queue.empty();
        pthread_mutex_unlock(&mutex);
        return val;
    }

private:
    pthread_mutex_t mutex{};
    std::queue<T> queue{};
};


#endif //CPP_SOURCE_SAFEQUEUE_H
