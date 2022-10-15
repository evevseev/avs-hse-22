    .intel_syntax noprefix
    .section .rodata
format_out:
	.string	"%u\n"

    .text
    .globl	main
    .type	main, @function

main:
    push    rbp
    mov     rbp, rsp
    
    mov     eax, 1      # last calculated factorial of following register
    mov     edi, 1      # previous number
    mov     esi, 2      # current number
    
factorial:
    mul     esi        # multiplying rax
    jo      end         # of pverflow happend
    mov     edi, esi
    inc     esi
    jmp     factorial
    
end:
    # Вывод результата
    mov     esi, edi                # число
    lea     rdi, format_out[rip]    # формат вывода
    xor     eax, 0                  # вывод целых чисел
    call    printf@PLT
    
    mov	eax, 0
    pop	rbp
    ret
