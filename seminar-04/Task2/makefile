# makefile for task.s
task: main.o factorial.o
	gcc -g -o program main.o factorial.o
factorial.o: factorial.s
	as --gstabs -o factorial.o factorial.s
main.o: main.s
	as --gstabs -o main.o main.s
