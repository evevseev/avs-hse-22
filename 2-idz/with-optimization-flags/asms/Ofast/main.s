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
	.section	.text.startup,"ax",@progbits
	.p2align 4
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
	je	.L22
	mov	r12, QWORD PTR 8[rsi]
	mov	ebx, edi
	mov	rbp, rsi
	mov	ecx, 6
	lea	rdi, .LC0[rip]
	mov	rsi, r12
	repz cmpsb
	seta	al
	sbb	al, 0
	test	al, al
	jne	.L4
	cmp	ebx, 2
	jle	.L23
	mov	rsi, QWORD PTR 16[rbp]
	mov	edx, 300000
	lea	rdi, ARRAY[rip]
	call	read_array_from_file@PLT
	mov	r12d, eax
	call	clock@PLT
	mov	esi, r12d
	lea	rdi, ARRAY[rip]
	mov	r13, rax
	call	process_array@PLT
	call	clock@PLT
	mov	r14d, eax
	sub	r14d, r13d
	cmp	ebx, 3
	jne	.L24
.L7:
	mov	esi, r12d
	lea	rdi, ARRAY[rip]
	call	print_array@PLT
.L14:
	movsx	rdx, r14d
	lea	rsi, .LC7[rip]
	mov	edi, 1
	xor	eax, eax
	call	__printf_chk@PLT
	xor	eax, eax
.L1:
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	ret
.L4:
	lea	rsi, .LC2[rip]
	mov	rdi, r12
	call	strcmp@PLT
	test	eax, eax
	je	.L25
	lea	rsi, .LC4[rip]
	mov	rdi, r12
	call	strcmp@PLT
	mov	r14d, eax
	test	eax, eax
	jne	.L11
	cmp	ebx, 2
	jle	.L26
	mov	rdi, QWORD PTR 16[rbp]
	mov	edx, 10
	xor	esi, esi
	mov	ebp, 5000
	lea	r12, ARRAY[rip]
	call	strtol@PLT
	mov	r13d, eax
	.p2align 4,,10
	.p2align 3
.L13:
	mov	edx, r13d
	mov	esi, 300000
	mov	rdi, r12
	call	random_fill_array@PLT
	call	clock@PLT
	mov	esi, 300000
	mov	rdi, r12
	mov	rbx, rax
	call	process_array@PLT
	call	clock@PLT
	add	eax, r14d
	sub	eax, ebx
	mov	r14d, eax
	sub	ebp, 1
	jne	.L13
	jmp	.L14
.L22:
	mov	esi, 300000
	lea	rdi, ARRAY[rip]
	call	read_array_from_console@PLT
	mov	r12d, eax
.L3:
	call	clock@PLT
	mov	esi, r12d
	lea	rdi, ARRAY[rip]
	mov	rbx, rax
	call	process_array@PLT
	call	clock@PLT
	mov	r14d, eax
	sub	r14d, ebx
	jmp	.L7
.L25:
	cmp	ebx, 3
	jle	.L27
	mov	rdi, QWORD PTR 16[rbp]
	xor	esi, esi
	mov	edx, 10
	call	strtol@PLT
	mov	rdi, QWORD PTR 24[rbp]
	xor	esi, esi
	mov	edx, 10
	mov	rbx, rax
	mov	r12d, eax
	call	strtol@PLT
	mov	esi, ebx
	lea	rdi, ARRAY[rip]
	mov	rdx, rax
	call	random_fill_array@PLT
	jmp	.L3
.L23:
	mov	rdx, QWORD PTR 0[rbp]
	lea	rsi, .LC1[rip]
	mov	edi, 1
	call	__printf_chk@PLT
	mov	eax, 1
	jmp	.L1
.L27:
	mov	rdx, QWORD PTR 0[rbp]
	lea	rsi, .LC3[rip]
	mov	edi, 1
	call	__printf_chk@PLT
	mov	eax, 1
	jmp	.L1
.L26:
	mov	rdx, QWORD PTR 0[rbp]
	lea	rsi, .LC5[rip]
	mov	edi, 1
	xor	eax, eax
	call	__printf_chk@PLT
	mov	eax, 1
	jmp	.L1
.L24:
	mov	rdx, QWORD PTR 24[rbp]
	mov	esi, r12d
	lea	rdi, ARRAY[rip]
	call	save_array_to_file@PLT
	jmp	.L14
.L11:
	mov	rdx, r12
	lea	rsi, .LC6[rip]
	mov	edi, 1
	xor	eax, eax
	call	__printf_chk@PLT
	mov	eax, 1
	jmp	.L1
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
