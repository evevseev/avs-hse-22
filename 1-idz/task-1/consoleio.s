# read from console
	.file	"consoleio.c"
	.intel_syntax noprefix
	.text
	.section	.rodata
# Консольные подсказки
.LC0:
	.string	"Enter n: "
.LC1:
	.string	"%d"
.LC2:
	.string	"n must be in range [1, %d]\n"
	.text
	.globl	read_array_from_console
	.type	read_array_from_console, @function
read_array_from_console:
	endbr64							#

	push	rbp						# /
	mov	rbp, rsp					# \ стандартный пролог

	sub	rsp, 32						# < выделение памяти на стеке
	mov	QWORD PTR -24[rbp], rdi		# / сохранение аргументов функции, &array
	mov	DWORD PTR -28[rbp], esi		# \ max_size

.L4:								# < цикл ввода массива
	lea	rdi, .LC0[rip]				# / вывод подсказки
	mov	eax, 0						# |
	call	printf@PLT				# \ 

	lea	rax, -8[rbp]				# / = &n
	mov	rsi, rax					# |
	lea	rdi, .LC1[rip]				# | формат ввода
	mov	eax, 0						# |	
	call	__isoc99_scanf@PLT		# |
	mov	eax, DWORD PTR -8[rbp]		# \ eax = n из консоли

	test	eax, eax				# / if n <= 0
	jle	.L2							# \ goto .L2
	mov	eax, DWORD PTR -8[rbp]		# < eax = n
	cmp	DWORD PTR -28[rbp], eax		# / n >= max_size
	jge	.L3							# \ goto .L3

.L2:
	mov	eax, DWORD PTR -28[rbp]		# // 
	mov	esi, eax					# |\ esi = max_size
	lea	rdi, .LC2[rip]				# | формат вывода
	mov	eax, 0						# |
	call	printf@PLT				# \ вывод сообщения об ошибке
	jmp	.L4							# < просим ввести n еще раз

.L3:								# < цикл ввода массива
	mov	DWORD PTR -4[rbp], 0		# < i = 0
	jmp	.L5							# < goto к условию цикла
.L6:								#
	mov	eax, DWORD PTR -4[rbp]		# / 
	cdqe							# \ rax = i
	lea	rdx, 0[0+rax*4]				# < rdx = i * 4
	mov	rax, QWORD PTR -24[rbp]		# //
	add	rax, rdx					# ||
	mov	rsi, rax					# |\ rsi = &array[i]
	lea	rdi, .LC1[rip]				# | формат ввода
	mov	eax, 0						# |	получаем число из консоли
	call	__isoc99_scanf@PLT		# \

	add	DWORD PTR -4[rbp], 1		# < i++

.L5:								# < условие цикла
	mov	eax, DWORD PTR -8[rbp]		# / eax = n
	cmp	DWORD PTR -4[rbp], eax		# | if i < n
	jl	.L6							# \ goto к вводу
	mov	eax, DWORD PTR -8[rbp]		# / return n
	leave							# |
	ret								# \

# PRINT ARRAT
	.size	read_array_from_console, .-read_array_from_console
	.section	.rodata
.LC3:
	.string	"%d "
	.text
	.globl	print_array
	.type	print_array, @function
print_array:
	endbr64							# 

	push	rbp						# /
	mov	rbp, rsp					# \ стандартный пролог

	sub	rsp, 32						# < выделение памяти на стеке

	mov	QWORD PTR -24[rbp], rdi		# / сохранение аргументов функции, &array
	mov	DWORD PTR -28[rbp], esi		# \ size
	mov	DWORD PTR -4[rbp], 0		# < i = 0

	jmp	.L9							# < goto к условию цикла

.L10:								# < цикл вывода массива
	mov	eax, DWORD PTR -4[rbp]		# / 
	cdqe							# |
	lea	rdx, 0[0+rax*4]				# |
	mov	rax, QWORD PTR -24[rbp]		# |
	add	rax, rdx					# |
	mov	eax, DWORD PTR [rax]		# \ eax = array[i]

	mov	esi, eax					# / значение = array[i]
	lea	rdi, .LC3[rip]				# | формат вывода
	mov	eax, 0						# | 
	call	printf@PLT				# \ вывод значения
	add	DWORD PTR -4[rbp], 1		# < i++

.L9:								# < условие цикла
	mov	eax, DWORD PTR -4[rbp]		# /
	cmp	eax, DWORD PTR -28[rbp]		# | if i < size
	jl	.L10						# \ goto к выводу

	mov	edi, 10						# / 
	call	putchar@PLT				# \ print("\n")
	nop								#
	leave							# /
	ret								# \ return

	# служебные метки gcc 
	.size	print_array, .-print_array
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
