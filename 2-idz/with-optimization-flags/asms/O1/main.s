	.file	"main.c"
	.intel_syntax noprefix
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"-file"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC1:
	.string	"Usage: %s -file <input_file_path> [output_file_path]\n"
	.section	.rodata.str1.1
.LC2:
	.string	"-random"
	.section	.rodata.str1.8
	.align 8
.LC3:
	.string	"Usage: %s -random <from 0 to 300.000 array_size> <rand_seed>\n"
	.section	.rodata.str1.1
.LC4:
	.string	"-test"
.LC5:
	.string	"Usage: %s -test <seed>\n"
.LC6:
	.string	"Unknown arguments: %s\n"
	.section	.rodata.str1.8
	.align 8
.LC7:
	.string	"Time elapsed: %ld microseconds\n"
	.text
	.globl	main
	.type	main, @function
main:
	endbr64
	push	r14
	push	r13
	push	r12
	push	rbp
	push	rbx
	cmp	edi, 1
	je	.L18
	mov	ebx, edi
	mov	rbp, rsi
	mov	r12, QWORD PTR 8[rsi]
	mov	ecx, 6
	lea	rdi, .LC0[rip]
	mov	rsi, r12
	repz cmpsb
	seta	al
	sbb	al, 0
	test	al, al
	jne	.L4
	cmp	ebx, 2
	jle	.L19
	mov	rsi, QWORD PTR 16[rbp]
	mov	edx, 300000
	lea	rdi, ARRAY[rip]
	call	read_array_from_file@PLT
	mov	r12d, eax
	call	clock@PLT
	mov	r13, rax
	mov	esi, r12d
	lea	rdi, ARRAY[rip]
	call	process_array@PLT
	call	clock@PLT
	mov	r14d, eax
	sub	r14d, r13d
	cmp	ebx, 3
	jne	.L20
.L7:
	mov	esi, r12d
	lea	rdi, ARRAY[rip]
	call	print_array@PLT
.L14:
	movsx	rdx, r14d
	lea	rsi, .LC7[rip]
	mov	edi, 1
	mov	eax, 0
	call	__printf_chk@PLT
	mov	eax, 0
.L1:
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	ret
.L18:
	mov	esi, 300000
	lea	rdi, ARRAY[rip]
	call	read_array_from_console@PLT
	mov	r12d, eax
.L3:
	call	clock@PLT
	mov	rbx, rax
	mov	esi, r12d
	lea	rdi, ARRAY[rip]
	call	process_array@PLT
	call	clock@PLT
	mov	r14d, eax
	sub	r14d, ebx
	jmp	.L7
.L19:
	mov	rdx, QWORD PTR 0[rbp]
	lea	rsi, .LC1[rip]
	mov	edi, 1
	call	__printf_chk@PLT
	mov	eax, 1
	jmp	.L1
.L4:
	lea	rsi, .LC2[rip]
	mov	rdi, r12
	call	strcmp@PLT
	test	eax, eax
	jne	.L9
	cmp	ebx, 3
	jle	.L21
	mov	rdi, QWORD PTR 16[rbp]
	mov	edx, 10
	mov	esi, 0
	call	strtol@PLT
	mov	rbx, rax
	mov	r12d, eax
	mov	rdi, QWORD PTR 24[rbp]
	mov	edx, 10
	mov	esi, 0
	call	strtol@PLT
	mov	rdx, rax
	mov	esi, ebx
	lea	rdi, ARRAY[rip]
	call	random_fill_array@PLT
	jmp	.L3
.L21:
	mov	rdx, QWORD PTR 0[rbp]
	lea	rsi, .LC3[rip]
	mov	edi, 1
	call	__printf_chk@PLT
	mov	eax, 1
	jmp	.L1
.L9:
	lea	rsi, .LC4[rip]
	mov	rdi, r12
	call	strcmp@PLT
	mov	r14d, eax
	test	eax, eax
	jne	.L11
	cmp	ebx, 2
	jle	.L22
	mov	rdi, QWORD PTR 16[rbp]
	mov	edx, 10
	mov	esi, 0
	call	strtol@PLT
	mov	r13d, eax
	mov	ebp, 5000
	lea	r12, ARRAY[rip]
.L13:
	mov	edx, r13d
	mov	esi, 300000
	mov	rdi, r12
	call	random_fill_array@PLT
	call	clock@PLT
	mov	rbx, rax
	mov	esi, 300000
	mov	rdi, r12
	call	process_array@PLT
	call	clock@PLT
	add	eax, r14d
	sub	eax, ebx
	mov	r14d, eax
	sub	ebp, 1
	jne	.L13
	jmp	.L14
.L22:
	mov	rdx, QWORD PTR 0[rbp]
	lea	rsi, .LC5[rip]
	mov	edi, 1
	mov	eax, 0
	call	__printf_chk@PLT
	mov	eax, 1
	jmp	.L1
.L11:
	mov	rdx, r12
	lea	rsi, .LC6[rip]
	mov	edi, 1
	mov	eax, 0
	call	__printf_chk@PLT
	mov	eax, 1
	jmp	.L1
.L20:
	mov	rdx, QWORD PTR 24[rbp]
	mov	esi, r12d
	lea	rdi, ARRAY[rip]
	call	save_array_to_file@PLT
	jmp	.L14
	.size	main, .-main
	.local	ARRAY
	.comm	ARRAY,4800000,32
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
