cmake_minimum_required(VERSION 3.24)
project(cpp_source)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_FLAGS -pthread)

add_executable(cpp_source
        main.cpp store/Store.cpp store/Store.h utils/Logger.cpp utils/Logger.h store/Department.cpp store/Department.h consultant/Consultant.cpp consultant/Consultant.h customer/Customer.cpp customer/Customer.h utils/SafeQueue.h product/Product.h customers-producer/CustomersProducer.h customers-producer/StreamCustomersProducer.h)
