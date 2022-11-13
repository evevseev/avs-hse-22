	.intel_syntax noprefix
	.text
	.globl	my_strstr
	.type	my_strstr, @function
# ## my_strstr()
# ### Локальные переменные
# - DWORD -4[rbp]  - i
# - DWORD -8[rbp]  - j
# - DWORD -12[rbp] - k
# - QWORD -24[rbp] - str
# - QWORD -32[rbp] - substr

# ### Параметры и возвращаемый результат
# - rdi - str
# - rsi - substr
# - rax (return) - start of substr in str or NULL if not found
my_strstr:
	endbr64	
	push	rbp
	mov	rbp, rsp

	mov	QWORD PTR -24[rbp], rdi	# str
	mov	QWORD PTR -32[rbp], rsi	# substr

	mov	DWORD PTR -4[rbp], 0	# < int i = 0#
	mov	DWORD PTR -8[rbp], 0	# < int j = 0#  
	mov	DWORD PTR -12[rbp], 0	# < int k = 0#
	jmp	.L2	# < while (str[i] != '\0')

.L7:
# :         if (str[i] == substr[j]) {
	mov	eax, DWORD PTR -4[rbp]	# // rdx = i
	movsx	rdx, eax			# |\
	mov	rax, QWORD PTR -24[rbp]	# |/
	add	rax, rdx				# ||
	movzx	edx, BYTE PTR [rax]	# |\ edx = str[i]
	mov	eax, DWORD PTR -8[rbp]	# |/ j
	movsx	rcx, eax			# |\ rcx = j
	mov	rax, QWORD PTR -32[rbp]	# |	rax = substr
	add	rax, rcx				# | rax = &substr[j]
	movzx	eax, BYTE PTR [rax]	# | eax = substr[j]
	cmp	dl, al					# |/ if (str[i] == substr[j]) {
	jne	.L3						# \\ if not, goto .L3

	mov	eax, DWORD PTR -4[rbp]	# / eax = i
	mov	DWORD PTR -12[rbp], eax	# \ k = i
     
	jmp	.L4	# < while (str[k] == substr[j])
.L6:
	add	DWORD PTR -12[rbp], 1	# < k++
	add	DWORD PTR -8[rbp], 1	# < j++

	mov	eax, DWORD PTR -8[rbp]	# //
	movsx	rdx, eax			# |\ rdx = j
	mov	rax, QWORD PTR -32[rbp]	# | substr 
	add	rax, rdx				# | substr += j
	movzx	eax, BYTE PTR [rax]	# | eax = substr[j]
	test	al, al				# |/ substr[j] ?? '\0'
	jne	.L4						# |\ if not, go L4

	mov	eax, DWORD PTR -4[rbp]	# // i
	movsx	rdx, eax			# |\ rdx = i
	mov	rax, QWORD PTR -24[rbp]	# |/ str
	add	rax, rdx				# |\ rax = str + i
	jmp	.L5						# \ return &str[i]#
.L4:
	mov	eax, DWORD PTR -12[rbp]	# // rdx = k
	movsx	rdx, eax			# |\
	mov	rax, QWORD PTR -24[rbp]	# |/ str
	add	rax, rdx				# |\ rax = &str[k]
	movzx	edx, BYTE PTR [rax]	# \ edx = str[k]

	mov	eax, DWORD PTR -8[rbp]	# // rcx = j
	movsx	rcx, eax			# |\
	mov	rax, QWORD PTR -32[rbp]	# |/
	add	rax, rcx				# |\ rax = &substr[j]
	movzx	eax, BYTE PTR [rax]	# | edx = substr[j]
	cmp	dl, al					# |/ while (str[k] == substr[j]) {
	je	.L6						# \\ goto L6

	mov	DWORD PTR -8[rbp], 0	# < j++
.L3:
	add	DWORD PTR -4[rbp], 1	# < i++
.L2:
	mov	eax, DWORD PTR -4[rbp]	# // rdx = i
	movsx	rdx, eax			# |\ 
	mov	rax, QWORD PTR -24[rbp]	# | rax = str
	add	rax, rdx				# | rax = &str[i]
	movzx	eax, BYTE PTR [rax]	# | eax = str[i]
	test	al, al				# | while (str[i] != '\0') 
	jne	.L7						# \ if so, goto L7

	mov	eax, 0	# < return NULL
.L5:
	pop	rbp	
	ret	
