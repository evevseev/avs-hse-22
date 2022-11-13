	.file	"consoleio.c"
	.intel_syntax noprefix
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"String is too big"
.LC1:
	.string	"%c"
	.text
	.globl	read_string_from_console
	.type	read_string_from_console, @function
read_string_from_console:
	endbr64
	push	r13
	movsx	rdi, edi
	lea	r13, .LC1[rip]
	push	r12
	push	rbp
	mov	rbp, rdi
	push	rbx
	xor	ebx, ebx
	push	rcx
	call	malloc@PLT
	mov	r12, rax
.L3:
	cmp	ebp, ebx
	jg	.L2
	lea	rdi, .LC0[rip]
	call	puts@PLT
	mov	edi, 5
	call	exit@PLT
.L2:
	lea	rsi, [r12+rbx]
	xor	eax, eax
	mov	rdi, r13
	inc	rbx
	call	__isoc99_scanf@PLT
	inc	eax
	jne	.L3
	pop	rdx
	mov	rax, r12
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	ret
	.size	read_string_from_console, .-read_string_from_console
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:
