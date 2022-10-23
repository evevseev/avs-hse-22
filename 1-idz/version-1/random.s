	.intel_syntax noprefix
	.text
	.globl	random_fill_array
	.type	random_fill_array, @function

	# ## random_fill_array()
	# ### Локальные перменные
	# - DWORD -4[rbp]     - i
	# - QWORD -24[rbp]	- &array
	# - DWORD -28[rbp]    - size
	# - DWORD -32[rbp]	- seed
	# ### Параметры и возвращаемый результат
	# - rdi - &array
	# - esi - size
	# - edx - seed
	# - rax (return) - array_size
random_fill_array:
	endbr64							# < ситемная штука
	push	rbp						# / стандартный пролог
	mov	rbp, rsp					# \	
	sub	rsp, 32						# < выделяем стек

	mov	QWORD PTR -24[rbp], rdi		# < &array
	mov	DWORD PTR -28[rbp], esi		# < size
	mov	DWORD PTR -32[rbp], edx		# < seed

	# srand()
	# rdi - seed
	mov	eax, DWORD PTR -32[rbp]		# / /1ый аргумент, seed
	mov	edi, eax					# | \
	call	srand@PLT				# \ srand(seed)

	mov	DWORD PTR -4[rbp], 0		# < i = 0
	jmp	.L2							# < goto L2 (loop begining)

# Первый цикл
.L3:
	# rand()
	# rax - result
	call	rand@PLT				# /
	neg	eax							# | edx = -rand()
	mov	edx, eax					# \

	mov	eax, DWORD PTR -4[rbp]		# / eax = i;
	cdqe							# \ системный вызов, преобразует DWORD в QWORD

	lea	rcx, 0[0+rax*4]				# < rcx - вычисляем смещение в массиве для iого элемента

	mov	rax, QWORD PTR -24[rbp]		# < rax = &array
	add	rcx, rax					# < rcx = &array[i]
	movsx	rax, edx				# < rax = edx

	imul	rax, rax, 1374389535	# /
	shr	rax, 32						# |	
	mov	esi, eax					# |
	sar	esi, 5						# |
	mov	eax, edx					# |
	sar	eax, 31						# |
	sub	esi, eax					# |
	mov	eax, esi					# |
	imul	eax, eax, 100			# |
	sub	edx, eax					# |
	mov	eax, edx					# \ eax = -rand() % 100

	mov	DWORD PTR [rcx], eax		# < array[i] = eax
	add	DWORD PTR -4[rbp], 1		# < i++

.L2:								#
	mov	edx, DWORD PTR -28[rbp]		# / 
	mov	eax, edx					# | 
	add	eax, eax					# | eax = size * 3
	add	eax, edx					# \

	lea	edx, 3[rax]					# /
	test	eax, eax				# | 
	cmovs	eax, edx				# | 
	sar	eax, 2						# \ eax = (size * 3 + 3) / 4

	cmp	DWORD PTR -4[rbp], eax		# / i < (eaz = (size * 3 + 3) / 4)?
	jl	.L3							# | goto L3
	jmp	.L4							# \ else goto L4

# Второй цикл
.L5:								# 
	# rand()
	# rax - result
	call	rand@PLT				# /
	movsx	rdx, eax				# |
	imul	rdx, rdx, 1374389535	# |
	shr	rdx, 32						# |
	mov	ecx, edx					# |
	sar	ecx, 6						# |
	cdq								# |
	sub	ecx, edx					# |
	mov	edx, ecx					# |
	imul	edx, edx, 200			# |
	sub	eax, edx					# |
	mov	edx, eax					# \ edx = -rand() % 200

	mov	eax, DWORD PTR -4[rbp]		# / eax = i
	cdqe							# \ системный вызов, преобразует DWORD в QWORD
	
	lea	rcx, 0[0+rax*4]				# < rcx - вычисляем смещение в массиве для iого элемента
	mov	rax, QWORD PTR -24[rbp]		# /
	add	rax, rcx					# \ rax = &array[i]

	sub	edx, 100					# < edx = (edx = -rand() % 200) - 100
	mov	DWORD PTR [rax], edx		# < array[i] = edx
	add	DWORD PTR -4[rbp], 1		# < i++

.L4:								#
	mov	eax, DWORD PTR -4[rbp]		# / if i < size
	cmp	eax, DWORD PTR -28[rbp]		# |
	jl	.L5							# \ goto L5 
	mov	eax, DWORD PTR -28[rbp]		# < else eax = size
	leave							# /
	ret								# \ return size
