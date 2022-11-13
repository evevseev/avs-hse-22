	.intel_syntax noprefix
	.text
	.section	.rodata
.LC0:
	.string	"String is too big"
.LC1:
	.string	"%c"
	.text
	.globl	read_string_from_console
	.type	read_string_from_console, @function
read_string_from_console:
	endbr64	
	push	rbp	
	mov	rbp, rsp	
	sub	rsp, 32	

	mov	DWORD PTR -20[rbp], edi	# /	max_size
	mov	eax, DWORD PTR -20[rbp]	# | / rdi =max_size
	cdqe						# | |
	mov	rdi, rax				# | \
	call	malloc@PLT			# |
	mov	QWORD PTR -16[rbp], rax	# \ str = (char *) malloc(max_size * sizeof(char))

	mov	DWORD PTR -4[rbp], 0	# i = 0,
	mov	DWORD PTR -8[rbp], 0	# eof_flag = 0,

	jmp	.L2						# < while (eof_flag != EOF)
.L4:
								# / if(i >= max_size) {
	mov	eax, DWORD PTR -4[rbp]	# | eax = i
	cmp	eax, DWORD PTR -20[rbp]	# | i ?? max_size
	jl	.L3						# \ if(i < max_size) goto .L3
       
	lea	rdi, .LC0[rip]	# / 
	call	puts@PLT	# \ printf("String is too big\n")#
        
	mov	edi, 5			# / exit(5)#
	call	exit@PLT	# \
.L3:
								# / 
	mov	eax, DWORD PTR -4[rbp]	# | tmp90, i
	movsx	rdx, eax			# | _2, tmp90
	mov	rax, QWORD PTR -16[rbp]	# | tmp91, str
	add	rax, rdx				# | _3, _2
	mov	rsi, rax				# |_3
	lea	rdi, .LC1[rip]			# |
	mov	eax, 0					# |
	call	__isoc99_scanf@PLT	# |
	mov	DWORD PTR -8[rbp], eax	# \ eof_flag = scanf("%c", &str[i])#

	add	DWORD PTR -4[rbp], 1	# < i++ 
.L2:
								# / while (eof_flag != EOF) {
	cmp	DWORD PTR -8[rbp], -1	# | eof_flag,
	jne	.L4						# \ if not, go to L4

	mov	rax, QWORD PTR -16[rbp]	# return str

	leave	
	ret	
