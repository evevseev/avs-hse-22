#include "utils/Logger.h"
#include "iostream"
#include "store/Department.h"
#include "consultant/Consultant.h"
#include "customer/Customer.h"
#include "chrono"

/*
Задача о магазине - 2 (забывчивые покупатели). В магазине работают
два отдела, каждый отдел обладает уникальным ассортиментом. В каждом
отделе работает один продавец. В магазин ходят исключительно забывчивые
покупатели, поэтому каждый покупатель носит с собой список товаров, которые желает купить. Покупатель приобретает товары точно в том порядке, в
каком они записаны в его списке. При этом товары в списке расположены в
случайном порядке, что заставляет покупателя переходить от отдела к отделу, если это требуется для совершения покупок. Продавец может обслужить
только одного покупателя за раз. Покупатель, вставший в очередь, засыпает
пока не дойдет до продавца. Продавец засыпает, если в его отделе нет покупателей, и просыпается, если появится хотя бы один. Создать многопоточное приложение, моделирующее работу магазина в течение рабочего
дня.
*/

void
fillWithRandomCustomers(std::vector<Customer> &data, size_t qnt, size_t max_list_size, Store *store, Logger *logger) {
    // srand(time(nullptr));


    data.reserve(qnt);
    for (size_t i = 0; i < qnt; ++i) {
        // size_t list_size = 1 + (rand() % max_list_size);
        size_t list_size = 2000;
        std::queue<Product> list;
        for (int j = 0; j < list_size; ++j) {
            list.emplace(rand() % 2 == 0 ? Product::BREAD : Product::MILK);
        }
        data.emplace_back(i, logger, list, store);
    }
}

int main() {
    Logger log(&std::cerr);

    Store store(&log);
//    std::queue<Product> a;
//    a.emplace(Product::BREAD);
//    std::queue<Product> b;
//    b.emplace(Product::MILK);
    std::vector<Customer> customers;
//    customers.emplace_back(0, &log, a, &store);
//    customers.emplace_back(1, &log, b, &store);
    fillWithRandomCustomers(customers, 1, 20, &store, &log);
    store.open();

    auto start = std::chrono::high_resolution_clock::now();


    for (auto &customer: customers) {
        customer.visitStore();
    }

    for (auto &customer: customers) {
        customer.await();
    }
    auto finish = std::chrono::high_resolution_clock::now();
    auto microseconds = std::chrono::duration_cast<std::chrono::microseconds>(finish - start);
    std::cout << microseconds.count() / 1000 << "µs\n";


    store.close();
    return 0;
}