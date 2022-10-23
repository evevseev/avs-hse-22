	.file	"fileio.c"
	.intel_syntax noprefix
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"r"
.LC1:
	.string	"%d"
.LC2:
	.string	"n must be in range [1, %d]\n"
	.text
	.p2align 4
	.globl	read_array_from_file
	.type	read_array_from_file, @function
read_array_from_file:
	endbr64
	push	r13
	mov	r13d, edx
	push	r12
	push	rbp
	push	rbx
	mov	rbx, rdi
	mov	rdi, rsi
	lea	rsi, .LC0[rip]
	sub	rsp, 24
	call	fopen@PLT
	lea	rdx, 12[rsp]
	lea	rsi, .LC1[rip]
	mov	rdi, rax
	mov	r12, rax
	xor	eax, eax
	call	__isoc99_fscanf@PLT
	mov	eax, DWORD PTR 12[rsp]
	cmp	eax, r13d
	jg	.L2
	test	eax, eax
	jle	.L2
	xor	ebp, ebp
	lea	r13, .LC1[rip]
	.p2align 4,,10
	.p2align 3
.L3:
	mov	rdx, rbx
	mov	rsi, r13
	mov	rdi, r12
	xor	eax, eax
	call	__isoc99_fscanf@PLT
	add	ebp, 1
	add	rbx, 4
	cmp	DWORD PTR 12[rsp], ebp
	jg	.L3
	mov	rdi, r12
	call	fclose@PLT
	mov	eax, DWORD PTR 12[rsp]
	add	rsp, 24
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	ret
.L2:
	mov	edx, r13d
	lea	rsi, .LC2[rip]
	mov	edi, 1
	xor	eax, eax
	call	__printf_chk@PLT
	mov	rdi, r12
	call	fclose@PLT
	mov	edi, 1
	call	exit@PLT
	.size	read_array_from_file, .-read_array_from_file
	.section	.rodata.str1.1
.LC3:
	.string	"w"
.LC4:
	.string	"%d "
	.text
	.p2align 4
	.globl	save_array_to_file
	.type	save_array_to_file, @function
save_array_to_file:
	endbr64
	push	r13
	push	r12
	mov	r12d, esi
	lea	rsi, .LC3[rip]
	push	rbp
	push	rbx
	mov	rbx, rdi
	mov	rdi, rdx
	sub	rsp, 8
	call	fopen@PLT
	mov	ecx, r12d
	mov	esi, 1
	lea	rdx, .LC4[rip]
	mov	rbp, rax
	mov	rdi, rax
	xor	eax, eax
	call	__fprintf_chk@PLT
	test	r12d, r12d
	jle	.L8
	lea	eax, -1[r12]
	lea	r12, .LC4[rip]
	lea	r13, 4[rbx+rax*4]
	.p2align 4,,10
	.p2align 3
.L9:
	mov	ecx, DWORD PTR [rbx]
	mov	rdx, r12
	mov	esi, 1
	mov	rdi, rbp
	xor	eax, eax
	add	rbx, 4
	call	__fprintf_chk@PLT
	cmp	rbx, r13
	jne	.L9
.L8:
	mov	rsi, rbp
	mov	edi, 10
	call	fputc@PLT
	add	rsp, 8
	mov	rdi, rbp
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	jmp	fclose@PLT
	.size	save_array_to_file, .-save_array_to_file
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
