	.intel_syntax noprefix
	.text
	.globl	generate_random_string
	.type	generate_random_string, @function
generate_random_string:
	endbr64	
	push	rbp
	mov	rbp, rsp

	sub	rsp, 48
	mov	QWORD PTR -24[rbp], rdi	; < substr
	mov	QWORD PTR -32[rbp], rsi	; < str
	mov	DWORD PTR -36[rbp], edx	; < size
	mov	DWORD PTR -40[rbp], ecx	; < seed

	mov	eax, DWORD PTR -40[rbp]	; //
	mov	edi, eax				; |\ seed
	call	srand@PLT			; \ srand(seed)
  
	mov	rax, QWORD PTR -24[rbp]		; / / substr
	mov	rdi, rax					; | \ tmp101
	call	strlen@PLT				; |
	mov	DWORD PTR -12[rbp], eax		; \ substr_size = strlen(substr);

	mov	DWORD PTR -8[rbp], 0	; < generated_size = 0;

	jmp	.L2	; < while(generated_size < size - 1)
.L6:
	call	rand@PLT	; /|
	and	eax, 1			; ||
	test	eax, eax	; |\ if (rand() % 2 == 0) {
	jne	.L3				; \ if not goto L3

	mov	DWORD PTR -4[rbp], 0	; i = 0
	jmp	.L4	; for (i = 0; i < substr_size && generated_size < size; i++)
.L5:
	mov	eax, DWORD PTR -4[rbp]	; //
	movsx	rdx, eax			; |\ rdx = i
	mov	rax, QWORD PTR -24[rbp]	; |/.
	add	rax, rdx				; |\rax = substr + i

	mov	edx, DWORD PTR -8[rbp]	; // 
	movsx	rcx, edx			; |\ rcx = generated_size
	mov	rdx, QWORD PTR -32[rbp]	; |/
	add	rdx, rcx				; \\ rdx = str + generated_size

	movzx	eax, BYTE PTR [rax]	; /
	mov	BYTE PTR [rdx], al		; \ str[generated_size] = substr[i];

	add	DWORD PTR -8[rbp], 1	; generated_size++;
	add	DWORD PTR -4[rbp], 1	; i++;
.L4:
	mov	eax, DWORD PTR -4[rbp]	; / / i
	cmp	eax, DWORD PTR -12[rbp]	; | \ i >=? substr_size
	jge	.L2						; \  if so goto L2

	mov	eax, DWORD PTR -8[rbp]	; / /
	cmp	eax, DWORD PTR -36[rbp]	; | \ generated_size <? size
	jl	.L5						; | if so goto L5
	jmp	.L2						; \ else goto L2
.L3:
	call	rand@PLT			; /
	mov	edx, eax				; \ eax = rand(),

	movsx	rax, edx			; /
	imul	rax, rax, 715827883	; | а 
	shr	rax, 32					; | компилятор
	mov	ecx, eax				; | сам 
	sar	ecx, 4					; | знает
	mov	eax, edx				; | что тут проиходит
	sar	eax, 31					; | ?
	sub	ecx, eax				; |
	mov	eax, ecx				; |
	add	eax, eax				; |
	add	eax, ecx				; |
	sal	eax, 5					; |
	mov	ecx, edx				; |
	sub	ecx, eax				; | 
	mov	eax, ecx				; |
	add	eax, 32					; \ eax = rand() % (128 - 32) + 32

	mov	BYTE PTR -13[rbp], al	; ch = eax

	cmp	BYTE PTR -13[rbp], 0	; / if(ch != '\0')
	je	.L2						; \ if not, goto L2

	mov	eax, DWORD PTR -8[rbp]		; // 
	movsx	rdx, eax				; |\ rdx = generated_size
	mov	rax, QWORD PTR -32[rbp]		; | rax = str
	add	rdx, rax					; | rdx = str + generated_size
	movzx	eax, BYTE PTR -13[rbp]	; |/ eax = ch
	mov	BYTE PTR [rdx], al			; \\ str[generated_size] = ch;
              
	add	DWORD PTR -8[rbp], 1	; < generated_size++;
.L2:

	mov	eax, DWORD PTR -36[rbp]	; // 
	sub	eax, 1					; |\ size - 1
	cmp	DWORD PTR -8[rbp], eax	; | while(generated_size < size - 1) {
	jl	.L6						; \ goto L6

	mov	eax, DWORD PTR -8[rbp]	; // generated_size
	movsx	rdx, eax			; |\
	mov	rax, QWORD PTR -32[rbp]	; |/
	add	rax, rdx				; |\ str + generated_size
	mov	BYTE PTR [rax], 0		; \ str[generated_size] = '\0';

	nop	
	leave	
	ret	