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
	.globl	read_array_from_file
	.type	read_array_from_file, @function
read_array_from_file:
	endbr64
	push	r14
	push	r13
	push	r12
	mov	r12d, edx
	push	rbp
	push	rbx
	mov	rbx, rdi
	mov	rdi, rsi
	lea	rsi, .LC0[rip]
	sub	rsp, 16
	call	fopen@PLT
	lea	rdx, 12[rsp]
	lea	rsi, .LC1[rip]
	mov	rdi, rax
	mov	rbp, rax
	xor	eax, eax
	call	__isoc99_fscanf@PLT
	mov	eax, DWORD PTR 12[rsp]
	cmp	eax, r12d
	jg	.L5
	xor	r13d, r13d
	lea	r14, .LC1[rip]
	test	eax, eax
	jg	.L4
.L5:
	mov	edx, r12d
	lea	rsi, .LC2[rip]
	mov	edi, 1
	xor	eax, eax
	call	__printf_chk@PLT
	mov	rdi, rbp
	call	fclose@PLT
	mov	edi, 1
	call	exit@PLT
.L4:
	mov	rdx, rbx
	mov	rsi, r14
	mov	rdi, rbp
	xor	eax, eax
	call	__isoc99_fscanf@PLT
	inc	r13d
	add	rbx, 4
	cmp	DWORD PTR 12[rsp], r13d
	jg	.L4
	mov	rdi, rbp
	call	fclose@PLT
	mov	eax, DWORD PTR 12[rsp]
	add	rsp, 16
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	ret
	.size	read_array_from_file, .-read_array_from_file
	.section	.rodata.str1.1
.LC3:
	.string	"w"
.LC4:
	.string	"%d "
	.text
	.globl	save_array_to_file
	.type	save_array_to_file, @function
save_array_to_file:
	endbr64
	push	r14
	lea	r14, .LC4[rip]
	push	r13
	mov	r13, rdi
	mov	rdi, rdx
	push	r12
	mov	r12d, esi
	lea	rsi, .LC3[rip]
	push	rbp
	push	rbx
	xor	ebx, ebx
	call	fopen@PLT
	mov	ecx, r12d
	mov	esi, 1
	lea	rdx, .LC4[rip]
	mov	rdi, rax
	mov	rbp, rax
	xor	eax, eax
	call	__fprintf_chk@PLT
.L11:
	cmp	r12d, ebx
	jle	.L14
	mov	ecx, DWORD PTR 0[r13+rbx*4]
	mov	rdx, r14
	mov	esi, 1
	mov	rdi, rbp
	xor	eax, eax
	inc	rbx
	call	__fprintf_chk@PLT
	jmp	.L11
.L14:
	mov	rsi, rbp
	mov	edi, 10
	call	fputc@PLT
	pop	rbx
	mov	rdi, rbp
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
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
