cmake_minimum_required(VERSION 3.20)
project(idz_3_c C)

set(CMAKE_C_STANDARD 11)

add_executable(idz_3_c main.c root_finder.c root_finder.h fileio.c fileio.h)
