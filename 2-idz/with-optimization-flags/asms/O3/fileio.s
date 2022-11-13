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
	.p2align 4
	.globl	read_string_from_file
	.type	read_string_from_file, @function
read_string_from_file:
	endbr64
	push	r14
	push	r13
	lea	r13, .LC2[rip]
	push	r12
	push	rbp
	mov	ebp, esi
	lea	rsi, .LC0[rip]
	push	rbx
	xor	ebx, ebx
	call	fopen@PLT
	mov	edx, 2
	xor	esi, esi
	mov	r14, rax
	mov	rdi, rax
	call	fseek@PLT
	mov	rdi, r14
	call	ftell@PLT
	xor	edx, edx
	xor	esi, esi
	mov	rdi, r14
	mov	r12, rax
	call	fseek@PLT
	mov	rdi, r12
	call	malloc@PLT
	mov	r12, rax
	.p2align 4,,10
	.p2align 3
.L3:
	cmp	ebp, ebx
	jle	.L7
	lea	rdx, [r12+rbx]
	mov	rsi, r13
	mov	rdi, r14
	xor	eax, eax
	call	__isoc99_fscanf@PLT
	add	rbx, 1
	cmp	eax, -1
	jne	.L3
	mov	rdi, r14
	call	fclose@PLT
	pop	rbx
	mov	rax, r12
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	ret
.L7:
	lea	rdi, .LC1[rip]
	call	puts@PLT
	mov	rdi, r14
	call	fclose@PLT
	mov	edi, 5
	call	exit@PLT
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
