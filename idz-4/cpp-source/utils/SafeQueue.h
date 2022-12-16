//
// Created by efmprof on 12/15/22.
//

#ifndef CPP_SOURCE_SAFEQUEUE_H
#define CPP_SOURCE_SAFEQUEUE_H


#include <queue>
#include <list>
#include <pthread.h>

/**
 * Потоко безопасная очередь
 * @tparam T Значение
 */
template<class T>
class SafeQueue {
public:
    SafeQueue() {
        pthread_mutex_init(&mutex, nullptr);
    }

    explicit SafeQueue(const std::queue<T> &data) : queue(data) {}

    explicit SafeQueue(const std::list<T> &data) : queue() {
        for (auto const &i: data) {
            queue.push(i);
        }
    }

    ~SafeQueue() {
        pthread_mutex_destroy(&mutex);
    }


    // Обойдемся без комментариев :)


    void push(T val);

    T front();

    void pop();

    size_t size();

    bool empty();

private:
    // Мьютекс для работы с очередью
    pthread_mutex_t mutex{};
    std::queue<T> queue{};
};

template<class T>
bool SafeQueue<T>::empty() {
    pthread_mutex_lock(&mutex);
    bool val = queue.empty();
    pthread_mutex_unlock(&mutex);
    return val;
}

template<class T>
size_t SafeQueue<T>::size() {
    pthread_mutex_lock(&mutex);
    T val = queue.size();
    pthread_mutex_unlock(&mutex);

    return val;
}

template<class T>
void SafeQueue<T>::pop() {
    pthread_mutex_lock(&mutex);
    queue.pop();
    pthread_mutex_unlock(&mutex);

}

template<class T>
T SafeQueue<T>::front() {
    pthread_mutex_lock(&mutex);
    T val = queue.front();
    pthread_mutex_unlock(&mutex);
    return val;
}

template<class T>
void SafeQueue<T>::push(T val) {
    pthread_mutex_lock(&mutex);
    queue.push(val);
    pthread_mutex_unlock(&mutex);

}


#endif //CPP_SOURCE_SAFEQUEUE_H
