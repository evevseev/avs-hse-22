	.file	"fileio.c"
	.intel_syntax noprefix
	.text
	.section	.rodata
# ошибки и формат ввода
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
	
	push	rbp	 					# /
	mov	rbp, rsp					# \ стандартный пролог

	sub	rsp, 64						# < выделение памяти для массива

	mov	QWORD PTR -40[rbp], rdi		# / сохранение аргументов, &array
	mov	QWORD PTR -48[rbp], rsi		# | &filepath
	mov	DWORD PTR -52[rbp], edx		# \ max_size
	
	mov	rax, QWORD PTR -48[rbp]		# / 
	lea	rsi, .LC0[rip]				# | mode
	mov	rdi, rax					# | rdi = filepath
	call	fopen@PLT				# | открытие файла
	mov	QWORD PTR -16[rbp], rax		# \ FILE

	lea	rdx, -20[rbp]				# / &n
	mov	rax, QWORD PTR -16[rbp]		# |
	lea	rsi, .LC1[rip]				# | подсказка
	mov	rdi, rax					# |
	mov	eax, 0						# |
	call	__isoc99_fscanf@PLT		# |
	mov	eax, DWORD PTR -20[rbp]		# \ n = fscanf(file, "%d", &n)

	test	eax, eax				# / if (n < 0)
	jle	.L2							# \ goto .L2

	mov	eax, DWORD PTR -20[rbp]		# / if (max_size >= n)
	cmp	DWORD PTR -52[rbp], eax		# | 
	jge	.L3							# \ goto L3

.L2:								# < exit(1)
	mov	eax, DWORD PTR -52[rbp]		# / max_size
	mov	esi, eax					# |
	lea	rdi, .LC2[rip]				# | формат
	mov	eax, 0						# |
	call	printf@PLT				# \ printf("n must be in range [1, %d]\n", max_size)
	
	mov	rax, QWORD PTR -16[rbp]		# / Закрытие файла
	mov	rdi, rax					# |
	call	fclose@PLT				# \
	
	mov	edi, 1						# / exit(1)
	call	exit@PLT				# \

.L3:
	mov	DWORD PTR -4[rbp], 0		# < i = 0
	jmp	.L4							# < goto цикл ввода

.L5:								# < цикл ввода
	mov	eax, DWORD PTR -4[rbp]		# / rax = i
	cdqe							# \

	lea	rdx, 0[0+rax*4]				# /
	mov	rax, QWORD PTR -40[rbp]		# | 
	add	rdx, rax					# \ rdx = &array[i]

	mov	rax, QWORD PTR -16[rbp]		# / FILE 
	lea	rsi, .LC1[rip]				# | формат
	mov	rdi, rax					# | &array[i]
	mov	eax, 0						# | 
	call	__isoc99_fscanf@PLT		# \ fscanf(file, "%d", &array[i])

	add	DWORD PTR -4[rbp], 1		# < i++

.L4:								# < условие цикла
	mov	eax, DWORD PTR -20[rbp]		# /
	cmp	DWORD PTR -4[rbp], eax		# | if (i < n)
	jl	.L5							# \ goto в цикл ввода

	mov	rax, QWORD PTR -16[rbp]		# /
	mov	rdi, rax					# | Закрытие файла
	call	fclose@PLT				# \

	mov	eax, DWORD PTR -20[rbp]		# / return n
	leave							# |
	ret								# \
	.size	read_array_from_file, .-read_array_from_file
	.section	.rodata

# save array to gile
.LC3:
	.string	"w"
.LC4:
	.string	"%d "
	.text
	.globl	save_array_to_file
	.type	save_array_to_file, @function
save_array_to_file:
	endbr64							#

	push	rbp						# /
	mov	rbp, rsp					# \ стандартный пролог
	
	sub	rsp, 48						# / выделение памяти
	
	mov	QWORD PTR -24[rbp], rdi		# / сохранение аргументов, &array
	mov	DWORD PTR -28[rbp], esi		# | size
	mov	QWORD PTR -40[rbp], rdx		# \ filepath
	
	mov	rax, QWORD PTR -40[rbp]		# / 
	lea	rsi, .LC3[rip]				# |
	mov	rdi, rax					# |
	call	fopen@PLT				# |
	mov	QWORD PTR -16[rbp], rax		# \ FILE = fopen(filepath, "w")
	
	mov	edx, DWORD PTR -28[rbp]		# / edx = size
	mov	rax, QWORD PTR -16[rbp]		# | 
	lea	rsi, .LC4[rip]				# | формат
	mov	rdi, rax					# | FILE
	mov	eax, 0						# | 
	call	fprintf@PLT				# \ fprintf(FILE, "%d ", size)
	
	mov	DWORD PTR -4[rbp], 0		# / i = 0
	jmp	.L8							# \ goto цикл вывода

.L9:
	mov	eax, DWORD PTR -4[rbp]		# / 
	cdqe							# | 
	lea	rdx, 0[0+rax*4]				# |
	mov	rax, QWORD PTR -24[rbp]		# |
	add	rax, rdx					# \ rax = &array[i]
	
	mov	edx, DWORD PTR [rax]		# / edx = array[i]
	mov	rax, QWORD PTR -16[rbp]		# | 
	lea	rsi, .LC4[rip]				# |
	mov	rdi, rax					# | FILE
	mov	eax, 0						# |
	call	fprintf@PLT				# \ fprintf(FILE, "%d ", array[i])
	
	add	DWORD PTR -4[rbp], 1		# < i++

.L8: 								# < условие цикла
	mov	eax, DWORD PTR -4[rbp]		# /
	cmp	eax, DWORD PTR -28[rbp]		# | if (i < size)
	jl	.L9							# \  goto цикл вывода
	
	mov	rax, QWORD PTR -16[rbp]		# / FILE
	mov	rsi, rax					# | 
	mov	edi, 10						# |
	call	fputc@PLT				# \ перенос строки
	
	mov	rax, QWORD PTR -16[rbp]		# /
	mov	rdi, rax					# |
	call	fclose@PLT				# \ fclose(FILE)
	
	nop								# 

	leave							# / return 
	ret								# \

	# служебные метки gcc
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
