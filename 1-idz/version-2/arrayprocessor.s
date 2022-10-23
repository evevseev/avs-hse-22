	.intel_syntax noprefix
	.text
	.globl	process_array
	.type	process_array, @function

	# ## process_array()
	# ### Локальные переменные
	# - DWORD -4[rbp]     - i
	# - QWORD -24[rbp]    - &array
	# - DWORD -28[rbp]    - size
	# ### Параметры и возвращаемый результат
	# - rdi - &array
	# - esi - size

	# Использование регистров
	# DWORD PTR -4[rbp]	= i => r8
	# QWORD PTR -24[rbp] = &array => rdi
	# DWORD PTR -29[rbp] = size => esi
process_array:						
	endbr64							
	push	rbp						# / стандартный пролог
	mov	rbp, rsp					# \ 

	mov	r8, 0						# < i = 0
	jmp	.L2							# < переход к условию цикла

.L5:								# < тело цикла
	# mov	eax, DWORD PTR -4[rbp]	# / eax = i
	# cdqe							# \ системный вызов, преобразует DWORD в QWORD

	# lea	rdx, 0[0+r8*4]				# < находим смещение iого элемента в массиве
	# mov	rax, rdi					# / rax = &array
	# add	rax, rdx					# \ rax = &array[i]

	mov	eax, DWORD PTR [rdi+r8*4]	# < eax = значение array[i]
	test	eax, eax				# /
	jg	.L6							# \ если array[i] > 0, то переходим к .L6 (break)
	
	# lea	rdx, 0[0+r8*4]				# < находим смещение iого элемента в массиве
	# mov	rax, rdi					# / rax = &array
	# add	rax, rdx					# \ rax = &array[i]
	# mov	edx, DWORD PTR [rax]		# < edx = значение array[i]
	
	# lea	rcx, 0[0+r8*4]				# < находим смещение iого элемента в массиве
	# mov	rax, rdi					# / rax = &array
	# add	rax, rcx					# \ rax = &array[i]
	sub	eax, 5						# / edx = rax - 5
	mov	DWORD PTR [rdi+r8*4], eax		# \ array[i] = array[i] - 5

	add	r8, 1		# < i++

.L2:								# < условие цикла
	cmp	r8d, esi					# / if i < size
	jl	.L5							# | goto .L5 (обратно в цикл)
	jmp	.L7							# \ goto .L7 (выход из функции)

.L6:								# / break в цикле
	nop								# \

.L7:								# / выход из функции
	nop								# |
	pop	rbp							# |
	ret								# \
