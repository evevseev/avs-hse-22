	.intel_syntax noprefix
	.text
	.globl	my_strstr
	.type	my_strstr, @function
# ## my_strstr()
# ### Локальные переменные
# - DWORD -4[rbp]  - i
# - DWORD -8[rbp]  - jrbp
# - DWORD -12[rbp] - k
# - QWORD -24[rbp] - str
# - QWORD -32[rbp] - substr

# ### Параметры и возвращаемый результат
# - rdi - str
# - rsi - substr
# - rax (return) - start of substr in str or NULL if not found

# ### Использование регистров
# `i => r12`, `generated_size => r13`, `ch => r14`, `my_strstr => r14`, `seed => ecx`

my_strstr:
	endbr64	
	push	rbp
	mov	rbp, rsp

	mov	r12, 0	# < int i = 0
	mov	r13, 0	# < int j = 0
	mov	r14, 0	# < int k = 0
	jmp	.L2		# < while (str[i] != '\0')

.L7:
	movzx	edx, BYTE PTR 0[rdi+r12]	# < edx = str[i]
	movzx	eax, BYTE PTR 0[rsi+r13]	# < eax = substr[j]
	cmp	dl, al					# / if (str[i] == substr[j]) {
	jne	.L3						# \ if not, goto .L3

	mov	r14d, r12d	# < k = i
     
	jmp	.L4	# < while (str[k] == substr[j])
.L6:
	add	r14, 1	# < k++
	add	r13, 1	# < j++

	movzx	eax, BYTE PTR [rsi+r13]	# < eax = substr[j]

	test	al, al				# / substr[j] ?? '\0'
	jne	.L4						# \ if not, go L4

	mov	rax, rdi				# // str
	add	rax, r12				# |\ rax = str + i
	jmp	.L5						# \ return &str[i]#
.L4:
	movzx	edx, BYTE PTR [rdi+r14]	# < edx = str[k]
	movzx	eax, BYTE PTR [rsi+r13]	# < edx = substr[j]

	cmp	dl, al							# / while (str[k] == substr[j]) {
	je	.L6								# \ goto L6

	mov	r13, 0	# < j++
.L3:
	add	r12, 1	# < i++
.L2:
	movzx	eax, BYTE PTR [rdi+r12]	# / eax = str[i]
	test	al, al						# | while (str[i] != '\0') 
	jne	.L7								# \ if so, goto L7

	mov	eax, 0	# < return NULL
.L5:
	pop	rbp	
	ret	
