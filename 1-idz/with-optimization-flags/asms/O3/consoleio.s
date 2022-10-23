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
	.p2align 4
	.globl	read_array_from_console
	.type	read_array_from_console, @function
read_array_from_console:
	endbr64
	push	r13
	push	r12
	lea	r12, .LC0[rip]
	push	rbp
	mov	ebp, esi
	push	rbx
	mov	rbx, rdi
	sub	rsp, 24
	lea	r13, 12[rsp]
	jmp	.L4
	.p2align 4,,10
	.p2align 3
.L2:
	mov	edx, ebp
	lea	rsi, .LC2[rip]
	mov	edi, 1
	xor	eax, eax
	call	__printf_chk@PLT
.L4:
	mov	rsi, r12
	mov	edi, 1
	xor	eax, eax
	call	__printf_chk@PLT
	mov	rsi, r13
	lea	rdi, .LC1[rip]
	xor	eax, eax
	call	__isoc99_scanf@PLT
	mov	eax, DWORD PTR 12[rsp]
	cmp	eax, ebp
	jg	.L2
	test	eax, eax
	jle	.L2
	xor	ebp, ebp
	lea	r12, .LC1[rip]
	.p2align 4,,10
	.p2align 3
.L3:
	mov	rsi, rbx
	mov	rdi, r12
	xor	eax, eax
	add	ebp, 1
	call	__isoc99_scanf@PLT
	mov	eax, DWORD PTR 12[rsp]
	add	rbx, 4
	cmp	eax, ebp
	jg	.L3
	add	rsp, 24
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	ret
	.size	read_array_from_console, .-read_array_from_console
	.section	.rodata.str1.1
.LC3:
	.string	"%d "
	.text
	.p2align 4
	.globl	print_array
	.type	print_array, @function
print_array:
	endbr64
	test	esi, esi
	jle	.L13
	lea	eax, -1[rsi]
	push	r12
	lea	r12, 4[rdi+rax*4]
	push	rbp
	lea	rbp, .LC3[rip]
	push	rbx
	mov	rbx, rdi
	.p2align 4,,10
	.p2align 3
.L10:
	mov	edx, DWORD PTR [rbx]
	mov	rsi, rbp
	mov	edi, 1
	xor	eax, eax
	add	rbx, 4
	call	__printf_chk@PLT
	cmp	rbx, r12
	jne	.L10
	pop	rbx
	mov	edi, 10
	pop	rbp
	pop	r12
	jmp	putchar@PLT
	.p2align 4,,10
	.p2align 3
.L13:
	mov	edi, 10
	jmp	putchar@PLT
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
