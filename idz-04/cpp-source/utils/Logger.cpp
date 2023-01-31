//
// Created by efmprof on 12/15/22.
//

#include "Logger.h"

void Logger::log(std::string text) {
    pthread_mutex_lock(&out_mutex);
    *stream << text << "\n";
    pthread_mutex_unlock(&out_mutex);
}
