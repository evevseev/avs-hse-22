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
	push	r12
	push	rbp
	push	rbx
	sub	rsp, 8
	mov	ebp, edi
	movsx	rdi, edi
	call	malloc@PLT
	test	ebp, ebp
	jle	.L2
	mov	r13, rax
	mov	rbx, rax
	lea	eax, -1[rbp]
	lea	r12, 1[r13+rax]
	lea	rbp, .LC1[rip]
.L4:
	mov	rsi, rbx
	mov	rdi, rbp
	mov	eax, 0
	call	__isoc99_scanf@PLT
	cmp	eax, -1
	je	.L9
	add	rbx, 1
	cmp	rbx, r12
	jne	.L4
.L2:
	lea	rdi, .LC0[rip]
	call	puts@PLT
	mov	edi, 5
	call	exit@PLT
.L9:
	mov	rax, r13
	add	rsp, 8
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
