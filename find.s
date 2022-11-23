	.file	"find.c"
	.intel_syntax noprefix
	.text
	.globl	find
	.type	find, @function
find:
	push	rbp
	mov	rbp, rsp
	mov	DWORD PTR -20[rbp], edi
	mov	DWORD PTR -24[rbp], esi
	mov	QWORD PTR -32[rbp], rdx
	mov	eax, DWORD PTR -24[rbp]
	sub	eax, DWORD PTR -20[rbp]
	mov	DWORD PTR -8[rbp], eax
	jmp	.L2
.L9:
	mov	DWORD PTR -4[rbp], 1
	mov	DWORD PTR -12[rbp], 0
	jmp	.L3
.L6:
	mov	edx, DWORD PTR -8[rbp]
	mov	eax, DWORD PTR -12[rbp]
	add	eax, edx
	movsx	rdx, eax
	mov	rax, QWORD PTR -32[rbp]
	add	rax, rdx
	movzx	edx, BYTE PTR [rax]
	mov	ecx, DWORD PTR -8[rbp]
	mov	eax, DWORD PTR -12[rbp]
	add	eax, ecx
	cdqe
	lea	rcx, 1[rax]
	mov	rax, QWORD PTR -32[rbp]
	add	rax, rcx
	movzx	eax, BYTE PTR [rax]
	cmp	dl, al
	jg	.L4
	mov	DWORD PTR -4[rbp], 0
	jmp	.L5
.L4:
	add	DWORD PTR -12[rbp], 1
.L3:
	mov	eax, DWORD PTR -20[rbp]
	sub	eax, 1
	cmp	DWORD PTR -12[rbp], eax
	jl	.L6
.L5:
	cmp	DWORD PTR -4[rbp], 1
	jne	.L7
	mov	eax, DWORD PTR -8[rbp]
	jmp	.L8
.L7:
	sub	DWORD PTR -8[rbp], 1
.L2:
	cmp	DWORD PTR -8[rbp], 0
	jns	.L9
	mov	eax, -1
.L8:
	pop	rbp
	ret
	.size	find, .-find
	.ident	"GCC: (GNU) 10.3.1 20210703 (ALT Sisyphus 10.3.1-alt2)"
	.section	.note.GNU-stack,"",@progbits
