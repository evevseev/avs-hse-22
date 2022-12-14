

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
#include <pthread.h>
#include <vector>
#include <iostream>
#include <chrono>
#include <thread>
#include <queue>


#define CUSTOMERS_COUNT 10

enum Category {
    BREAD,
    MILK
};

struct Good {
    Good() = default;
    Good(Category category, int id) : category(category), id(id) {}

    int id;
    Category category;

    friend std::ostream &operator<<(std::ostream &os, const Good &good) {
        os << "Good " << good.id << " of category " << (good.category ? "MILK" : "BREAD");
        return os;
    }
};

struct Customer {
    Customer() = default;
    Customer(std::queue<Good> goods, int id) : goods(goods), id(id) {}
    std::queue<Good> goods;
    int id;
};

struct Consultant {
    Consultant(int id) : id(id) {};
    int id;
};

struct ShopSection {
        ShopSection() = default;
        ShopSection(Category category, Consultant consultant) : category(category), consultant(consultant) {
            pthread_cond_init(&customerInQueue, nullptr);
        }
        
        void putInQueue(Customer customer) {
            customers.emplace(customer);
            pthread_cond_signal(&customerInQueue);
            //
            
        }

        Consultant consultant;
        Category category;
        std::queue<Customer> customers;

        pthread_cond_t customerInQueue;
};

struct Shop {
    Shop(ShopSection breadSection, ShopSection milkSection) : breadSection(breadSection), milkSection(milkSection) {}

    ShopSection breadSection;
    ShopSection milkSection;
};

struct CustomerThreadPackage {
    CustomerThreadPackage(Customer customer, Shop shop) : customer(customer), shop(shop) {}
    Customer customer;
    Shop shop;
};

struct ConsultantThreadPackage {
    ConsultantThreadPackage(Consultant consultant, ShopSection shopSection) : shopSection(shopSection), consultant(consultant) {}
    ShopSection shopSection;
    Consultant consultant;
};

void *customerWorker(void *arg);
void *consultantWorker(void *arg);

int main() {
    srand(time(nullptr));

    Shop shop = Shop(ShopSection(BREAD, Consultant(0)), ShopSection(MILK, Consultant(1)));

    std::vector<CustomerThreadPackage> customerThreadPackages;
    customerThreadPackages.reserve(CUSTOMERS_COUNT);

    for (size_t i = 0; i < CUSTOMERS_COUNT; i++)
    {
        std::queue<Good> goods;
        for (size_t j = 0; j < rand() % 20; j++)
        {
            goods.emplace(rand() % 2 == 0 ? MILK : BREAD, j);
        }

        customerThreadPackages.emplace_back(Customer(std::move(goods), i), shop);
    }
    
    std::vector<pthread_t> threads = std::vector<pthread_t>(customerThreadPackages.size());

    for (size_t i = 0; i < customerThreadPackages.size(); i++)
    {
        if(pthread_create(&threads[i], nullptr, customerWorker, &customerThreadPackages[i]) != 0) { return EXIT_FAILURE; }
    }
    

    for (size_t i = 0; i < threads.size(); i++)
    {
        pthread_join(threads[i], nullptr);
    }

    return 0;
}

void *consultantWorker(void *arg) {
}

void *customerWorker(void *arg) {
    CustomerThreadPackage *package = (CustomerThreadPackage *)arg;

    std::cout << "[Customer " << package->customer.id << "] Came to the shop" << std::endl;

    while (!package->customer.goods.empty())
    {
        Good good = package->customer.goods.front();
        package->customer.goods.pop();

        std::cout << "Customer " << package->customer.id << "] Wants to buy and go in queue " << good << std::endl;
        if(good.category == BREAD) {
            package->shop.breadSection.putInQueue(package->customer);
        }
        else if(good.category == MILK) {
            package->shop.milkSection.putInQueue(package->customer);
        }

        std::cout << "Customer " << package->customer.id << "] Bought " << good << std::endl;
        std::this_thread::sleep_for(std::chrono::seconds(1));
    }

    std::cout << "[Customer " << package->customer.id << "] Left the shop" << std::endl;
    return nullptr;
}