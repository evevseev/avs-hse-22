	.file	"fileio.c"
	.intel_syntax noprefix
	.text
	.section	.rodata
.LC0:
	.string	"w"
.LC1:
	.string	"Error opening file!"
.LC2:
	.string	"%.25f\n"
	.text
	.globl	write_number_to_file
	.type	write_number_to_file, @function
write_number_to_file:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR -24[rbp], rdi
	movsd	QWORD PTR -32[rbp], xmm0
	mov	rax, QWORD PTR -24[rbp]
	lea	rsi, .LC0[rip]
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -8[rbp], rax
	cmp	QWORD PTR -8[rbp], 0
	jne	.L2
	lea	rdi, .LC1[rip]
	call	puts@PLT
	mov	edi, 1
	call	exit@PLT
.L2:
	mov	rdx, QWORD PTR -32[rbp]
	mov	rax, QWORD PTR -8[rbp]
	movq	xmm0, rdx
	lea	rsi, .LC2[rip]
	mov	rdi, rax
	mov	eax, 1
	call	fprintf@PLT
	mov	rax, QWORD PTR -8[rbp]
	mov	rdi, rax
	call	fclose@PLT
	movsd	xmm0, QWORD PTR -32[rbp]
	leave
	ret
	.size	write_number_to_file, .-write_number_to_file
	.section	.rodata
.LC3:
	.string	"r"
.LC4:
	.string	"%lf"
	.text
	.globl	read_number_from_file
	.type	read_number_from_file, @function
read_number_from_file:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR -24[rbp], rdi
	mov	rax, QWORD PTR -24[rbp]
	lea	rsi, .LC3[rip]
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -8[rbp], rax
	cmp	QWORD PTR -8[rbp], 0
	jne	.L5
	lea	rdi, .LC1[rip]
	call	puts@PLT
	mov	edi, 1
	call	exit@PLT
.L5:
	lea	rdx, -16[rbp]
	mov	rax, QWORD PTR -8[rbp]
	lea	rsi, .LC4[rip]
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_fscanf@PLT
	mov	rax, QWORD PTR -8[rbp]
	mov	rdi, rax
	call	fclose@PLT
	movsd	xmm0, QWORD PTR -16[rbp]
	leave
	ret
