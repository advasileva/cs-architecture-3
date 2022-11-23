	.file	"calc.c"
	.text
	.globl	calc
	.type	calc, @function
calc:
.LFB0:
	.cfi_startproc
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movsd	%xmm0, 8(%rsp)
	call	exp@PLT
	movsd	8(%rsp), %xmm2
	movl	$1, %eax
	movq	.LC1(%rip), %xmm6
	movaps	%xmm0, %xmm4
	movsd	.LC0(%rip), %xmm0
	movsd	.LC2(%rip), %xmm5
	movaps	%xmm0, %xmm1
.L2:
	movaps	%xmm4, %xmm3
	subsd	%xmm0, %xmm3
	andps	%xmm6, %xmm3
	comisd	%xmm5, %xmm3
	jb	.L6
	mulsd	%xmm2, %xmm1
	cvtsi2sdl	%eax, %xmm3
	incl	%eax
	divsd	%xmm3, %xmm1
	addsd	%xmm1, %xmm0
	jmp	.L2
.L6:
	addq	$24, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE0:
	.size	calc, .-calc
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC0:
	.long	0
	.long	1072693248
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC1:
	.long	-1
	.long	2147483647
	.long	0
	.long	0
	.section	.rodata.cst8
	.align 8
.LC2:
	.long	-755914244
	.long	1062232653
	.ident	"GCC: (GNU) 10.3.1 20210703 (ALT Sisyphus 10.3.1-alt2)"
	.section	.note.GNU-stack,"",@progbits
