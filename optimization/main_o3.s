	.file	"main.c"
	.text
	.p2align 4
	.globl	timeDelta
	.type	timeDelta, @function
timeDelta:
.LFB50:
	.cfi_startproc
	imulq	$1000000000, %rdi, %rdi
	imulq	$1000000000, %rdx, %rdx
	addq	%rsi, %rdi
	addq	%rcx, %rdx
	movq	%rdi, %rax
	subq	%rdx, %rax
	ret
	.cfi_endproc
.LFE50:
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
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB51:
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
	jle	.L8
	movl	%edi, %ebp
	movq	8(%rsi), %rdi
	movq	%rsi, %rbx
	movl	$10, %edx
	xorl	%esi, %esi
	call	strtol@PLT
	movq	16(%rbx), %rdi
	xorl	%esi, %esi
	movl	$10, %edx
	movq	%rax, %r13
	call	strtol@PLT
	testl	%eax, %eax
	jne	.L6
	cmpl	$3, %ebp
	je	.L8
	movq	24(%rbx), %rdi
	xorl	%esi, %esi
	call	access@PLT
	testl	%eax, %eax
	je	.L16
.L8:
	leaq	.LC0(%rip), %rdi
	call	puts@PLT
.L5:
	movq	56(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L17
	addq	$64, %rsp
	.cfi_remember_state
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
.L6:
	.cfi_restore_state
	leaq	.LC2(%rip), %rsi
	leaq	.LC4(%rip), %rdi
	call	fopen@PLT
	leaq	.LC2(%rip), %rsi
	leaq	.LC5(%rip), %rdi
	movq	%rax, %r12
	call	fopen@PLT
	movq	%rax, %rbp
	call	rand@PLT
	movl	$25, %ecx
	pxor	%xmm0, %xmm0
	movq	%r12, %rdi
	cltd
	movl	$1, %esi
	idivl	%ecx
	movl	$1, %eax
	cvtsi2sdl	%edx, %xmm0
	leaq	.LC6(%rip), %rdx
	movsd	%xmm0, 8(%rsp)
	call	__fprintf_chk@PLT
.L10:
	leaq	16(%rsp), %rsi
	movl	$1, %edi
	movl	%r13d, %r12d
	call	clock_gettime@PLT
	testl	%r13d, %r13d
	jle	.L11
	xorl	%ebx, %ebx
	.p2align 4,,10
	.p2align 3
.L12:
	movsd	8(%rsp), %xmm0
	addl	$1, %ebx
	call	calc@PLT
	movq	%xmm0, %r14
	cmpl	%r12d, %ebx
	jne	.L12
.L11:
	leaq	32(%rsp), %rsi
	movl	$1, %edi
	call	clock_gettime@PLT
	leaq	.LC7(%rip), %rsi
	movl	$1, %edi
	imulq	$1000000000, 16(%rsp), %rax
	addq	24(%rsp), %rax
	imulq	$1000000000, 32(%rsp), %rdx
	addq	40(%rsp), %rdx
	subq	%rax, %rdx
	xorl	%eax, %eax
	call	__printf_chk@PLT
	movq	%r14, %xmm0
	movl	$1, %esi
	movq	%rbp, %rdi
	leaq	.LC6(%rip), %rdx
	movl	$1, %eax
	call	__fprintf_chk@PLT
	jmp	.L5
.L16:
	movq	24(%rbx), %rdi
	leaq	.LC1(%rip), %rsi
	call	fopen@PLT
	movq	32(%rbx), %rdi
	leaq	.LC2(%rip), %rsi
	movq	%rax, %r12
	call	fopen@PLT
	leaq	8(%rsp), %rdx
	leaq	.LC3(%rip), %rsi
	movq	%r12, %rdi
	movq	%rax, %rbp
	xorl	%eax, %eax
	call	__isoc99_fscanf@PLT
	jmp	.L10
.L17:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE51:
	.size	main, .-main
	.ident	"GCC: (GNU) 10.3.1 20210703 (ALT Sisyphus 10.3.1-alt2)"
	.section	.note.GNU-stack,"",@progbits
