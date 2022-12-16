//
// Created by efmprof on 12/15/22.
//

#ifndef CPP_SOURCE_LOGGER_H
#define CPP_SOURCE_LOGGER_H

#include "pthread.h"
#include "ostream"

/*
 * Logger
 */
class Logger {
public:
    explicit Logger(std::ostream *output_stream) {
        stream = output_stream;
        pthread_mutex_init(&out_mutex, nullptr);

    }

    ~Logger() {
       pthread_mutex_destroy(&out_mutex);
    }

    // Сохранить Лог
    void log(std::string text);

private:
    std::ostream *stream;

    // Мьютекс по работе с консолью
    pthread_mutex_t out_mutex{};
};


#endif //CPP_SOURCE_LOGGER_H
