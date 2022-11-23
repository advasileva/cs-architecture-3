	.file	"main.c"
	.text
	.globl	timeDelta
	.type	timeDelta, @function
timeDelta:
.LFB22:
	.cfi_startproc
	imulq	$1000000000, %rdx, %rdx
	imulq	$1000000000, %rdi, %rdi
	addq	%rsi, %rdi
	addq	%rcx, %rdx
	movq	%rdi, %rax
	subq	%rdx, %rax
	ret
	.cfi_endproc
.LFE22:
	.size	timeDelta, .-timeDelta
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"Incorrect input"
.LC1:
	.string	"r"
.LC2:
	.string	"w"
.LC3:
	.string	"%lf"
.LC4:
	.string	"input"
.LC5:
	.string	"output"
.LC6:
	.string	"%f"
.LC7:
	.string	"Time delta: %ld ns\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB23:
	.cfi_startproc
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	subq	$64, %rsp
	.cfi_def_cfa_offset 112
	movq	%fs:40, %rax
	movq	%rax, 56(%rsp)
	xorl	%eax, %eax
	cmpl	$2, %edi
	jle	.L14
	movl	%edi, %r12d
	movq	%rsi, %rbx
	movq	8(%rsi), %rdi
	movl	$10, %edx
	movl	$0, %esi
	call	strtol@PLT
	movq	%rax, %r13
	movq	16(%rbx), %rdi
	movl	$10, %edx
	movl	$0, %esi
	call	strtol@PLT
	testl	%eax, %eax
	jne	.L5
	cmpl	$3, %r12d
	jle	.L6
	movq	24(%rbx), %rdi
	movl	$0, %esi
	call	access@PLT
	testl	%eax, %eax
	je	.L7
.L6:
	leaq	.LC0(%rip), %rdi
	call	puts@PLT
	jmp	.L4
.L14:
	leaq	.LC0(%rip), %rdi
	call	puts@PLT
	jmp	.L4
.L7:
	movq	24(%rbx), %rdi
	leaq	.LC1(%rip), %rsi
	call	fopen@PLT
	movq	%rax, %r12
	movq	32(%rbx), %rdi
	leaq	.LC2(%rip), %rsi
	call	fopen@PLT
	movq	%rax, %r14
	leaq	8(%rsp), %rdx
	leaq	.LC3(%rip), %rsi
	movq	%r12, %rdi
	movl	$0, %eax
	call	__isoc99_fscanf@PLT
	jmp	.L8
.L5:
	leaq	.LC2(%rip), %rsi
	leaq	.LC4(%rip), %rdi
	call	fopen@PLT
	movq	%rax, %rbx
	leaq	.LC2(%rip), %rsi
	leaq	.LC5(%rip), %rdi
	call	fopen@PLT
	movq	%rax, %r14
	call	rand@PLT
	movl	$25, %ecx
	cltd
	idivl	%ecx
	pxor	%xmm0, %xmm0
	cvtsi2sdl	%edx, %xmm0
	movsd	%xmm0, 8(%rsp)
	leaq	.LC6(%rip), %rsi
	movq	%rbx, %rdi
	movl	$1, %eax
	call	fprintf@PLT
.L8:
	movl	%r13d, %r12d
	leaq	16(%rsp), %rsi
	movl	$1, %edi
	call	clock_gettime@PLT
	testl	%r13d, %r13d
	jle	.L9
	movl	$0, %ebx
.L10:
	movsd	8(%rsp), %xmm0
	call	calc@PLT
	movq	%xmm0, %rbp
	addl	$1, %ebx
	cmpl	%r12d, %ebx
	jne	.L10
.L9:
	leaq	32(%rsp), %rsi
	movl	$1, %edi
	call	clock_gettime@PLT
	movq	16(%rsp), %rdx
	movq	24(%rsp), %rcx
	movq	32(%rsp), %rdi
	movq	40(%rsp), %rsi
	call	timeDelta
	movq	%rax, %rsi
	leaq	.LC7(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	%rbp, %xmm0
	leaq	.LC6(%rip), %rsi
	movq	%r14, %rdi
	movl	$1, %eax
	call	fprintf@PLT
.L4:
	movq	56(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L15
	movl	$0, %eax
	addq	$64, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 48
	popq	%rbx
	.cfi_def_cfa_offset 40
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
.L15:
	.cfi_restore_state
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE23:
	.size	main, .-main
	.ident	"GCC: (GNU) 10.3.1 20210703 (ALT Sisyphus 10.3.1-alt2)"
	.section	.note.GNU-stack,"",@progbits
