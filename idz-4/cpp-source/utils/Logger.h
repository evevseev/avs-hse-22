//
// Created by efmprof on 12/15/22.
//

#ifndef CPP_SOURCE_LOGGER_H
#define CPP_SOURCE_LOGGER_H

#include "pthread.h"
#include "ostream"

class Logger {
public:
    Logger(std::ostream *output_stream) {
        stream = output_stream;
        pthread_mutex_init(&out_mutex, nullptr);

    }

    ~Logger() {
       pthread_mutex_destroy(&out_mutex);
    }

    void log(std::string text) {
//        pthread_mutex_lock(&out_mutex);
//        *stream << text << "\n";
//        pthread_mutex_unlock(&out_mutex);
    }

private:
    std::ostream *stream;
    pthread_mutex_t out_mutex;
};


#endif //CPP_SOURCE_LOGGER_H
