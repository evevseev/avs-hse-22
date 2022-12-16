#include <fstream>
#include "utils/Logger.h"
#include "iostream"
#include "store/Store.h"
#include "consultant/Consultant.h"
#include "customer/Customer.h"
#include "customers-producer/StreamCustomersProducer.h"

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

int main() {
    Logger log(&std::cout);

    Store store(&log);

    std::vector<Customer> customers;

    if (true) {
        std::cout << "Введите число покупателей: ";
        size_t qnt;
        std::cin >> qnt;

        std::cout << "Введите " << qnt << " покупателей в формате \"mbmbmbm;mmmmbbb;bbbmmm;....\":\n";
        customers = StreamCustomersProducer(&std::cin, &store, &log).getCustomers(1);

    }

//    std::ifstream myfile;
//    myfile.open("../input.txt");
//    myfile.close();

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
    return 0;
}