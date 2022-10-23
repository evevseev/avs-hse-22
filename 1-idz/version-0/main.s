	.file	"main.c"
	.intel_syntax noprefix
	.text
	.local	ARRAY
	.comm	ARRAY,4800000,32
	.section	.rodata
.LC0:
	.string	"-file"
	.align 8
.LC1:
	.string	"Usage: %s -file <input_file_path> [output_file_path]\n"
.LC2:
	.string	"-random"
	.align 8
.LC3:
	.string	"Usage: %s -random <from 0 to 300.000 array_size> <rand_seed>\n"
.LC4:
	.string	"-test"
.LC5:
	.string	"Usage: %s -test <seed>\n"
.LC6:
	.string	"Unknown arguments: %s\n"
	.align 8
.LC7:
	.string	"Time elapsed: %ld microseconds\n"
	.text
	.globl	main
	.type	main, @function
main:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 64
	mov	DWORD PTR -52[rbp], edi
	mov	QWORD PTR -64[rbp], rsi
	cmp	DWORD PTR -52[rbp], 1
	jne	.L2
	mov	DWORD PTR -12[rbp], 0
	mov	esi, 300000
	lea	rdi, ARRAY[rip]
	call	read_array_from_console@PLT
	mov	DWORD PTR -4[rbp], eax
	jmp	.L3
.L2:
	mov	rax, QWORD PTR -64[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	lea	rsi, .LC0[rip]
	mov	rdi, rax
	call	strcmp@PLT
	test	eax, eax
	jne	.L4
	cmp	DWORD PTR -52[rbp], 2
	jg	.L5
	mov	rax, QWORD PTR -64[rbp]
	mov	rax, QWORD PTR [rax]
	mov	rsi, rax
	lea	rdi, .LC1[rip]
	mov	eax, 0
	call	printf@PLT
	mov	eax, 1
	jmp	.L6
.L5:
	mov	rax, QWORD PTR -64[rbp]
	mov	rax, QWORD PTR 16[rax]
	mov	QWORD PTR -32[rbp], rax
	mov	rax, QWORD PTR -32[rbp]
	mov	edx, 300000
	mov	rsi, rax
	lea	rdi, ARRAY[rip]
	call	read_array_from_file@PLT
	mov	DWORD PTR -4[rbp], eax
	mov	DWORD PTR -12[rbp], 1
	jmp	.L3
.L4:
	mov	rax, QWORD PTR -64[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	lea	rsi, .LC2[rip]
	mov	rdi, rax
	call	strcmp@PLT
	test	eax, eax
	jne	.L7
	cmp	DWORD PTR -52[rbp], 3
	jg	.L8
	mov	rax, QWORD PTR -64[rbp]
	mov	rax, QWORD PTR [rax]
	mov	rsi, rax
	lea	rdi, .LC3[rip]
	mov	eax, 0
	call	printf@PLT
	mov	eax, 1
	jmp	.L6
.L8:
	mov	rax, QWORD PTR -64[rbp]
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	atoi@PLT
	mov	DWORD PTR -4[rbp], eax
	mov	rax, QWORD PTR -64[rbp]
	add	rax, 24
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	atoi@PLT
	mov	DWORD PTR -8[rbp], eax
	mov	edx, DWORD PTR -8[rbp]
	mov	eax, DWORD PTR -4[rbp]
	mov	esi, eax
	lea	rdi, ARRAY[rip]
	call	random_fill_array@PLT
	mov	eax, DWORD PTR -4[rbp]
	mov	esi, eax
	lea	rdi, ARRAY[rip]
	call	print_array@PLT
	mov	DWORD PTR -12[rbp], 2
	jmp	.L3
.L7:
	mov	rax, QWORD PTR -64[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	lea	rsi, .LC4[rip]
	mov	rdi, rax
	call	strcmp@PLT
	test	eax, eax
	jne	.L9
	cmp	DWORD PTR -52[rbp], 2
	jg	.L10
	mov	rax, QWORD PTR -64[rbp]
	mov	rax, QWORD PTR [rax]
	mov	rsi, rax
	lea	rdi, .LC5[rip]
	mov	eax, 0
	call	printf@PLT
	mov	eax, 1
	jmp	.L6
.L10:
	mov	rax, QWORD PTR -64[rbp]
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	atoi@PLT
	mov	DWORD PTR -8[rbp], eax
	mov	DWORD PTR -12[rbp], 3
	jmp	.L3
.L9:
	mov	rax, QWORD PTR -64[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	mov	rsi, rax
	lea	rdi, .LC6[rip]
	mov	eax, 0
	call	printf@PLT
	mov	eax, 1
	jmp	.L6
.L3:
	mov	DWORD PTR -16[rbp], 0
	cmp	DWORD PTR -12[rbp], 3
	jne	.L11
	mov	DWORD PTR -20[rbp], 0
	jmp	.L12
.L13:
	mov	eax, DWORD PTR -8[rbp]
	mov	edx, eax
	mov	esi, 300000
	lea	rdi, ARRAY[rip]
	call	random_fill_array@PLT
	call	clock@PLT
	mov	QWORD PTR -40[rbp], rax
	mov	esi, 300000
	lea	rdi, ARRAY[rip]
	call	process_array@PLT
	call	clock@PLT
	mov	QWORD PTR -48[rbp], rax
	mov	rax, QWORD PTR -48[rbp]
	mov	edx, eax
	mov	rax, QWORD PTR -40[rbp]
	sub	edx, eax
	mov	eax, DWORD PTR -16[rbp]
	add	eax, edx
	mov	DWORD PTR -16[rbp], eax
	add	DWORD PTR -20[rbp], 1
.L12:
	cmp	DWORD PTR -20[rbp], 4999
	jle	.L13
	jmp	.L14
.L11:
	call	clock@PLT
	mov	QWORD PTR -40[rbp], rax
	mov	eax, DWORD PTR -4[rbp]
	mov	esi, eax
	lea	rdi, ARRAY[rip]
	call	process_array@PLT
	call	clock@PLT
	mov	QWORD PTR -48[rbp], rax
	mov	rax, QWORD PTR -48[rbp]
	mov	edx, eax
	mov	rax, QWORD PTR -40[rbp]
	sub	edx, eax
	mov	eax, DWORD PTR -16[rbp]
	add	eax, edx
	mov	DWORD PTR -16[rbp], eax
.L14:
	cmp	DWORD PTR -12[rbp], 0
	je	.L15
	cmp	DWORD PTR -12[rbp], 2
	je	.L15
	cmp	DWORD PTR -12[rbp], 1
	jne	.L16
	cmp	DWORD PTR -52[rbp], 3
	jne	.L16
.L15:
	mov	eax, DWORD PTR -4[rbp]
	mov	esi, eax
	lea	rdi, ARRAY[rip]
	call	print_array@PLT
	jmp	.L17
.L16:
	cmp	DWORD PTR -12[rbp], 1
	jne	.L17
	mov	rax, QWORD PTR -64[rbp]
	mov	rax, QWORD PTR 24[rax]
	mov	QWORD PTR -32[rbp], rax
	mov	rdx, QWORD PTR -32[rbp]
	mov	eax, DWORD PTR -4[rbp]
	mov	esi, eax
	lea	rdi, ARRAY[rip]
	call	save_array_to_file@PLT
.L17:
	mov	eax, DWORD PTR -16[rbp]
	cdqe
	mov	rsi, rax
	lea	rdi, .LC7[rip]
	mov	eax, 0
	call	printf@PLT
	mov	eax, 0
.L6:
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
