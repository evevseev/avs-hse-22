//
// Created by efmprof on 12/16/22.
//

#ifndef CPP_SOURCE_ARGUMENTPARSER_H
#define CPP_SOURCE_ARGUMENTPARSER_H

#include <algorithm>
#include "string"
#include "vector"

class ArgumentParser {
public:
    ArgumentParser(int &argc, char **argv) {
        for (int i = 1; i < argc; ++i)
            this->tokens.emplace_back(argv[i]);
    }

    const std::string &getCmdOption(const std::string &option) const {
        std::vector<std::string>::const_iterator itr;
        itr = std::find(this->tokens.begin(), this->tokens.end(), option);
        if (itr != this->tokens.end() && ++itr != this->tokens.end()) {
            return *itr;
        }
        static const std::string empty_string;
        return empty_string;
    }

    bool cmdOptionExists(const std::string &option) const {
        return std::find(this->tokens.begin(), this->tokens.end(), option)
               != this->tokens.end();
    }

private:
    std::vector<std::string> tokens;
};


#endif //CPP_SOURCE_ARGUMENTPARSER_H
