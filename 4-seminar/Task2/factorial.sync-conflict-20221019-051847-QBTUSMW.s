# Подпрограмма вычисляющая факториал: rdi - вход, rax - выход
    .intel_syntax noprefix
    .text
    .globl	factorial
factorial:
    push    rbp
    mov     rbp, rsp
    
    mov     rdi, rax    # аргумент, число факториал которого мы ищем         
    mov     eax, 1      # значение факториала
    mov     esi, 2      # next number to mult
    
factorial_loop:
    dec     rdi         # уменьшаем оставшееся кол-во проходов
    cmp     rdi, 0      # если их осталось <= 0
    jle     factorial_loop_out         # выходим из цикал, факториал найден!
    mul     rsi         # домножаем факториал на текущий множитель
    inc     rsi         # увеличиваем множитель для следующего прохода
    jmp     factorial_loop   # повторяем
    
factorial_loop_out:
    # Результат в RAX. Передаем управление обратно
    leave
    ret
