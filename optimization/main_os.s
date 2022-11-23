	.file	"main.c"
	.text
	.globl	timeDelta
	.type	timeDelta, @function
timeDelta:
.LFB35:
	.cfi_startproc
	imulq	$1000000000, %rdi, %rdi
	imulq	$1000000000, %rdx, %rdx
	addq	%rsi, %rdi
	addq	%rcx, %rdx
	movq	%rdi, %rax
	subq	%rdx, %rax
	ret
	.cfi_endproc
.LFE35:
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
	.section	.text.startup,"ax",@progbits
	.globl	main
	.type	main, @function
main:
.LFB36:
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
	subq	$48, %rsp
	.cfi_def_cfa_offset 96
	movq	%fs:40, %rax
	movq	%rax, 40(%rsp)
	xorl	%eax, %eax
	cmpl	$2, %edi
	jg	.L3
.L7:
	leaq	.LC0(%rip), %rdi
	call	puts@PLT
	jmp	.L4
.L3:
	movl	%edi, %ebp
	movq	8(%rsi), %rdi
	movq	%rsi, %rbx
	call	atoi@PLT
	movq	16(%rbx), %rdi
	movl	%eax, %r12d
	call	atoi@PLT
	testl	%eax, %eax
	jne	.L5
	cmpl	$3, %ebp
	je	.L7
	movq	24(%rbx), %rdi
	xorl	%esi, %esi
	call	access@PLT
	testl	%eax, %eax
	jne	.L7
	movq	24(%rbx), %rdi
	leaq	.LC1(%rip), %rsi
	call	fopen@PLT
	movq	32(%rbx), %rdi
	leaq	.LC2(%rip), %rsi
	movq	%rax, %r13
	call	fopen@PLT
	movq	%rsp, %rdx
	leaq	.LC3(%rip), %rsi
	movq	%r13, %rdi
	movq	%rax, %rbp
	xorl	%eax, %eax
	call	__isoc99_fscanf@PLT
	jmp	.L9
.L5:
	leaq	.LC2(%rip), %rsi
	leaq	.LC4(%rip), %rdi
	call	fopen@PLT
	leaq	.LC2(%rip), %rsi
	leaq	.LC5(%rip), %rdi
	movq	%rax, %r13
	call	fopen@PLT
	movq	%rax, %rbp
	call	rand@PLT
	movl	$25, %ecx
	movl	$1, %esi
	movq	%r13, %rdi
	cltd
	idivl	%ecx
	movb	$1, %al
	cvtsi2sdl	%edx, %xmm0
	leaq	.LC6(%rip), %rdx
	movsd	%xmm0, (%rsp)
	call	__fprintf_chk@PLT
.L9:
	leaq	8(%rsp), %rsi
	movl	$1, %edi
	xorl	%ebx, %ebx
	call	clock_gettime@PLT
.L10:
	cmpl	%r12d, %ebx
	jge	.L15
	movsd	(%rsp), %xmm0
	incl	%ebx
	call	calc@PLT
	movq	%xmm0, %r14
	jmp	.L10
.L15:
	leaq	24(%rsp), %rsi
	movl	$1, %edi
	call	clock_gettime@PLT
	movq	8(%rsp), %rdx
	movq	24(%rsp), %rdi
	movq	32(%rsp), %rsi
	movq	16(%rsp), %rcx
	call	timeDelta
	leaq	.LC7(%rip), %rsi
	movl	$1, %edi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	__printf_chk@PLT
	movq	%r14, %xmm0
	movq	%rbp, %rdi
	movb	$1, %al
	leaq	.LC6(%rip), %rdx
	movl	$1, %esi
	call	__fprintf_chk@PLT
.L4:
	movq	40(%rsp), %rax
	subq	%fs:40, %rax
	je	.L12
	call	__stack_chk_fail@PLT
.L12:
	addq	$48, %rsp
	.cfi_def_cfa_offset 48
	xorl	%eax, %eax
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
	.cfi_endproc
.LFE36:
	.size	main, .-main
	.ident	"GCC: (GNU) 10.3.1 20210703 (ALT Sisyphus 10.3.1-alt2)"
	.section	.note.GNU-stack,"",@progbits
