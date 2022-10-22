#makefile for fibo.s
fibo: factorial.o
	gcc factorial.o -o factorial
fibo.o: factorial.s
	as --gstabs -o factorial.o factorial.s
