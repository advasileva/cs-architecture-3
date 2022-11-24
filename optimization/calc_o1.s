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
	movapd	%xmm0, %xmm3
	subsd	.LC0(%rip), %xmm0
	andpd	.LC1(%rip), %xmm0
	comisd	.LC2(%rip), %xmm0
	jb	.L8
	movsd	.LC0(%rip), %xmm2
	movapd	%xmm2, %xmm0
	movl	$1, %eax
	movq	.LC1(%rip), %xmm5
	movsd	.LC2(%rip), %xmm4
.L4:
	mulsd	8(%rsp), %xmm0
	pxor	%xmm1, %xmm1
	cvtsi2sdl	%eax, %xmm1
	divsd	%xmm1, %xmm0
	addl	$1, %eax
	addsd	%xmm0, %xmm2
	movapd	%xmm3, %xmm1
	subsd	%xmm2, %xmm1
	andpd	%xmm5, %xmm1
	comisd	%xmm4, %xmm1
	jnb	.L4
.L1:
	movapd	%xmm2, %xmm0
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L8:
	.cfi_restore_state
	movsd	.LC0(%rip), %xmm2
	jmp	.L1
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
