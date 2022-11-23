	.file	"main.c"
	.text
	.globl	timeDelta
	.type	timeDelta, @function
timeDelta:
.LFB6:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rsi, %rax
	movq	%rdi, %r8
	movq	%r8, %rsi
	movq	%r9, %rdi
	movq	%rax, %rdi
	movq	%rsi, -32(%rbp)
	movq	%rdi, -24(%rbp)
	movq	%rdx, -48(%rbp)
	movq	%rcx, -40(%rbp)
	movq	-48(%rbp), %rax
	movq	%rax, -16(%rbp)
	movq	-16(%rbp), %rax
	imulq	$1000000000, %rax, %rax
	movq	%rax, -16(%rbp)
	movq	-40(%rbp), %rax
	addq	%rax, -16(%rbp)
	movq	-32(%rbp), %rax
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rax
	imulq	$1000000000, %rax, %rax
	movq	%rax, -8(%rbp)
	movq	-24(%rbp), %rax
	addq	%rax, -8(%rbp)
	movq	-8(%rbp), %rax
	subq	-16(%rbp), %rax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	timeDelta, .-timeDelta
	.section	.rodata
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
.LFB7:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$112, %rsp
	movl	%edi, -100(%rbp)
	movq	%rsi, -112(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	cmpl	$2, -100(%rbp)
	jg	.L4
	leaq	.LC0(%rip), %rdi
	call	puts@PLT
	movl	$0, %eax
	jmp	.L12
.L4:
	movq	-112(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	atoi@PLT
	movl	%eax, -92(%rbp)
	movq	-112(%rbp), %rax
	addq	$16, %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	atoi@PLT
	testl	%eax, %eax
	jne	.L6
	cmpl	$3, -100(%rbp)
	jle	.L7
	movq	-112(%rbp), %rax
	addq	$24, %rax
	movq	(%rax), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	access@PLT
	testl	%eax, %eax
	je	.L8
.L7:
	leaq	.LC0(%rip), %rdi
	call	puts@PLT
	movl	$0, %eax
	jmp	.L12
.L8:
	movq	-112(%rbp), %rax
	addq	$24, %rax
	movq	(%rax), %rax
	leaq	.LC1(%rip), %rsi
	movq	%rax, %rdi
	call	fopen@PLT
	movq	%rax, -64(%rbp)
	movq	-112(%rbp), %rax
	addq	$32, %rax
	movq	(%rax), %rax
	leaq	.LC2(%rip), %rsi
	movq	%rax, %rdi
	call	fopen@PLT
	movq	%rax, -72(%rbp)
	leaq	-88(%rbp), %rdx
	movq	-64(%rbp), %rax
	leaq	.LC3(%rip), %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	__isoc99_fscanf@PLT
	jmp	.L9
.L6:
	leaq	.LC2(%rip), %rsi
	leaq	.LC4(%rip), %rdi
	call	fopen@PLT
	movq	%rax, -64(%rbp)
	leaq	.LC2(%rip), %rsi
	leaq	.LC5(%rip), %rdi
	call	fopen@PLT
	movq	%rax, -72(%rbp)
	call	rand@PLT
	movl	%eax, %edx
	movslq	%edx, %rax
	imulq	$1374389535, %rax, %rax
	shrq	$32, %rax
	sarl	$3, %eax
	movl	%edx, %esi
	sarl	$31, %esi
	subl	%esi, %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	sall	$2, %eax
	addl	%ecx, %eax
	leal	0(,%rax,4), %ecx
	addl	%ecx, %eax
	movl	%edx, %ecx
	subl	%eax, %ecx
	pxor	%xmm0, %xmm0
	cvtsi2sdl	%ecx, %xmm0
	movsd	%xmm0, -88(%rbp)
	movq	-88(%rbp), %rdx
	movq	-64(%rbp), %rax
	movq	%rdx, %xmm0
	leaq	.LC6(%rip), %rsi
	movq	%rax, %rdi
	movl	$1, %eax
	call	fprintf@PLT
.L9:
	leaq	-48(%rbp), %rax
	movq	%rax, %rsi
	movl	$1, %edi
	call	clock_gettime@PLT
	movl	$0, -96(%rbp)
	jmp	.L10
.L11:
	movq	-88(%rbp), %rax
	movq	%rax, %xmm0
	call	calc@PLT
	movq	%xmm0, %rax
	movq	%rax, -80(%rbp)
	addl	$1, -96(%rbp)
.L10:
	movl	-96(%rbp), %eax
	cmpl	-92(%rbp), %eax
	jl	.L11
	leaq	-32(%rbp), %rax
	movq	%rax, %rsi
	movl	$1, %edi
	call	clock_gettime@PLT
	movq	-48(%rbp), %rax
	movq	-40(%rbp), %rdx
	movq	-32(%rbp), %rdi
	movq	-24(%rbp), %rsi
	movq	%rdx, %rcx
	movq	%rax, %rdx
	call	timeDelta
	movq	%rax, -56(%rbp)
	movq	-56(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC7(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	-80(%rbp), %rdx
	movq	-72(%rbp), %rax
	movq	%rdx, %xmm0
	leaq	.LC6(%rip), %rsi
	movq	%rax, %rdi
	movl	$1, %eax
	call	fprintf@PLT
	movl	$0, %eax
.L12:
	movq	-8(%rbp), %rcx
	subq	%fs:40, %rcx
	je	.L13
	call	__stack_chk_fail@PLT
.L13:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	main, .-main
	.ident	"GCC: (GNU) 10.3.1 20210703 (ALT Sisyphus 10.3.1-alt2)"
	.section	.note.GNU-stack,"",@progbits
