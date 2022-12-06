	.file	"consoleio.c"
	.intel_syntax noprefix
	.text
	.section	.rodata
.LC0:
	.string	"String is too big"
.LC1:
	.string	"%c"
	.text
	.globl	read_string_from_console
	.type	read_string_from_console, @function
read_string_from_console:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	DWORD PTR -20[rbp], edi
	mov	eax, DWORD PTR -20[rbp]
	cdqe
	mov	rdi, rax
	call	malloc@PLT
	mov	QWORD PTR -16[rbp], rax
	mov	DWORD PTR -4[rbp], 0
	mov	DWORD PTR -8[rbp], 0
	jmp	.L2
.L4:
	mov	eax, DWORD PTR -4[rbp]
	cmp	eax, DWORD PTR -20[rbp]
	jl	.L3
	lea	rdi, .LC0[rip]
	call	puts@PLT
	mov	edi, 5
	call	exit@PLT
.L3:
	mov	eax, DWORD PTR -4[rbp]
	movsx	rdx, eax
	mov	rax, QWORD PTR -16[rbp]
	add	rax, rdx
	mov	rsi, rax
	lea	rdi, .LC1[rip]
	mov	eax, 0
	call	__isoc99_scanf@PLT
	mov	DWORD PTR -8[rbp], eax
	add	DWORD PTR -4[rbp], 1
.L2:
	cmp	DWORD PTR -8[rbp], -1
	jne	.L4
	mov	rax, QWORD PTR -16[rbp]
	leave
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
