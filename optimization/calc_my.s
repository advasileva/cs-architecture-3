	.intel_syntax noprefix			# указание интеловского синтаксиса
	.text							# начало секции
	.globl	calc					# метка глобальности для линкера
calc:								# метка функции "find"
	push	rbp						# (пролог) сохраняем rbp на стек
	mov	rbp, rsp					# записываем rsp в rbp
	sub	rsp, 48						# сдвигаем rsp
	movsd	xmm8, xmm0				# записываем в регистр: x
	mov	r12d, 1						# записываем в регистр: i = 1 (int - 4 byte)
	movsd	xmm5, QWORD PTR .LC0[rip]# записываем в регистр: el = 1
	movsd	xmm6, QWORD PTR .LC0[rip]# записываем в регистр: s = 1
	movsd	xmm0, xmm8				# получаем x
	call	exp@PLT					# вызываем exp(x)
	movsd	xmm7, xmm0				# записываем в регистр: answer = exp(x)
	jmp	.L2							# переходим к .L2
.L3:								# метка ".L2" - тело цикла
	movsd	xmm0, xmm5				# получаем el
	mulsd	xmm0, xmm8				# получаем x
	pxor	xmm1, xmm1				# умножаем
	cvtsi2sd	xmm1, r12d			# получаем i
	divsd	xmm0, xmm1				# делим
	movsd	xmm5, xmm0				# записываем результат в el
	add	r12d, 1						# инкрементируем i
	movsd	xmm0, xmm6				# получаем s
	addsd	xmm0, xmm5				# прибавляем el
	movsd	xmm6, xmm0				# записываем сумму в s
.L2:								# метка ".L2" - начало цикла
	movsd	xmm0, xmm7				# получаем answer
	subsd	xmm0, xmm6				# получаем answer - s
	movq	xmm1, QWORD PTR .LC1[rip]# получаем шаблон для модуля
	andpd	xmm0, xmm1				# хитро берём модуль разности
	comisd	xmm0, QWORD PTR .LC2[rip]# получаем 0.001
	jnb	.L3							# проверка условия цикла
	movsd	xmm0, xmm6				# возвращаем s
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
