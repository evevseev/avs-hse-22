	.file	"fileio.c"
	.intel_syntax noprefix
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"r"
.LC1:
	.string	"File is too big"
.LC2:
	.string	"%c"
	.text
	.globl	read_string_from_file
	.type	read_string_from_file, @function
read_string_from_file:
	endbr64
	push	r14
	push	r13
	push	r12
	push	rbp
	push	rbx
	mov	r12d, esi
	lea	rsi, .LC0[rip]
	call	fopen@PLT
	mov	rbp, rax
	mov	edx, 2
	mov	esi, 0
	mov	rdi, rax
	call	fseek@PLT
	mov	rdi, rbp
	call	ftell@PLT
	mov	rbx, rax
	mov	edx, 0
	mov	esi, 0
	mov	rdi, rbp
	call	fseek@PLT
	mov	rdi, rbx
	call	malloc@PLT
	test	r12d, r12d
	jle	.L2
	mov	r14, rax
	mov	rbx, rax
	lea	eax, -1[r12]
	lea	r13, 1[r14+rax]
	lea	r12, .LC2[rip]
.L4:
	mov	rdx, rbx
	mov	rsi, r12
	mov	rdi, rbp
	mov	eax, 0
	call	__isoc99_fscanf@PLT
	cmp	eax, -1
	je	.L9
	add	rbx, 1
	cmp	rbx, r13
	jne	.L4
.L2:
	lea	rdi, .LC1[rip]
	call	puts@PLT
	mov	rdi, rbp
	call	fclose@PLT
	mov	edi, 5
	call	exit@PLT
.L9:
	mov	rdi, rbp
	call	fclose@PLT
	mov	rax, r14
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	ret
	.size	read_string_from_file, .-read_string_from_file
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
