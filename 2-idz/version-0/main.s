	.file	"main.c"
	.intel_syntax noprefix
	.text
	.section	.rodata
	.align 8
.LC0:
	.string	"String to find was not provided"
.LC1:
	.string	"-file"
	.align 8
.LC2:
	.string	"Usage: %s <substr> -file <input_file_path> [output_file_path]\n"
.LC3:
	.string	"-random"
	.align 8
.LC4:
	.string	"Usage: %s <substr> -random <seed> <from 0 to 300.000 string_size>\n"
.LC5:
	.string	"-test"
	.align 8
.LC6:
	.string	"Usage: %s <substr> -test <seed>\n"
	.align 8
.LC7:
	.string	"Unknown argument or in wrong position: %s\n"
.LC8:
	.string	"w"
.LC9:
	.string	"%ld "
	.align 8
.LC10:
	.string	"Time elapsed: %ld microseconds\n"
	.text
	.globl	main
	.type	main, @function
main:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 112
	mov	DWORD PTR -100[rbp], edi
	mov	QWORD PTR -112[rbp], rsi
	cmp	DWORD PTR -100[rbp], 1
	jg	.L2
	lea	rdi, .LC0[rip]
	call	puts@PLT
	mov	edi, 1
	call	exit@PLT
.L2:
	mov	rax, QWORD PTR -112[rbp]
	mov	rax, QWORD PTR 8[rax]
	mov	QWORD PTR -48[rbp], rax
	cmp	DWORD PTR -100[rbp], 2
	jne	.L3
	mov	edi, 300000
	call	read_string_from_console@PLT
	mov	QWORD PTR -16[rbp], rax
	mov	DWORD PTR -4[rbp], 0
	jmp	.L4
.L3:
	mov	rax, QWORD PTR -112[rbp]
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	lea	rsi, .LC1[rip]
	mov	rdi, rax
	call	strcmp@PLT
	test	eax, eax
	jne	.L5
	cmp	DWORD PTR -100[rbp], 3
	jg	.L6
	mov	rax, QWORD PTR -112[rbp]
	mov	rax, QWORD PTR [rax]
	mov	rsi, rax
	lea	rdi, .LC2[rip]
	mov	eax, 0
	call	printf@PLT
	mov	eax, 1
	jmp	.L7
.L6:
	mov	rax, QWORD PTR -112[rbp]
	mov	rax, QWORD PTR 24[rax]
	mov	QWORD PTR -64[rbp], rax
	mov	rax, QWORD PTR -64[rbp]
	mov	esi, 300000
	mov	rdi, rax
	call	read_string_from_file@PLT
	mov	QWORD PTR -16[rbp], rax
	mov	DWORD PTR -4[rbp], 1
	jmp	.L4
.L5:
	mov	rax, QWORD PTR -112[rbp]
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	lea	rsi, .LC3[rip]
	mov	rdi, rax
	call	strcmp@PLT
	test	eax, eax
	jne	.L8
	cmp	DWORD PTR -100[rbp], 4
	jg	.L9
	mov	rax, QWORD PTR -112[rbp]
	mov	rax, QWORD PTR [rax]
	mov	rsi, rax
	lea	rdi, .LC4[rip]
	mov	eax, 0
	call	printf@PLT
	mov	eax, 1
	jmp	.L7
