	.file	"main.c"
	.intel_syntax noprefix
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"String to find was not provided"
.LC1:
	.string	"-file"
.LC2:
	.string	"Usage: %s <substr> -file <input_file_path> [output_file_path]\n"
.LC3:
	.string	"-random"
.LC4:
	.string	"Usage: %s <substr> -random <seed> <from 0 to 300.000 string_size>\n"
.LC5:
	.string	"-test"
.LC6:
	.string	"Usage: %s <substr> -test <seed>\n"
.LC7:
	.string	"Unknown argument or in wrong position: %s\n"
.LC8:
	.string	"w"
.LC9:
	.string	"%ld "
.LC10:
	.string	"Time elapsed: %ld microseconds\n"
	.section	.text.startup,"ax",@progbits
	.globl	main
	.type	main, @function
main:
	endbr64
	push	r15
	push	r14
	push	r13
	push	r12
	push	rbp
	push	rbx
	sub	rsp, 40
	cmp	edi, 1
	jg	.L2
	lea	rdi, .LC0[rip]
	call	puts@PLT
	mov	edi, 1
	call	exit@PLT
.L2:
	mov	r15, QWORD PTR 8[rsi]
	mov	r12d, edi
	mov	rbx, rsi
	cmp	edi, 2
	jne	.L3
	mov	edi, 300000
	xor	r13d, r13d
	call	read_string_from_console@PLT
	mov	rbp, rax
	jmp	.L4
.L3:
	mov	rbp, QWORD PTR 16[rsi]
	lea	rsi, .LC1[rip]
	mov	rdi, rbp
	call	strcmp@PLT
	test	eax, eax
	jne	.L5
	cmp	r12d, 3
	jne	.L6
	mov	rdx, QWORD PTR [rbx]
	lea	rsi, .LC2[rip]
	jmp	.L50
.L6:
	mov	rdi, QWORD PTR 24[rbx]
	mov	esi, 300000
	mov	r13d, 1
	call	read_string_from_file@PLT
	mov	rbp, rax
	jmp	.L4
.L5:
	lea	rsi, .LC3[rip]
	mov	rdi, rbp
	call	strcmp@PLT
	test	eax, eax
	jne	.L8
	cmp	r12d, 4
	jg	.L9
	mov	rdx, QWORD PTR [rbx]
	lea	rsi, .LC4[rip]
	jmp	.L50
.L9:
	mov	rdi, QWORD PTR 32[rbx]
	call	atoi@PLT
	mov	rdi, QWORD PTR 24[rbx]
	mov	r13d, eax
	call	atoi@PLT
	movsx	rdi, r13d
	mov	r14d, eax
	call	malloc@PLT
	mov	edx, r13d
	mov	ecx, r14d
	mov	rdi, r15
	mov	rbp, rax
	mov	rsi, rax
	mov	r13d, 2
	call	generate_random_string@PLT
	mov	rdi, rbp
	call	puts@PLT
	jmp	.L4
.L8:
	lea	rsi, .LC5[rip]
	mov	rdi, rbp
	call	strcmp@PLT
	test	eax, eax
	jne	.L10
	cmp	r12d, 3
	jne	.L11
	mov	rdx, QWORD PTR [rbx]
	lea	rsi, .LC6[rip]
.L50:
	mov	edi, 1
	jmp	.L49
.L11:
	mov	rdi, QWORD PTR 24[rbx]
	call	atoi@PLT
	mov	edi, 300000
	mov	r13d, eax
	call	malloc@PLT
	mov	ecx, r13d
	mov	edx, 30000
	mov	rdi, r15
	mov	rsi, rax
	mov	rbp, rax
	mov	r13d, 3
	call	generate_random_string@PLT
	jmp	.L4
.L10:
	mov	rdx, r15
	lea	rsi, .LC7[rip]
	mov	edi, 1
	xor	eax, eax
.L49:
	call	__printf_chk@PLT
	mov	eax, 1
	jmp	.L1
.L4:
	cmp	r13d, 1
	sete	BYTE PTR 11[rsp]
	cmp	r12d, 5
	jne	.L12
	cmp	BYTE PTR 11[rsp], 0
	je	.L12
	mov	rdi, QWORD PTR 32[rbx]
	lea	rsi, .LC8[rip]
	call	fopen@PLT
	mov	DWORD PTR 12[rsp], 1
	mov	r14, rax
	jmp	.L13
.L12:
	xor	r14d, r14d
	mov	edx, 1
	cmp	r13d, 3
	mov	eax, 40000
	cmovne	eax, edx
	mov	DWORD PTR 12[rsp], eax
.L13:
	mov	eax, r13d
	mov	DWORD PTR 24[rsp], 0
	and	eax, -3
	mov	DWORD PTR 4[rsp], 0
	mov	DWORD PTR 28[rsp], eax
.L19:
	call	clock@PLT
	mov	rsi, r15
	mov	rdi, rbp
	mov	QWORD PTR 16[rsp], rax
.L48:
	call	my_strstr@PLT
	mov	rbx, rax
	call	clock@PLT
	mov	edx, DWORD PTR 4[rsp]
	add	edx, eax
	sub	edx, DWORD PTR 16[rsp]
	mov	DWORD PTR 4[rsp], edx
	test	rbx, rbx
	je	.L52
	cmp	DWORD PTR 28[rsp], 0
	je	.L15
	cmp	r12d, 4
	jne	.L16
	cmp	BYTE PTR 11[rsp], 0
	je	.L16
.L15:
	mov	rdx, rbx
	lea	rsi, .LC9[rip]
	mov	edi, 1
	xor	eax, eax
	sub	rdx, rbp
	call	__printf_chk@PLT
	jmp	.L17
.L16:
	cmp	r13d, 1
	jne	.L17
	mov	rcx, rbx
	lea	rdx, .LC9[rip]
	mov	rdi, r14
	xor	eax, eax
	sub	rcx, rbp
	mov	esi, 1
	call	__fprintf_chk@PLT
.L17:
	call	clock@PLT
	lea	rdi, 1[rbx]
	mov	rsi, r15
	mov	QWORD PTR 16[rsp], rax
	jmp	.L48
.L52:
	inc	DWORD PTR 24[rsp]
	mov	ecx, DWORD PTR 24[rsp]
	cmp	DWORD PTR 12[rsp], ecx
	jne	.L19
	test	r14, r14
	je	.L20
	mov	rdi, r14
	call	fclose@PLT
.L20:
	dec	r13d
	jne	.L24
	cmp	r12d, 5
	je	.L21
.L24:
	mov	edi, 10
	call	putchar@PLT
.L21:
	mov	rdi, rbp
	call	free@PLT
	movsx	rdx, DWORD PTR 4[rsp]
	lea	rsi, .LC10[rip]
	xor	eax, eax
	mov	edi, 1
	call	__printf_chk@PLT
	xor	eax, eax
.L1:
	add	rsp, 40
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	ret
	.size	main, .-main
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
