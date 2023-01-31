#include <fstream>
#include <sstream>
#include "utils/Logger.h"
#include "iostream"
#include "store/Store.h"
#include "consultant/Consultant.h"
#include "customer/Customer.h"
#include "customers-producer/StreamCustomersProducer.h"
#include "utils/ArgumentParser.h"
#include "customers-producer/RandomCustomersProducer.h"

/*
 * Вариант 19
 * Задача о магазине - 2 (забывчивые покупатели). В магазине работают
 * два отдела, каждый отдел обладает уникальным ассортиментом. В каждом
 * отделе работает один продавец. В магазин ходят исключительно забывчивые
 * покупатели, поэтому каждый покупатель носит с собой список товаров, которые желает купить. Покупатель приобретает товары точно в том порядке, в
 * каком они записаны в его списке. При этом товары в списке расположены в
 * случайном порядке, что заставляет покупателя переходить от отдела к отделу, если это требуется для совершения покупок. Продавец может обслужить
 * только одного покупателя за раз. Покупатель, вставший в очередь, засыпает
 * пока не дойдет до продавца. Продавец засыпает, если в его отделе нет покупателей, и просыпается, если появится хотя бы один. Создать многопоточное приложение, моделирующее работу магазина в течение рабочего
 * дня.
*/

int main(int argc, char **argv) {
    std::stringstream log_stream;
    Logger log(&log_stream);

    Store store(&log);

    std::vector<Customer> customers;

    auto arguments = ArgumentParser(argc, argv);

    if (argc == 1) {
        std::cout << "Введите число покупателей: ";
        size_t qnt;
        std::cin >> qnt;

        std::cout << "Введите " << qnt << " покупателей в формате \"mbmbmbm;mmmmbbb;bbbmmm;....\":\n";
        customers = StreamCustomersProducer(&std::cin, &store, &log).getCustomers(qnt);
    } else if (arguments.cmdOptionExists("--random")) {
        auto val = arguments.getCmdOption("--random");
        if (val.empty()) {
            std::cout << "Quantity was not provided \n";
            exit(2);
        }
        customers = RandomCustomersProducer(&store, &log).getCustomers(std::stoul(val));
    } else if (arguments.cmdOptionExists("--input_file")) {
        auto val = arguments.getCmdOption("--input_file");
        if (val.empty()) {
            std::cout << "Input file was not provided\n";
            exit(2);
        } else {
            std::ifstream file;
            file.open(val);
            size_t qnt;
            file >> qnt;
            customers = StreamCustomersProducer(&file, &store, &log).getCustomers(qnt);
            file.close();

        }
    } else if (arguments.cmdOptionExists("--data")) {
        auto val = arguments.getCmdOption("--data");
        if (val.empty()) {
            std::cout << "Data was not provided\n";
            exit(2);
        } else if (val[val.size() - 1] != ';') {
            std::cout << "Data should finish with ';'\n";
        } else if (!isdigit(val[0])) {
            std::cout << "Data start with number'\n";
        }

        std::stringstream ss;
        ss << val;
        size_t qnt;
        ss >> qnt;
        customers = StreamCustomersProducer(&ss, &store, &log).getCustomers(qnt);
    }


    // Открываем магазин (запускаем консультантов)
    store.open();

    // Отправляем покупателей в магазин
    for (auto &customer: customers) {
        customer.visitStore();
    }

    // Работаем до последнего покупателя
    for (auto &customer: customers) {
        customer.await();
    }

    // Закрываем магазин
    store.close();

    std::cout << log_stream.str();

    if (arguments.cmdOptionExists("--output_file")) {
        auto val = arguments.getCmdOption("--output_file");
        if (val.empty()) {
            std::cout << "Output file was not provided\n";
            exit(2);
        } else {
            std::ofstream file;
            file.open(val);
            file << log_stream.str();
            file.close();
        }
    }

    return 0;
}