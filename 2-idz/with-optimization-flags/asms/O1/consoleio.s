	.file	"consoleio.c"
	.intel_syntax noprefix
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"Enter n: "
.LC1:
	.string	"%d"
.LC2:
	.string	"n must be in range [1, %d]\n"
	.text
	.globl	read_array_from_console
	.type	read_array_from_console, @function
read_array_from_console:
	endbr64
	push	r12
	push	rbp
	push	rbx
	sub	rsp, 16
	mov	rbx, rdi
	mov	ebp, esi
	lea	r12, 12[rsp]
	jmp	.L4
.L2:
	mov	edx, ebp
	lea	rsi, .LC2[rip]
	mov	edi, 1
	mov	eax, 0
	call	__printf_chk@PLT
.L4:
	lea	rsi, .LC0[rip]
	mov	edi, 1
	mov	eax, 0
	call	__printf_chk@PLT
	mov	rsi, r12
	lea	rdi, .LC1[rip]
	mov	eax, 0
	call	__isoc99_scanf@PLT
	mov	eax, DWORD PTR 12[rsp]
	cmp	eax, ebp
	jg	.L2
	test	eax, eax
	jle	.L2
	mov	ebp, 0
	lea	r12, .LC1[rip]
.L3:
	mov	rsi, rbx
	mov	rdi, r12
	mov	eax, 0
	call	__isoc99_scanf@PLT
	add	ebp, 1
	mov	eax, DWORD PTR 12[rsp]
	add	rbx, 4
	cmp	eax, ebp
	jg	.L3
	add	rsp, 16
	pop	rbx
	pop	rbp
	pop	r12
	ret
	.size	read_array_from_console, .-read_array_from_console
	.section	.rodata.str1.1
.LC3:
	.string	"%d "
	.text
	.globl	print_array
	.type	print_array, @function
print_array:
	endbr64
	push	r12
	push	rbp
	push	rbx
	test	esi, esi
	jle	.L8
	mov	rbx, rdi
	lea	eax, -1[rsi]
	lea	r12, 4[rdi+rax*4]
	lea	rbp, .LC3[rip]
.L9:
	mov	edx, DWORD PTR [rbx]
	mov	rsi, rbp
	mov	edi, 1
	mov	eax, 0
	call	__printf_chk@PLT
	add	rbx, 4
	cmp	rbx, r12
	jne	.L9
.L8:
	mov	edi, 10
	call	putchar@PLT
	pop	rbx
	pop	rbp
	pop	r12
	ret
	.size	print_array, .-print_array
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
