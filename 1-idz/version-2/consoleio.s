	.intel_syntax noprefix
	.text
	.section	.rodata
# Консольные подсказки и формат ввода
.LC0:
	.string	"Enter n: "
.LC1:
	.string	"%d"
.LC2:
	.string	"n must be in range [1, %d]\n"
	.text
	.globl	read_array_from_console
	.type	read_array_from_console, @function

	# ## read_array_from_console()
	# ### Локальные перменные
	# - DWORD -4[rbp]     - i
	# - DWORD -8[rbp]     - n
	# - QWORD -24[rbp]    - &array
	# - DWORD -28[rbp]    - max_size
	# ### Параметры и возвращаемый результат
	# - rdi - &array
	# - esi - max_size
	# - rax (return) - array_size

	# Использование регистров
	# QWORD PTR -24[rbp] = &array => r15
	# DWORD PTR -28[rbp] = max_size => r14
	# DWORD PTR -4[rbp] = i => r13
read_array_from_console:
	endbr64							

	push	rbp						# /
	mov	rbp, rsp					# \ стандартный пролог

	sub	rsp, 16						# < выделение памяти на стеке
	mov	r15, rdi					# / сохранение аргументов функции, &array
	mov	r14d, esi					# \ max_size

.L4:								# < цикл ввода массива
	# printf()
	# rsi - value
	# rdi - format
	# eax - count of xmm values 
	lea	rdi, .LC0[rip]				# / вывод подсказки
	mov	eax, 0						# |
	call	printf@PLT				# \ 

	# __isoc99_scanf()
	# rsi - where to read
	# rdi - format
	# eax = 0 (calling convention)
	lea	rax, -8[rbp]				# / = &n
	mov	rsi, rax					# |
	lea	rdi, .LC1[rip]				# | формат ввода
	mov	eax, 0						# |	
	call	__isoc99_scanf@PLT		# |
	mov	eax, DWORD PTR -8[rbp]		# \ eax = n из консоли

	test	eax, eax				# / if n <= 0
	jle	.L2							# \ goto .L2
	mov	eax, DWORD PTR -8[rbp]		# < eax = n
	cmp	r14d, eax		# / n >= max_size
	jge	.L3							# \ goto .L3

.L2:
	# printf()
	# rsi - value
	# rdi - format
	# eax - count of xmm values 
	mov	eax, r14d					# // 
	mov	esi, eax					# |\ esi = max_size
	lea	rdi, .LC2[rip]				# | формат вывода
	mov	eax, 0						# |
	call	printf@PLT				# \ вывод сообщения об ошибке
	jmp	.L4							# < просим ввести n еще раз

.L3:								# < цикл ввода массива
	mov	r13d, 0		# < i = 0
	jmp	.L5							# < goto к условию цикла
.L6:								#
	mov	eax, r13d		# / 
	cdqe							# \ rax = i
	lea	rsi, [r15+rax*4]			# < rdx = i * 4

	# __isoc99_scanf()
	# rsi - where to read
	# rdi - format
	# eax = 0 (calling convention)
	# mov	rax, QWORD PTR -24[rbp]		# //
	# add	rax, rdx					# ||
	# mov	rsi, rax					# |\ rsi = &array[i]
	lea	rdi, .LC1[rip]				# | формат ввода
	mov	eax, 0						# |	получаем число из консоли
	call	__isoc99_scanf@PLT		# \

	add	r13, 1		# < i++

.L5:								# < условие цикла
	mov	eax, DWORD PTR -8[rbp]		# / eax = n
	cmp	r13d, eax					# | if i < n
	jl	.L6							# \ goto к вводу
	mov	eax, DWORD PTR -8[rbp]		# / return n
	leave							# |
	ret								# \

# ###############
	.size	read_array_from_console, .-read_array_from_console
	.section	.rodata
.LC3:
	.string	"%d "
	.text
	.globl	print_array
	.type	print_array, @function
	# ## print_array()
	# ### Локальные перменные
	# - DWORD -4[rbp]     - i
	# - QWORD -24[rbp]    - &array
	# - DWORD -28[rbp]    - size
	# ### Параметры и возвращаемый результат
	# - rdi - &array
	# - esi - size

	# Использование регистров
	# QWORD PTR -24[rbp] = &array => r15
	# DWORD PTR -28[rbp] = size => r14
	# DWORD PTR -4[rbp] = i => r13
print_array:
	endbr64							# 

	push	rbp						# /
	mov	rbp, rsp					# \ стандартный пролог

	# sub	rsp, 32						# < выделение памяти на стеке

	mov	r15, rdi					# / сохранение аргументов функции, &array
	mov	r14d, esi					# \ size
	mov	r13d, 0		# < i = 0

	jmp	.L9							# < goto к условию цикла

.L10:								# < цикл вывода массива
	mov	eax, r13d		# / 
	cdqe							# |
	# lea	rdx, 0[0+rax*4]				# |
	# mov	rax, QWORD PTR -24[rbp]		# |
	# add	rax, rdx					# |
	# mov	eax, DWORD PTR [r15+rax*4]	# \ eax = array[i]

	# printf()
	# rsi - value
	# rdi - format
	# eax - count of xmm values 
	mov	esi, DWORD PTR [r15+rax*4]					# / значение = array[i]
	lea	rdi, .LC3[rip]				# | формат вывода
	mov	eax, 0						# | 
	call	printf@PLT				# \ вывод значения
	add	r13d, 1		# < i++

.L9:								# < условие цикла
	mov	eax, r13d		# /
	cmp	eax, r14d		# | if i < size
	jl	.L10						# \ goto к выводу
	
	# putchar()
	# rdi - char
	mov	edi, 10						# / 
	call	putchar@PLT				# \ print('\n')
	nop								#
	leave							# /
	ret								# \ return
