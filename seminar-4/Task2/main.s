    .intel_syntax noprefix
    .section .rodata
msg_in:
    .string      "Enter a number to find factorial: "
format_in:
    .string      "%u"
format_out:
	.string	"Factorial is: %u\n"
    .section .data
n:  
    .long   0
    .text
    .globl	main
    .type	main, @function
main:
    push    rbp
    mov     rbp, rsp

    # Подсказка для ввода n
    lea     rdi, msg_in[rip]
    mov     eax, 0
    call    printf@PLT

    # Ввод числа n
    lea     rdi, format_in[rip]     # адрес формата числа
    lea     rsi, n[rip]             # адрес n
    mov     eax, 0                  # не действительные числа
    call    scanf@plt               # ввод целого

    mov     rdi, n[rip]
    call    factorial

    # Вывод результата
    mov     rsi, rax                # число
    lea     rdi, format_out[rip]    # формат вывода
    xor     eax, 0                  # вывод целых чисел
    call    printf@PLT

end:
    mov	eax, 0
    pop	rbp
    ret
