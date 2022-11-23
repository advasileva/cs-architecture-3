	.intel_syntax noprefix			# указание интеловского синтаксиса
	.text							# начало секции
	.globl	calc					# метка глобальности для линкера
calc:								# метка функции "find"
	push	rbp						# (пролог) сохраняем rbp на стек
	mov	rbp, rsp					# записываем rsp в rbp
	sub	rsp, 48						# сдвигаем rsp
	movsd	QWORD PTR -40[rbp], xmm0# записываем на стек: x (int - 4 byte)
	mov	r12d, 1						# записываем в регистр: i = 1 (int - 4 byte)
	movsd	xmm0, QWORD PTR .LC0[rip]# получаем 1 типа double
	movsd	QWORD PTR -16[rbp], xmm0# записываем на стек: el = 1
	movsd	xmm0, QWORD PTR .LC0[rip]# получаем 1 типа double
	movsd	QWORD PTR -24[rbp], xmm0# записываем на стек: s = 1
	mov	rax, QWORD PTR -40[rbp]		# получаем x
	movq	xmm0, rax				# для работы с double
	call	exp@PLT					# вызываем exp(x)
	movq	rax, xmm0				# для работы с double
	mov	QWORD PTR -32[rbp], rax		# записываем результат в answer
	jmp	.L2							# переходим к .L2
.L3:								# метка ".L2" - тело цикла
	movsd	xmm0, QWORD PTR -16[rbp]# получаем el
	mulsd	xmm0, QWORD PTR -40[rbp]# получаем x
	pxor	xmm1, xmm1				# умножаем
	cvtsi2sd	xmm1, r12d			# получаем i
	divsd	xmm0, xmm1				# делим
	movsd	QWORD PTR -16[rbp], xmm0# записываем результат в el
	add	r12d, 1						# инкрементируем i
	movsd	xmm0, QWORD PTR -24[rbp]# получаем s
	addsd	xmm0, QWORD PTR -16[rbp]# прибавляем el
	movsd	QWORD PTR -24[rbp], xmm0# записываем сумму в s
.L2:								# метка ".L2" - начало цикла
	movsd	xmm0, QWORD PTR -32[rbp]# получаем answer
	subsd	xmm0, QWORD PTR -24[rbp]# получаем answer - s
	movq	xmm1, QWORD PTR .LC1[rip]# получаем шаблон для модуля
	andpd	xmm0, xmm1				# хитро берём модуль разности
	comisd	xmm0, QWORD PTR .LC2[rip]# получаем 0.001
	jnb	.L3							# проверка условия цикла
	movsd	xmm0, QWORD PTR -24[rbp]# возвращаем s
	leave							# (эпилог)
	ret								# выход из функции
.LC0:								# метка ".L0"
	.long	0						# представление
	.long	1072693248				# значения 1
	.align 16						# типа double
.LC1:								# метка ".L1"
	.long	-1						# шаблон
	.long	2147483647				# для хитрого
	.long	0						# получения
	.long	0						# модуля
	.align 8						# abs()
.LC2:								# метка ".L2"
	.long	-755914244				# представление
	.long	1062232653				# значения 0.001 типа double
