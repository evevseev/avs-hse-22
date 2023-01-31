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
	push	r13
	push	r12
	push	rbp
	push	rbx
	sub	rsp, 24
	mov	rbx, rdi
	mov	rdi, rsi
	mov	ebp, edx
	lea	rsi, .LC0[rip]
	call	fopen@PLT
	mov	r12, rax
	lea	rdx, 12[rsp]
	lea	rsi, .LC1[rip]
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_fscanf@PLT
	mov	eax, DWORD PTR 12[rsp]
	cmp	eax, ebp
	jg	.L2
	test	eax, eax
	jle	.L2
	mov	ebp, 0
	lea	r13, .LC1[rip]
.L3:
	mov	rdx, rbx
	mov	rsi, r13
	mov	rdi, r12
	mov	eax, 0
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
	mov	edx, ebp
	lea	rsi, .LC2[rip]
	mov	edi, 1
	mov	eax, 0
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
	.globl	save_array_to_file
	.type	save_array_to_file, @function
save_array_to_file:
	endbr64
	push	r13
	push	r12
	push	rbp
	push	rbx
	sub	rsp, 8
	mov	r13, rdi
	mov	r12d, esi
	mov	rdi, rdx
	lea	rsi, .LC3[rip]
	call	fopen@PLT
	mov	rbp, rax
	mov	ecx, r12d
	lea	rdx, .LC4[rip]
	mov	esi, 1
	mov	rdi, rax
	mov	eax, 0
	call	__fprintf_chk@PLT
	test	r12d, r12d
	jle	.L7
	mov	rbx, r13
	lea	eax, -1[r12]
	lea	r13, 4[r13+rax*4]
	lea	r12, .LC4[rip]
.L8:
	mov	ecx, DWORD PTR [rbx]
	mov	rdx, r12
	mov	esi, 1
	mov	rdi, rbp
	mov	eax, 0
	call	__fprintf_chk@PLT
	add	rbx, 4
	cmp	rbx, r13
	jne	.L8
.L7:
	mov	rsi, rbp
	mov	edi, 10
	call	fputc@PLT
	mov	rdi, rbp
	call	fclose@PLT
	add	rsp, 8
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	ret
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
