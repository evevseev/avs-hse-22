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
    
    mov     eax, 1      # last calculated factorial from edi
    mov     edi, 1      # previous number
    mov     esi, 2      # current number
    
factorial:
    mul     esi        # rax *= esi
    jo      end        # if pverflow happend
    mov     edi, esi
    inc     esi
    jmp     factorial
    
end:
    # Output
    mov     esi, edi                # value
    lea     rdi, format_out[rip]    # format
    xor     eax, 0                  # not using xmm
    call    printf@PLT
    
    mov	eax, 0
    pop	rbp
    ret
