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
	.section	.text.startup,"ax",@progbits
	.p2align 4
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
	sub	rsp, 56
	mov	DWORD PTR 28[rsp], edi
	cmp	edi, 1
	jle	.L50
	cmp	DWORD PTR 28[rsp], 2
	mov	r13, QWORD PTR 8[rsi]
	mov	rbx, rsi
	je	.L51
	mov	rbp, QWORD PTR 16[rsi]
	mov	ecx, 6
	lea	rdi, .LC1[rip]
	mov	rsi, rbp
	repz cmpsb
	seta	al
	sbb	al, 0
	test	al, al
	jne	.L5
	cmp	DWORD PTR 28[rsp], 3
	je	.L52
	mov	rdi, QWORD PTR 24[rbx]
	mov	esi, 300000
	call	read_string_from_file@PLT
	cmp	DWORD PTR 28[rsp], 5
	mov	r14, rax
	jne	.L53
	mov	rdi, QWORD PTR 32[rbx]
	lea	rsi, .LC8[rip]
	call	fopen@PLT
	mov	DWORD PTR 20[rsp], 1
	mov	DWORD PTR 12[rsp], 1
	mov	QWORD PTR 40[rsp], rax
	mov	eax, 1
.L9:
	mov	ecx, DWORD PTR 20[rsp]
	mov	DWORD PTR 8[rsp], 0
	lea	r15, .LC9[rip]
	and	ecx, -3
	cmp	DWORD PTR 28[rsp], 4
	sete	dl
	mov	DWORD PTR 16[rsp], ecx
	xor	ebp, ebp
	and	edx, eax
	mov	BYTE PTR 27[rsp], dl
	.p2align 4,,10
	.p2align 3
.L22:
	call	clock@PLT
	mov	rsi, r13
	mov	rdi, r14
	mov	r12, rax
	call	my_strstr@PLT
	mov	rbx, rax
	call	clock@PLT
	add	ebp, eax
	sub	ebp, r12d
	test	rbx, rbx
	je	.L14
	mov	eax, DWORD PTR 16[rsp]
	test	eax, eax
	je	.L15
	cmp	DWORD PTR 20[rsp], 1
	je	.L16
	cmp	BYTE PTR 27[rsp], 0
	jne	.L17
	.p2align 4,,10
	.p2align 3
.L18:
	call	clock@PLT
	lea	rdi, 1[rbx]
	mov	rsi, r13
	mov	r12, rax
	call	my_strstr@PLT
	mov	rbx, rax
	call	clock@PLT
	add	eax, ebp
	sub	eax, r12d
	mov	ebp, eax
	test	rbx, rbx
	jne	.L18
.L14:
	add	DWORD PTR 8[rsp], 1
	mov	eax, DWORD PTR 8[rsp]
	cmp	DWORD PTR 12[rsp], eax
	jne	.L22
	mov	rax, QWORD PTR 40[rsp]
	test	rax, rax
	je	.L23
	mov	rdi, rax
	call	fclose@PLT
.L23:
	cmp	DWORD PTR 20[rsp], 1
	jne	.L26
	cmp	DWORD PTR 28[rsp], 5
	jne	.L26
.L24:
	mov	rdi, r14
	call	free@PLT
	movsx	rdx, ebp
	mov	edi, 1
	xor	eax, eax
	lea	rsi, .LC10[rip]
	call	__printf_chk@PLT
	xor	eax, eax
.L1:
	add	rsp, 56
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	ret
.L5:
	lea	rsi, .LC3[rip]
	mov	rdi, rbp
	call	strcmp@PLT
	test	eax, eax
	je	.L54
	lea	rsi, .LC5[rip]
	mov	rdi, rbp
	call	strcmp@PLT
	test	eax, eax
	jne	.L12
	cmp	DWORD PTR 28[rsp], 3
	je	.L55
	mov	rdi, QWORD PTR 24[rbx]
	mov	edx, 10
	xor	esi, esi
	call	strtol@PLT
	mov	edi, 300000
	mov	rbp, rax
	call	malloc@PLT
	mov	rdi, QWORD PTR 8[rbx]
	mov	ecx, ebp
	mov	edx, 30000
	mov	rsi, rax
	mov	r14, rax
	call	generate_random_string@PLT
	mov	DWORD PTR 20[rsp], 3
	xor	eax, eax
	mov	QWORD PTR 40[rsp], 0
	mov	DWORD PTR 12[rsp], 40000
	jmp	.L9
	.p2align 4,,10
	.p2align 3
