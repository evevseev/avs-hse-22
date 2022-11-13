	.file	"main.c"
	.intel_syntax noprefix
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"-file"
.LC1:
	.string	"Usage: %s -file <input_file_path> [output_file_path]\n"
.LC2:
	.string	"-random"
.LC3:
	.string	"Usage: %s -random <from 0 to 300.000 array_size> <rand_seed>\n"
.LC4:
	.string	"-test"
.LC5:
	.string	"Usage: %s -test <seed>\n"
.LC6:
	.string	"Unknown arguments: %s\n"
.LC7:
	.string	"Time elapsed: %ld microseconds\n"
	.section	.text.startup,"ax",@progbits
	.globl	main
	.type	main, @function
main:
	endbr64
	push	r15
	push	r14
	push	r13
	mov	r13d, edi
	push	r12
	mov	r12, rsi
	push	rbp
	push	rbx
	sub	rsp, 24
	dec	edi
	jne	.L2
	mov	esi, 300000
	lea	rdi, ARRAY[rip]
	xor	r14d, r14d
	call	read_array_from_console@PLT
	mov	ebp, eax
	jmp	.L3
.L2:
	mov	r14, QWORD PTR 8[rsi]
	lea	rsi, .LC0[rip]
	mov	rdi, r14
	call	strcmp@PLT
	test	eax, eax
	jne	.L4
	cmp	r13d, 2
	jg	.L5
	mov	rdx, QWORD PTR [r12]
	lea	rsi, .LC1[rip]
	jmp	.L29
.L5:
	mov	rsi, QWORD PTR 16[r12]
	mov	edx, 300000
	lea	rdi, ARRAY[rip]
	mov	r14d, 1
	call	read_array_from_file@PLT
	mov	ebp, eax
	jmp	.L3
.L4:
	lea	rsi, .LC2[rip]
	mov	rdi, r14
	call	strcmp@PLT
	test	eax, eax
	jne	.L7
	cmp	r13d, 3
	jg	.L8
	mov	rdx, QWORD PTR [r12]
	lea	rsi, .LC3[rip]
.L29:
	mov	edi, 1
	jmp	.L28
.L8:
	mov	rdi, QWORD PTR 16[r12]
	mov	r14d, 2
	call	atoi@PLT
	mov	rdi, QWORD PTR 24[r12]
	mov	ebp, eax
	call	atoi@PLT
	mov	esi, ebp
	lea	rdi, ARRAY[rip]
	mov	edx, eax
	call	random_fill_array@PLT
	jmp	.L3
.L7:
	lea	rsi, .LC4[rip]
	mov	rdi, r14
	call	strcmp@PLT
	mov	ebx, eax
	test	eax, eax
	jne	.L9
	cmp	r13d, 2
	jg	.L10
	mov	rdx, QWORD PTR [r12]
	lea	rsi, .LC5[rip]
	jmp	.L27
.L10:
	mov	rdi, QWORD PTR 16[r12]
	mov	r14d, 5000
	lea	r15, ARRAY[rip]
	call	atoi@PLT
	mov	edx, eax
	jmp	.L11
.L9:
	mov	rdx, r14
	lea	rsi, .LC6[rip]
.L27:
	mov	edi, 1
	xor	eax, eax
.L28:
	call	__printf_chk@PLT
	mov	eax, 1
	jmp	.L1
.L11:
	mov	esi, 300000
	mov	rdi, r15
	mov	DWORD PTR 12[rsp], edx
	call	random_fill_array@PLT
	call	clock@PLT
	mov	esi, 300000
	mov	rdi, r15
	mov	QWORD PTR [rsp], rax
	call	process_array@PLT
	call	clock@PLT
	mov	edx, DWORD PTR 12[rsp]
	add	ebx, eax
	sub	ebx, DWORD PTR [rsp]
	dec	r14d
	jne	.L11
	mov	r14d, 3
.L15:
	cmp	r14d, 1
	jne	.L13
	cmp	r13d, 3
	jne	.L12
.L14:
	mov	esi, ebp
	lea	rdi, ARRAY[rip]
	call	print_array@PLT
	jmp	.L13
.L12:
	dec	r14d
	jne	.L13
	mov	rdx, QWORD PTR 24[r12]
	mov	esi, ebp
	lea	rdi, ARRAY[rip]
	call	save_array_to_file@PLT
.L13:
	movsx	rdx, ebx
	lea	rsi, .LC7[rip]
	mov	edi, 1
	xor	eax, eax
	call	__printf_chk@PLT
	xor	eax, eax
	jmp	.L1
.L3:
	call	clock@PLT
	mov	esi, ebp
	lea	rdi, ARRAY[rip]
	mov	r15, rax
	call	process_array@PLT
	call	clock@PLT
	mov	ebx, eax
	sub	ebx, r15d
	test	r14b, 1
	je	.L14
	jmp	.L15
.L1:
	add	rsp, 24
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	ret
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
