	.intel_syntax noprefix
	.text
	.globl	process_array
	.type	process_array, @function

	# ## process_array()
	# ### Локальные перменные
	# - DWORD -4[rbp]     - i
	# - QWORD -24[rbp]    - &array
	# - DWORD -28[rbp]    - size
	# ### Параметры и возвращаемый результат
	# - rdi - &array
	# - esi - size

process_array:						
	endbr64							
	push	rbp						# / стандартный пролог
	mov	rbp, rsp					# \ 

	mov	QWORD PTR -24[rbp], rdi		# / сохраняем аргументы, &array
	mov	DWORD PTR -28[rbp], esi		# \ size
	mov	DWORD PTR -4[rbp], 0		# < i = 0
	jmp	.L2							# < переход к условию цикла

.L5:								# < тело цикла
	mov	eax, DWORD PTR -4[rbp]		# / eax = i
	cdqe							# \ системный вызов, преобразует DWORD в QWORD

	lea	rdx, 0[0+rax*4]				# < находим смещение iого элемента в массиве
	mov	rax, QWORD PTR -24[rbp]		# / rax = &array
	add	rax, rdx					# \ rax = &array[i]

	mov	eax, DWORD PTR [rax]		# < eax = значение array[i]
	test	eax, eax				# /
	jg	.L6							# \ если array[i] > 0, то переходим к .L6 (break)
	mov	eax, DWORD PTR -4[rbp]		# / eax = i
	cdqe							# \ системный вызов, преобразует DWORD в QWORD

	lea	rdx, 0[0+rax*4]				# < находим смещение iого элемента в массиве
	mov	rax, QWORD PTR -24[rbp]		# / rax = &array
	add	rax, rdx					# \ rax = &array[i]
	mov	edx, DWORD PTR [rax]		# < edx = значение array[i]
	
	mov	eax, DWORD PTR -4[rbp]		# / eax = i
	cdqe							# \ системный вызов, преобразует DWORD в QWORD
	
	lea	rcx, 0[0+rax*4]				# < находим смещение iого элемента в массиве
	mov	rax, QWORD PTR -24[rbp]		# / rax = &array
	add	rax, rcx					# \ rax = &array[i]
	sub	edx, 5						# / edx = rax - 5
	mov	DWORD PTR [rax], edx		# \ array[i] = array[i] - 5

	add	DWORD PTR -4[rbp], 1		# < i++

.L2:								# < условие цикла
	mov	eax, DWORD PTR -4[rbp]		# /
	cmp	eax, DWORD PTR -28[rbp]		# | if i < size
	jl	.L5							# | goto .L5 (обратно в цикл)
	jmp	.L7							# \ goto .L7 (выход из функции)

.L6:								# / break в цикле
	nop								# \

.L7:								# / выход из функции
	nop								# |
	pop	rbp							# |
	ret								# \