.L15:
	mov	rdx, rbx
	mov	rsi, r15
	mov	edi, 1
	xor	eax, eax
	sub	rdx, r14
	call	__printf_chk@PLT
	call	clock@PLT
	lea	rdi, 1[rbx]
	mov	rsi, r13
	mov	r12, rax
	call	my_strstr@PLT
	mov	rbx, rax
	call	clock@PLT
	add	eax, ebp
	sub	eax, r12d
	mov	ebp, eax
	test	rbx, rbx
	jne	.L15
	jmp	.L14
	.p2align 4,,10
	.p2align 3
.L17:
	mov	rdx, rbx
	mov	rsi, r15
	mov	edi, 1
	xor	eax, eax
	sub	rdx, r14
	call	__printf_chk@PLT
	call	clock@PLT
	lea	rdi, 1[rbx]
	mov	rsi, r13
	mov	r12, rax
	call	my_strstr@PLT
	mov	rbx, rax
	call	clock@PLT
	add	eax, ebp
	sub	eax, r12d
	mov	ebp, eax
	test	rbx, rbx
	jne	.L17
	jmp	.L14
	.p2align 4,,10
	.p2align 3
.L16:
	cmp	BYTE PTR 27[rsp], 0
	jne	.L20
	mov	QWORD PTR 32[rsp], r14
	mov	r14, QWORD PTR 40[rsp]
	.p2align 4,,10
	.p2align 3
.L21:
	mov	rdx, r15
	mov	esi, 1
	mov	rdi, r14
	mov	rcx, rbx
	xor	eax, eax
	sub	rcx, QWORD PTR 32[rsp]
	call	__fprintf_chk@PLT
	call	clock@PLT
	lea	rdi, 1[rbx]
	mov	rsi, r13
	mov	r12, rax
	call	my_strstr@PLT
	mov	rbx, rax
	call	clock@PLT
	add	ebp, eax
	sub	ebp, r12d
	test	rbx, rbx
	jne	.L21
	mov	r14, QWORD PTR 32[rsp]
	jmp	.L14
	.p2align 4,,10
	.p2align 3
.L20:
	mov	rdx, rbx
	mov	rsi, r15
	mov	edi, 1
	xor	eax, eax
	sub	rdx, r14
	call	__printf_chk@PLT
	call	clock@PLT
	lea	rdi, 1[rbx]
	mov	rsi, r13
	mov	r12, rax
	call	my_strstr@PLT
	mov	rbx, rax
	call	clock@PLT
	add	eax, ebp
	sub	eax, r12d
	mov	ebp, eax
	test	rbx, rbx
	jne	.L20
	jmp	.L14
.L26:
	mov	edi, 10
	call	putchar@PLT
	jmp	.L24
.L51:
	mov	edi, 300000
	call	read_string_from_console@PLT
	mov	DWORD PTR 20[rsp], 0
	mov	r14, rax
.L4:
	mov	QWORD PTR 40[rsp], 0
	xor	eax, eax
	mov	DWORD PTR 12[rsp], 1
	jmp	.L9
.L54:
	cmp	DWORD PTR 28[rsp], 4
	jle	.L56
	mov	rdi, QWORD PTR 32[rbx]
	mov	edx, 10
	xor	esi, esi
	call	strtol@PLT
	mov	rdi, QWORD PTR 24[rbx]
	mov	edx, 10
	xor	esi, esi
	mov	rbp, rax
	call	strtol@PLT
	movsx	rdi, ebp
	mov	r12, rax
	call	malloc@PLT
	mov	rdi, QWORD PTR 8[rbx]
	mov	ecx, r12d
	mov	edx, ebp
	mov	r14, rax
	mov	rsi, rax
	call	generate_random_string@PLT
	mov	rdi, r14
	call	puts@PLT
	mov	DWORD PTR 20[rsp], 2
	jmp	.L4
.L52:
	mov	rdx, QWORD PTR [rbx]
	lea	rsi, .LC2[rip]
	mov	edi, 1
	call	__printf_chk@PLT
	mov	eax, 1
	jmp	.L1
.L56:
	mov	rdx, QWORD PTR [rbx]
	lea	rsi, .LC4[rip]
	mov	edi, 1
	call	__printf_chk@PLT
	mov	eax, 1
	jmp	.L1
.L53:
	mov	QWORD PTR 40[rsp], 0
	mov	eax, 1
	mov	DWORD PTR 20[rsp], 1
	mov	DWORD PTR 12[rsp], 1
	jmp	.L9
.L12:
	mov	rdx, r13
	lea	rsi, .LC7[rip]
	mov	edi, 1
	xor	eax, eax
	call	__printf_chk@PLT
	mov	eax, 1
	jmp	.L1
.L55:
	mov	rdx, QWORD PTR [rbx]
	lea	rsi, .LC6[rip]
	mov	edi, 1
	call	__printf_chk@PLT
	mov	eax, 1
	jmp	.L1
.L50:
	lea	rdi, .LC0[rip]
	call	puts@PLT
	mov	edi, 1
	call	exit@PLT
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
