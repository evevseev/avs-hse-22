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
	mov	rbp, rdi
	push	rbx
	mov	ebx, esi
	sub	rsp, 16
	lea	r12, 12[rsp]
.L4:
	lea	rsi, .LC0[rip]
	mov	edi, 1
	xor	eax, eax
	call	__printf_chk@PLT
	mov	rsi, r12
	lea	rdi, .LC1[rip]
	xor	eax, eax
	call	__isoc99_scanf@PLT
	mov	eax, DWORD PTR 12[rsp]
	cmp	eax, ebx
	jg	.L7
	test	eax, eax
	jg	.L6
.L7:
	mov	edx, ebx
	lea	rsi, .LC2[rip]
	mov	edi, 1
	xor	eax, eax
	call	__printf_chk@PLT
	jmp	.L4
.L6:
	xor	ebx, ebx
	lea	r12, .LC1[rip]
.L2:
	mov	eax, DWORD PTR 12[rsp]
	cmp	eax, ebx
	jle	.L10
	lea	rsi, 0[rbp+rbx*4]
	mov	rdi, r12
	xor	eax, eax
	inc	rbx
	call	__isoc99_scanf@PLT
	jmp	.L2
.L10:
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
	push	r13
	lea	r13, .LC3[rip]
	push	r12
	mov	r12, rdi
	push	rbp
	mov	ebp, esi
	push	rbx
	xor	ebx, ebx
	push	rdx
.L12:
	cmp	ebp, ebx
	jle	.L15
	mov	edx, DWORD PTR [r12+rbx*4]
	mov	rsi, r13
	mov	edi, 1
	xor	eax, eax
	inc	rbx
	call	__printf_chk@PLT
	jmp	.L12
.L15:
	pop	rax
	mov	edi, 10
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
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
