	.file	"main.c"
	.intel_syntax noprefix
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC0:
	.string	"String to find was not provided"
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC1:
	.string	"-file"
	.section	.rodata.str1.8
	.align 8
.LC2:
	.string	"Usage: %s <substr> -file <input_file_path> [output_file_path]\n"
	.section	.rodata.str1.1
.LC3:
	.string	"-random"
	.section	.rodata.str1.8
	.align 8
.LC4:
	.string	"Usage: %s <substr> -random <seed> <from 0 to 300.000 string_size>\n"
	.section	.rodata.str1.1
.LC5:
	.string	"-test"
	.section	.rodata.str1.8
	.align 8
.LC6:
	.string	"Usage: %s <substr> -test <seed>\n"
	.align 8
.LC7:
	.string	"Unknown argument or in wrong position: %s\n"
	.section	.rodata.str1.1
.LC8:
	.string	"w"
.LC9:
	.string	"%ld "
	.section	.rodata.str1.8
	.align 8
.LC10:
	.string	"Time elapsed: %ld microseconds\n"
	.text
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
	mov	DWORD PTR 8[rsp], edi
	cmp	edi, 1
	jle	.L27
	mov	rbx, rsi
	mov	r13, QWORD PTR 8[rsi]
	cmp	DWORD PTR 8[rsp], 2
	je	.L28
	mov	rbp, QWORD PTR 16[rsi]
	mov	ecx, 6
	lea	rdi, .LC1[rip]
	mov	rsi, rbp
	repz cmpsb
	seta	al
	sbb	al, 0
	test	al, al
	jne	.L5
	cmp	DWORD PTR 8[rsp], 3
	jle	.L29
	mov	rdi, QWORD PTR 24[rbx]
	mov	esi, 300000
	call	read_string_from_file@PLT
	mov	r15, rax
	cmp	DWORD PTR 8[rsp], 5
	jne	.L30
	mov	rdi, QWORD PTR 32[rbx]
	lea	rsi, .LC8[rip]
	call	fopen@PLT
	mov	QWORD PTR 16[rsp], rax
	mov	DWORD PTR 28[rsp], 1
	mov	eax, 1
	mov	DWORD PTR 24[rsp], 1
.L9:
	mov	DWORD PTR 12[rsp], 0
	mov	ebp, 0
	mov	r14d, DWORD PTR 28[rsp]
	and	r14d, -3
	mov	QWORD PTR [rsp], r15
	mov	r15d, eax
	jmp	.L19
.L27:
	lea	rdi, .LC0[rip]
	call	puts@PLT
	mov	edi, 1
	call	exit@PLT
.L28:
	mov	edi, 300000
	call	read_string_from_console@PLT
	mov	r15, rax
	mov	DWORD PTR 28[rsp], 0
.L4:
	cmp	DWORD PTR 28[rsp], 1
	sete	al
	mov	QWORD PTR 16[rsp], 0
	mov	DWORD PTR 24[rsp], 1
	jmp	.L9
.L29:
	mov	rdx, QWORD PTR [rbx]
	lea	rsi, .LC2[rip]
	mov	edi, 1
	call	__printf_chk@PLT
	mov	eax, 1
	jmp	.L1
.L30:
	mov	QWORD PTR 16[rsp], 0
	mov	DWORD PTR 28[rsp], 1
	mov	eax, 1
	mov	DWORD PTR 24[rsp], 1
	jmp	.L9
.L5:
	lea	rsi, .LC3[rip]
	mov	rdi, rbp
	call	strcmp@PLT
	test	eax, eax
	jne	.L10
	cmp	DWORD PTR 8[rsp], 4
	jle	.L31
	mov	rdi, QWORD PTR 32[rbx]
	mov	edx, 10
	mov	esi, 0
	call	strtol@PLT
	mov	rbp, rax
	mov	rdi, QWORD PTR 24[rbx]
	mov	edx, 10
	mov	esi, 0
	call	strtol@PLT
	mov	r12, rax
	movsx	rdi, ebp
	call	malloc@PLT
	mov	r15, rax
	mov	rdi, QWORD PTR 8[rbx]
	mov	ecx, r12d
	mov	edx, ebp
	mov	rsi, rax
	call	generate_random_string@PLT
	mov	rdi, r15
	call	puts@PLT
	mov	DWORD PTR 28[rsp], 2
	jmp	.L4
