	.file	"main.c"
	.intel_syntax noprefix
	.text
	.globl	timeDelta
	.type	timeDelta, @function
timeDelta:
	push	rbp
	mov	rbp, rsp
	mov	rax, rsi
	mov	r8, rdi
	mov	rsi, r8
	mov	rdi, r9
	mov	rdi, rax
	mov	QWORD PTR -32[rbp], rsi
	mov	QWORD PTR -24[rbp], rdi
	mov	QWORD PTR -48[rbp], rdx
	mov	QWORD PTR -40[rbp], rcx
	mov	rax, QWORD PTR -48[rbp]
	mov	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR -8[rbp]
	imul	rax, rax, 1000000000
	mov	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR -40[rbp]
	add	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR -32[rbp]
	mov	QWORD PTR -16[rbp], rax
	mov	rax, QWORD PTR -16[rbp]
	imul	rax, rax, 1000000000
	mov	QWORD PTR -16[rbp], rax
	mov	rax, QWORD PTR -24[rbp]
	add	QWORD PTR -16[rbp], rax
	mov	rax, QWORD PTR -16[rbp]
	sub	rax, QWORD PTR -8[rbp]
	pop	rbp
	ret
	.size	timeDelta, .-timeDelta
	.section	.rodata
.LC0:
	.string	"Incorrect input"
.LC1:
	.string	"r"
.LC2:
	.string	"w"
.LC3:
	.string	"input"
.LC4:
	.string	"output"
.LC5:
	.string	"Time delta: %ld ns\n"
	.text
	.globl	main
	.type	main, @function
main:
	push	rbp
	mov	rbp, rsp
	push	rbx
	sub	rsp, 136
	mov	DWORD PTR -132[rbp], edi
	mov	QWORD PTR -144[rbp], rsi
	mov	rax, rsp
	mov	rbx, rax
	mov	DWORD PTR -44[rbp], 1000000
	mov	eax, DWORD PTR -44[rbp]
	add	eax, 1
	movsx	rdx, eax
	sub	rdx, 1
	mov	QWORD PTR -56[rbp], rdx
	movsx	rdx, eax
	mov	r10, rdx
	mov	r11d, 0
	movsx	rdx, eax
	mov	r8, rdx
	mov	r9d, 0
	cdqe
	mov	edx, 16
	sub	rdx, 1
	add	rax, rdx
	mov	ecx, 16
	mov	edx, 0
	div	rcx
	imul	rax, rax, 16
	mov	rcx, rax
	and	rcx, -4096
	mov	rdx, rsp
	sub	rdx, rcx
.L4:
	cmp	rsp, rdx
	je	.L5
	sub	rsp, 4096
	or	QWORD PTR 4088[rsp], 0
	jmp	.L4
.L5:
	mov	rdx, rax
	and	edx, 4095
	sub	rsp, rdx
	mov	rdx, rax
	and	edx, 4095
	test	rdx, rdx
	je	.L6
	and	eax, 4095
	sub	rax, 8
	add	rax, rsp
	or	QWORD PTR [rax], 0
.L6:
	mov	rax, rsp
	add	rax, 0
	mov	QWORD PTR -64[rbp], rax
	cmp	DWORD PTR -132[rbp], 3
	jg	.L7
	lea	rdi, .LC0[rip]
	call	puts@PLT
	mov	eax, 0
	jmp	.L8
