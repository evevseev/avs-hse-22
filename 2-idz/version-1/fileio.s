	.intel_syntax noprefix
	.text
	.section	.rodata
.LC0:
	.string	"r"
.LC1:
	.string	"File is too big"
.LC2:
	.string	"%c"
	.text
	.globl	read_string_from_file
	.type	read_string_from_file, @function
read_string_from_file:
	endbr64	
	push	rbp	
	mov	rbp, rsp

	sub	rsp, 48
	mov	QWORD PTR -40[rbp], rdi	; < file_path
	mov	DWORD PTR -44[rbp], esi	; < max_size

;    
	mov	rax, QWORD PTR -40[rbp]	; / rax = file_path
	lea	rsi, .LC0[rip]			; | "r"
	mov	rdi, rax				; | file_path
	call	fopen@PLT			; |
	mov	QWORD PTR -16[rbp], rax	; \ file = fopen(file_path, "r");

	mov	rax, QWORD PTR -16[rbp]	; / rax = file
	mov	edx, 2					; | SEEK_END
	mov	esi, 0					; |
	mov	rdi, rax				; | rdi = file
	call	fseek@PLT			; \

	mov	rax, QWORD PTR -16[rbp]	; / file
	mov	rdi, rax				; | file
	call	ftell@PLT			; |
	mov	QWORD PTR -24[rbp], rax	; \file_size = ftell(file);
;    
	mov	rax, QWORD PTR -16[rbp]	; / file
	mov	edx, 0					; |
	mov	esi, 0					; |
	mov	rdi, rax				; | file
	call	fseek@PLT			; \ fseek(file, 0, SEEK_SET);

	mov	rax, QWORD PTR -24[rbp]	; | /
	mov	rdi, rax				; |	\ file_size
	call	malloc@PLT			; |
	mov	QWORD PTR -32[rbp], rax	; \ str = (char *) malloc(file_size * sizeof(char));
	mov	DWORD PTR -4[rbp], 0	; < i = 0;
	mov	DWORD PTR -8[rbp], 0 	; < eof_flag = 0,
	jmp	.L2	; < while (eof_flag != EOF)
.L4:
	mov	eax, DWORD PTR -4[rbp]	; / i
	cmp	eax, DWORD PTR -44[rbp]	; | max_size
	jl	.L3						; \ if(i >= max_size)

	lea	rdi, .LC1[rip]	; / 
	call	puts@PLT	; \ printf("File is too big\n");
        
	mov	rax, QWORD PTR -16[rbp]	; // rdi = file
	mov	rdi, rax				; |\
	call	fclose@PLT			; \ fclose(file);

	mov	edi, 5			; /
	call	exit@PLT	; \ exit(5);
.L3:
;        
	mov	eax, DWORD PTR -4[rbp]	; // i
	movsx	rdx, eax			; |\ rdx = i
	mov	rax, QWORD PTR -32[rbp]	; | str
	add	rdx, rax				; | rdx = str + i
	mov	rax, QWORD PTR -16[rbp]	; | file
	lea	rsi, .LC2[rip]			; |
	mov	rdi, rax				; |
	mov	eax, 0					; |
	call	__isoc99_fscanf@PLT	; |
	mov	DWORD PTR -8[rbp], eax	; \ eof_flag = fscanf(file, "%c", &str[i]);

	add	DWORD PTR -4[rbp], 1	; < i++;
.L2:
	cmp	DWORD PTR -8[rbp], -1	; / while (eof_flag != EOF) 
	jne	.L4						; \ goto .L4

	mov	rax, QWORD PTR -16[rbp]	; / file
	mov	rdi, rax				; |
	call	fclose@PLT			; \	fclose(file);

	mov	rax, QWORD PTR -32[rbp]	; <  return str;
	leave	
	ret	