.L31:
	mov	rdx, QWORD PTR [rbx]
	lea	rsi, .LC4[rip]
	mov	edi, 1
	call	__printf_chk@PLT
	mov	eax, 1
	jmp	.L1
.L10:
	lea	rsi, .LC5[rip]
	mov	rdi, rbp
	call	strcmp@PLT
	test	eax, eax
	jne	.L12
	cmp	DWORD PTR 8[rsp], 3
	jle	.L32
	mov	rdi, QWORD PTR 24[rbx]
	mov	edx, 10
	mov	esi, 0
	call	strtol@PLT
	mov	rbp, rax
	mov	edi, 300000
	call	malloc@PLT
	mov	r15, rax
	mov	rdi, QWORD PTR 8[rbx]
	mov	ecx, ebp
	mov	edx, 30000
	mov	rsi, rax
	call	generate_random_string@PLT
	mov	QWORD PTR 16[rsp], 0
	mov	DWORD PTR 28[rsp], 3
	mov	eax, 0
	mov	DWORD PTR 24[rsp], 40000
	jmp	.L9
.L32:
	mov	rdx, QWORD PTR [rbx]
	lea	rsi, .LC6[rip]
	mov	edi, 1
	call	__printf_chk@PLT
	mov	eax, 1
	jmp	.L1
.L12:
	mov	rdx, r13
	lea	rsi, .LC7[rip]
	mov	edi, 1
	mov	eax, 0
	call	__printf_chk@PLT
	mov	eax, 1
	jmp	.L1
.L15:
	mov	rdx, rbx
	sub	rdx, QWORD PTR [rsp]
	lea	rsi, .LC9[rip]
	mov	edi, 1
	mov	eax, 0
	call	__printf_chk@PLT
.L17:
	call	clock@PLT
	mov	r12, rax
	lea	rdi, 1[rbx]
	mov	rsi, r13
	call	my_strstr@PLT
	mov	rbx, rax
	call	clock@PLT
	add	ebp, eax
	sub	ebp, r12d
	test	rbx, rbx
	je	.L14
.L18:
	test	r14d, r14d
	je	.L15
	cmp	DWORD PTR 8[rsp], 4
	jne	.L16
	test	r15b, r15b
	jne	.L15
.L16:
	test	r15b, r15b
	je	.L17
	mov	rcx, rbx
	sub	rcx, QWORD PTR [rsp]
	lea	rdx, .LC9[rip]
	mov	esi, 1
	mov	rdi, QWORD PTR 16[rsp]
	mov	eax, 0
	call	__fprintf_chk@PLT
	jmp	.L17
.L14:
	add	DWORD PTR 12[rsp], 1
	mov	eax, DWORD PTR 12[rsp]
	cmp	DWORD PTR 24[rsp], eax
	je	.L33
.L19:
	call	clock@PLT
	mov	r12, rax
	mov	rsi, r13
	mov	rdi, QWORD PTR [rsp]
	call	my_strstr@PLT
	mov	rbx, rax
	call	clock@PLT
	add	ebp, eax
	sub	ebp, r12d
	test	rbx, rbx
	jne	.L18
	jmp	.L14
.L33:
	mov	r15, QWORD PTR [rsp]
	mov	rax, QWORD PTR 16[rsp]
	test	rax, rax
	je	.L20
	mov	rdi, rax
	call	fclose@PLT
.L20:
	cmp	DWORD PTR 28[rsp], 1
	jne	.L23
	cmp	DWORD PTR 8[rsp], 5
	jne	.L23
.L21:
	mov	rdi, r15
	call	free@PLT
	movsx	rdx, ebp
	lea	rsi, .LC10[rip]
	mov	edi, 1
	mov	eax, 0
	call	__printf_chk@PLT
	mov	eax, 0
.L1:
	add	rsp, 40
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	ret
.L23:
	mov	edi, 10
	call	putchar@PLT
	jmp	.L21
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