.L7:
	mov	rax, QWORD PTR -144[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	atoi@PLT
	mov	DWORD PTR -68[rbp], eax
	mov	rax, QWORD PTR -144[rbp]
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	atoi@PLT
	mov	DWORD PTR -72[rbp], eax
	mov	rax, QWORD PTR -144[rbp]
	add	rax, 24
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	atoi@PLT
	test	eax, eax
	jne	.L9
	cmp	DWORD PTR -132[rbp], 4
	jle	.L10
	mov	rax, QWORD PTR -144[rbp]
	add	rax, 32
	mov	rax, QWORD PTR [rax]
	mov	esi, 0
	mov	rdi, rax
	call	access@PLT
	test	eax, eax
	je	.L11
.L10:
	lea	rdi, .LC0[rip]
	call	puts@PLT
	mov	eax, 0
	jmp	.L8
.L11:
	mov	rax, QWORD PTR -144[rbp]
	add	rax, 32
	mov	rax, QWORD PTR [rax]
	lea	rsi, .LC1[rip]
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -80[rbp], rax
	mov	rax, QWORD PTR -144[rbp]
	add	rax, 40
	mov	rax, QWORD PTR [rax]
	lea	rsi, .LC2[rip]
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -40[rbp], rax
	mov	DWORD PTR -28[rbp], 0
.L13:
	mov	eax, DWORD PTR -28[rbp]
	cmp	eax, DWORD PTR -44[rbp]
	jle	.L12
	lea	rdi, .LC0[rip]
	call	puts@PLT
	mov	eax, 0
	jmp	.L8
.L12:
	mov	rax, QWORD PTR -80[rbp]
	mov	rdi, rax
	call	fgetc@PLT
	mov	BYTE PTR -81[rbp], al
	mov	eax, DWORD PTR -28[rbp]
	lea	edx, 1[rax]
	mov	DWORD PTR -28[rbp], edx
	mov	rdx, QWORD PTR -64[rbp]
	cdqe
	movzx	ecx, BYTE PTR -81[rbp]
	mov	BYTE PTR [rdx+rax], cl
	cmp	BYTE PTR -81[rbp], -1
	jne	.L13
	sub	DWORD PTR -28[rbp], 1
	mov	rdx, QWORD PTR -64[rbp]
	mov	eax, DWORD PTR -28[rbp]
	cdqe
	mov	BYTE PTR [rdx+rax], 0
	jmp	.L14
.L9:
	lea	rsi, .LC2[rip]
	lea	rdi, .LC3[rip]
	call	fopen@PLT
	mov	QWORD PTR -80[rbp], rax
	lea	rsi, .LC2[rip]
	lea	rdi, .LC4[rip]
	call	fopen@PLT
	mov	QWORD PTR -40[rbp], rax
	mov	rax, QWORD PTR -144[rbp]
	add	rax, 32
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	atoi@PLT
	mov	DWORD PTR -28[rbp], eax
	mov	eax, DWORD PTR -28[rbp]
	cmp	eax, DWORD PTR -44[rbp]
	jle	.L15
	lea	rdi, .LC0[rip]
	call	puts@PLT
	mov	eax, 0
	jmp	.L8
.L15:
	mov	DWORD PTR -20[rbp], 0
	jmp	.L16
.L17:
	call	rand@PLT
	cdq
	shr	edx, 25
	add	eax, edx
	and	eax, 127
	sub	eax, edx
	mov	ecx, eax
	mov	rdx, QWORD PTR -64[rbp]
	mov	eax, DWORD PTR -20[rbp]
	cdqe
	mov	BYTE PTR [rdx+rax], cl
	mov	rdx, QWORD PTR -64[rbp]
	mov	eax, DWORD PTR -20[rbp]
	cdqe
	movzx	eax, BYTE PTR [rdx+rax]
	movsx	eax, al
	mov	rdx, QWORD PTR -80[rbp]
	mov	rsi, rdx
	mov	edi, eax
	call	fputc@PLT
	add	DWORD PTR -20[rbp], 1
.L16:
	mov	eax, DWORD PTR -20[rbp]
	cmp	eax, DWORD PTR -28[rbp]
	jl	.L17
.L14:
	lea	rax, -112[rbp]
	mov	rsi, rax
	mov	edi, 1
	call	clock_gettime@PLT
	mov	DWORD PTR -20[rbp], 0
	jmp	.L18
.L19:
	mov	rdx, QWORD PTR -64[rbp]
	mov	ecx, DWORD PTR -28[rbp]
	mov	eax, DWORD PTR -72[rbp]
	mov	esi, ecx
	mov	edi, eax
	call	find@PLT
	mov	DWORD PTR -24[rbp], eax
	add	DWORD PTR -20[rbp], 1
.L18:
	mov	eax, DWORD PTR -20[rbp]
	cmp	eax, DWORD PTR -68[rbp]
	jl	.L19
	lea	rax, -128[rbp]
	mov	rsi, rax
	mov	edi, 1
	call	clock_gettime@PLT
	mov	rax, QWORD PTR -112[rbp]
	mov	rdx, QWORD PTR -104[rbp]
	mov	rdi, QWORD PTR -128[rbp]
	mov	rsi, QWORD PTR -120[rbp]
	mov	rcx, rdx
	mov	rdx, rax
	call	timeDelta
	mov	QWORD PTR -96[rbp], rax
	mov	rax, QWORD PTR -96[rbp]
	mov	rsi, rax
	lea	rdi, .LC5[rip]
	mov	eax, 0
	call	printf@PLT
	cmp	DWORD PTR -24[rbp], -1
	je	.L20
	mov	DWORD PTR -20[rbp], 0
	jmp	.L21
.L22:
	mov	edx, DWORD PTR -24[rbp]
	mov	eax, DWORD PTR -20[rbp]
	add	eax, edx
	mov	rdx, QWORD PTR -64[rbp]
	cdqe
	movzx	eax, BYTE PTR [rdx+rax]
	movsx	eax, al
	mov	rdx, QWORD PTR -40[rbp]
	mov	rsi, rdx
	mov	edi, eax
	call	fputc@PLT
	add	DWORD PTR -20[rbp], 1
.L21:
	mov	eax, DWORD PTR -20[rbp]
	cmp	eax, DWORD PTR -72[rbp]
	jl	.L22
.L20:
	mov	eax, 0
.L8:
	mov	rsp, rbx
	mov	rbx, QWORD PTR -8[rbp]
	leave
	ret
	.size	main, .-main
	.ident	"GCC: (GNU) 10.3.1 20210703 (ALT Sisyphus 10.3.1-alt2)"
	.section	.note.GNU-stack,"",@progbits