.L9:
	mov	rax, QWORD PTR -112[rbp]
	add	rax, 32
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	atoi@PLT
	mov	DWORD PTR -56[rbp], eax
	mov	rax, QWORD PTR -112[rbp]
	add	rax, 24
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	atoi@PLT
	mov	DWORD PTR -52[rbp], eax
	mov	eax, DWORD PTR -56[rbp]
	cdqe
	mov	rdi, rax
	call	malloc@PLT
	mov	QWORD PTR -16[rbp], rax
	mov	rax, QWORD PTR -112[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	mov	ecx, DWORD PTR -52[rbp]
	mov	edx, DWORD PTR -56[rbp]
	mov	rsi, QWORD PTR -16[rbp]
	mov	rdi, rax
	call	generate_random_string@PLT
	mov	rax, QWORD PTR -16[rbp]
	mov	rdi, rax
	call	puts@PLT
	mov	DWORD PTR -4[rbp], 2
	jmp	.L4
.L8:
	mov	rax, QWORD PTR -112[rbp]
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	lea	rsi, .LC5[rip]
	mov	rdi, rax
	call	strcmp@PLT
	test	eax, eax
	jne	.L10
	cmp	DWORD PTR -100[rbp], 3
	jg	.L11
	mov	rax, QWORD PTR -112[rbp]
	mov	rax, QWORD PTR [rax]
	mov	rsi, rax
	lea	rdi, .LC6[rip]
	mov	eax, 0
	call	printf@PLT
	mov	eax, 1
	jmp	.L7
.L11:
	mov	rax, QWORD PTR -112[rbp]
	add	rax, 24
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	atoi@PLT
	mov	DWORD PTR -52[rbp], eax
	mov	edi, 300000
	call	malloc@PLT
	mov	QWORD PTR -16[rbp], rax
	mov	rax, QWORD PTR -112[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	mov	edx, DWORD PTR -52[rbp]
	mov	rsi, QWORD PTR -16[rbp]
	mov	ecx, edx
	mov	edx, 30000
	mov	rdi, rax
	call	generate_random_string@PLT
	mov	DWORD PTR -4[rbp], 3
	jmp	.L4
.L10:
	mov	rax, QWORD PTR -112[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	mov	rsi, rax
	lea	rdi, .LC7[rip]
	mov	eax, 0
	call	printf@PLT
	mov	eax, 1
	jmp	.L7
.L4:
	mov	QWORD PTR -40[rbp], 0
	cmp	DWORD PTR -4[rbp], 1
	jne	.L12
	cmp	DWORD PTR -100[rbp], 5
	jne	.L12
	mov	rax, QWORD PTR -112[rbp]
	mov	rax, QWORD PTR 32[rax]
	mov	QWORD PTR -64[rbp], rax
	mov	rax, QWORD PTR -64[rbp]
	lea	rsi, .LC8[rip]
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -40[rbp], rax
.L12:
	mov	DWORD PTR -8[rbp], 0
	cmp	DWORD PTR -4[rbp], 3
	jne	.L13
	mov	eax, 4000
	jmp	.L14
.L13:
	mov	eax, 1
.L14:
	mov	DWORD PTR -68[rbp], eax
	mov	DWORD PTR -20[rbp], 0
	jmp	.L15
.L21:
	call	clock@PLT
	mov	QWORD PTR -80[rbp], rax
	mov	rdx, QWORD PTR -48[rbp]
	mov	rax, QWORD PTR -16[rbp]
	mov	rsi, rdx
	mov	rdi, rax
	call	my_strstr@PLT
	mov	QWORD PTR -32[rbp], rax
	call	clock@PLT
	mov	QWORD PTR -88[rbp], rax
	mov	rax, QWORD PTR -88[rbp]
	mov	edx, eax
	mov	rax, QWORD PTR -80[rbp]
	sub	edx, eax
	mov	eax, DWORD PTR -8[rbp]
	add	eax, edx
	mov	DWORD PTR -8[rbp], eax
	jmp	.L16
.L20:
	cmp	DWORD PTR -4[rbp], 0
	je	.L17
	cmp	DWORD PTR -4[rbp], 2
	je	.L17
	cmp	DWORD PTR -4[rbp], 1
	jne	.L18
	cmp	DWORD PTR -100[rbp], 4
	jne	.L18
.L17:
	mov	rax, QWORD PTR -32[rbp]
	sub	rax, QWORD PTR -16[rbp]
	mov	rsi, rax
	lea	rdi, .LC9[rip]
	mov	eax, 0
	call	printf@PLT
	jmp	.L19
.L18:
	cmp	DWORD PTR -4[rbp], 1
	jne	.L19
	mov	rax, QWORD PTR -32[rbp]
	sub	rax, QWORD PTR -16[rbp]
	mov	rdx, rax
	mov	rax, QWORD PTR -40[rbp]
	lea	rsi, .LC9[rip]
	mov	rdi, rax
	mov	eax, 0
	call	fprintf@PLT
.L19:
	call	clock@PLT
	mov	QWORD PTR -80[rbp], rax
	mov	rax, QWORD PTR -32[rbp]
	lea	rdx, 1[rax]
	mov	rax, QWORD PTR -48[rbp]
	mov	rsi, rax
	mov	rdi, rdx
	call	my_strstr@PLT
	mov	QWORD PTR -32[rbp], rax
	call	clock@PLT
	mov	QWORD PTR -88[rbp], rax
	mov	rax, QWORD PTR -88[rbp]
	mov	edx, eax
	mov	rax, QWORD PTR -80[rbp]
	sub	edx, eax
	mov	eax, DWORD PTR -8[rbp]
	add	eax, edx
	mov	DWORD PTR -8[rbp], eax
.L16:
	cmp	QWORD PTR -32[rbp], 0
	jne	.L20
	add	DWORD PTR -20[rbp], 1
.L15:
	mov	eax, DWORD PTR -20[rbp]
	cmp	eax, DWORD PTR -68[rbp]
	jl	.L21
	cmp	QWORD PTR -40[rbp], 0
	je	.L22
	mov	rax, QWORD PTR -40[rbp]
	mov	rdi, rax
	call	fclose@PLT
.L22:
	cmp	DWORD PTR -4[rbp], 1
	jne	.L23
	cmp	DWORD PTR -100[rbp], 5
	je	.L24
.L23:
	mov	edi, 10
	call	putchar@PLT
.L24:
	mov	rax, QWORD PTR -16[rbp]
	mov	rdi, rax
	call	free@PLT
	mov	eax, DWORD PTR -8[rbp]
	cdqe
	mov	rsi, rax
	lea	rdi, .LC10[rip]
	mov	eax, 0
	call	printf@PLT
	mov	eax, 0
.L7:
	leave
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
