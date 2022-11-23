	.intel_syntax noprefix			# указание интеловского синтаксиса
	.text							# начало секции
	.globl	timeDelta				# метка глобальности для линкера
timeDelta:							# метка функции "timeDelta"
	push	rbp						# (пролог) сохраняем rbp на стек
	mov	rbp, rsp					# записываем rsp в rbp
	mov	rax, rsi					# меняем регистры, чтобы положить переменные на стек
	mov	rsi, rdi					# входными параметрами функции являются структуры из 2 полей,
	mov	rdi, rax					# поэтому нам нужно 2*2=4 ячейки по 8 байт
	mov	QWORD PTR -32[rbp], rsi		# кладём на стек: finish.tv_sec
	mov	QWORD PTR -24[rbp], rdi		# кладём на стек: finish.tv_nsec
	mov	QWORD PTR -48[rbp], rdx		# кладём на стек: start.tv_sec
	mov	QWORD PTR -40[rbp], rcx		# кладём на стек: start.tv_nsec
	mov	rax, QWORD PTR -48[rbp]		# rax = start.tv_sec
	imul	rax, rax, 1000000000	# nsecStart *= 1000000000;
	mov	QWORD PTR -8[rbp], rax		# rbp[-8] = nsecStart
	mov	rax, QWORD PTR -40[rbp]		# rax = start.tv_nsec
	add	QWORD PTR -8[rbp], rax		# nsecStart += start.tv_nsec;
	mov	rax, QWORD PTR -32[rbp]		# rax = finish.tv_sec
	imul	rax, rax, 1000000000	# nsecFinish *= 1000000000;
	mov	QWORD PTR -16[rbp], rax		# rbp[-16] = nsecFinish
	mov	rax, QWORD PTR -24[rbp]		# rax = finish.tv_nsec
	add	QWORD PTR -16[rbp], rax		# nsecFinish += finish.tv_nsec
	mov	rax, QWORD PTR -16[rbp]		# rax = nsecFinish
	sub	rax, QWORD PTR -8[rbp]		# nsecFinish - nsecStart;
	pop	rbp							# (эпилог)
	ret								# выход из функции
	.section	.rodata				# .rodata
.LC0:								# метка ".LC0"
	.string	"Incorrect input"		# строковая константа для сообщения об ошибке
.LC1:								# метка ".LC1"
	.string	"r"						# строковая константа для флага открытия файла на чтение
.LC2:								# метка ".LC2"
	.string	"w"						# строковая константа для флага открытия файла на запись
.LC3:								# метка ".LC3"
	.string	"%lf"					# строковая константа для формата ввода-вывода double
.LC4:								# метка ".LC4"
	.string	"input"					# строковая константа для названия дефолтного входного файла
.LC5:								# метка ".LC5"
	.string	"output"				# строковая константа для названия дефолтного выходного файла
.LC6:								# метка ".LC6"
	.string	"%f"					# строковая константа для формата ввода-вывода double
.LC7:								# метка ".LC7"
	.string	"Time delta: %ld ns\n"	# строковая константа для формата вывода результата замера времени
	.text							# начало секции
	.globl	main					# секция с кодом
main:								# метка функции "main"
	push	rbp						# (пролог) сохраняем rbp на стек
	mov	rbp, rsp					# записываем rsp в rbp
	sub	rsp, 112					# сдвигаем rsp
	mov	DWORD PTR -100[rbp], edi	# кладём на стек: rdi - argc (4 byte)
	mov	QWORD PTR -112[rbp], rsi	# кладём на стек: rsi - argv (8 byte)
	cmp	DWORD PTR -100[rbp], 2		# сравниваем argc и 2 (проверка argc < 3)
	jg	.L4							# продолжаем работу
	lea	rdi, .LC0[rip]				# загружаем строку "Incorrect input"
	call	puts@PLT				# вывод строки
	mov	eax, 0						# обнуляем eax
	jmp	.L12						# переходим к выходу из программы
.L4:								# метка ".L4" - продолжение программы
	mov	rax, QWORD PTR -112[rbp]	# получаем указатель на argv в памяти
	add	rax, 8						# переходим к argv[1]
	mov	rdi, QWORD PTR [rax]		# помещаем значение argv[1] в rdi
	call	atoi@PLT				# вызываем atoi()
	mov	DWORD PTR -28[rbp], eax		# помещаем результат приведения argv[1] к int в count
	mov	rax, QWORD PTR -112[rbp]	# получаем указатель на argv в памяти
	add	rax, 16						# переходим к argv[2]
	mov	rdi, QWORD PTR [rax]		# помещаем значение argv[2] в rdi
	call	atoi@PLT				# вызываем atoi()
	test	eax, eax				# хитро проверяем, что после приведения к int у нас получился 0
	jne	.L6							# если не 0, то переходим к вводу с помощью генератора (else-ветка)
	cmp	DWORD PTR -100[rbp], 3		# проверяем, что argc < 4
	jle	.L7							# переходим к выводу ошибки
	mov	rax, QWORD PTR -112[rbp]	# получаем указатель на argv в памяти
	add	rax, 24						# переходим к argv[3]
	mov	rdi, QWORD PTR [rax]		# помещаем значение argv[3] в rdi
	mov	esi, 0						# обнуляем esi
	call	access@PLT				# вызываем access()
	test	eax, eax				# хитро проверяем, что после приведения к int у нас получился 0
	je	.L8							# продолжаем работу
.L7:								# метка ".L7" - вывод ошибки
	lea	rdi, .LC0[rip]				# загружаем строку "Incorrect input"
	call	puts@PLT				# вывод строки
	mov	eax, 0						# обнуляем eax
	jmp	.L12						# переходим к выходу из программы
.L8:								# метка ".L11" - продолжение ввода строки из файла
	mov	rax, QWORD PTR -112[rbp]	# получаем указатель на argv в памяти
	add	rax, 24						# переходим к argv[3]
	mov	rax, QWORD PTR [rax]		# помещаем значение argv[3] в rdi
	lea	rsi, .LC1[rip]				# загружаем строку "r"
	call	fopen@PLT				# вызываем fopen()
	mov	QWORD PTR -40[rbp], rax		# input = fopen(argv[4], "r");
	mov	rax, QWORD PTR -112[rbp]	# получаем указатель на argv в памяти
	add	rax, 32						# переходим к argv[4]
	mov	rdi, QWORD PTR [rax]		# помещаем значение argv[4] в rdi
	lea	rsi, .LC2[rip]				# загружаем строку "w"
	call	fopen@PLT				# вызываем fopen()
	mov	QWORD PTR -24[rbp], rax		# output = fopen(argv[4], "w");
	lea	rdx, -56[rbp]				# получаем указатель на x, чтобы положить туда значение
	mov	rdi, QWORD PTR -40[rbp]		# получаем значение input
	lea	rsi, .LC3[rip]				# загружаем строку "%lf"
	mov	eax, 0						# обнуляем eax
	call	__isoc99_fscanf@PLT		# вызов fscanf()
	jmp	.L9							# переходим к .L9
.L6:								# метка ".L6" - ввод с помощью генератора
	lea	rsi, .LC2[rip]				# загружаем строку "w"
	lea	rdi, .LC4[rip]				# загружаем строку "input"
	call	fopen@PLT				# вызываем fopen()
	mov	QWORD PTR -40[rbp], rax		# input = fopen("input", "w");
	lea	rsi, .LC2[rip]				# загружаем строку "w"
	lea	rdi, .LC5[rip]				# загружаем строку "output"
	call	fopen@PLT				# вызываем fopen()
	mov	QWORD PTR -24[rbp], rax		# output = fopen("output", "w");
	call	rand@PLT				# вызываем rand()
	mov	edx, eax
	movsx	rax, edx
	imul	rax, rax, 1374389535
	shr	rax, 32
	sar	eax, 3
	mov	esi, edx
	sar	esi, 31
	sub	eax, esi
	mov	ecx, eax
	mov	eax, ecx
	sal	eax, 2
	add	eax, ecx
	lea	ecx, 0[0+rax*4]
	add	eax, ecx
	mov	ecx, edx
	sub	ecx, eax
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, ecx
	movsd	QWORD PTR -56[rbp], xmm0
	mov	rdx, QWORD PTR -56[rbp]
	mov	rax, QWORD PTR -40[rbp]
	movq	xmm0, rdx
	lea	rsi, .LC6[rip]
	mov	rdi, rax
	mov	eax, 1
	call	fprintf@PLT				# вызываем fprintf()
.L9:								# метка ".L14" - после if-else
	lea	rsi, -80[rbp]				# получаем ссылку на start
	mov	edi, 1						# записываем время отсчёта
	call	clock_gettime@PLT		# вызываем clock_gettime()
	mov	DWORD PTR -4[rbp], 0		# обнуляем итератор
	jmp	.L10						# переходим к .L10
.L11:								# метка ".L11" - тело цикла вычисления суммы ряда
	mov	rax, QWORD PTR -56[rbp]		# получаем x со стека
	movq	xmm0, rax				# для работы с double
	call	calc@PLT				# вызываем calc()
	movq	rax, xmm0				# для работы с double
	mov	QWORD PTR -16[rbp], rax		# записываем результат в result
	add	DWORD PTR -4[rbp], 1		# инкрементируем i
.L10:								# метка ".L10" - цикл вычисления суммы ряда
	mov	eax, DWORD PTR -4[rbp]		# получаем i со стека
	cmp	eax, DWORD PTR -28[rbp]		# получаем count со стека и проверяем, что i < count
	jl	.L11						# переходим к следующей итерации
	lea	rsi, -96[rbp]				# получаем ссылку на finish
	mov	edi, 1						# записываем время отсчёта
	call	clock_gettime@PLT		# вызов clock_gettime()
	mov	rdx, QWORD PTR -80[rbp]		# получаем start.tv_sec со стека
	mov	rcx, QWORD PTR -72[rbp]		# получаем start.tv_nsec со стека
	mov	rdi, QWORD PTR -96[rbp]		# получаем finish.tv_sec со стека
	mov	rsi, QWORD PTR -88[rbp]		# получаем finish.tv_nsec со стека
	call	timeDelta				# вызываем timeDelta()
	mov	QWORD PTR -48[rbp], rax		# записываем результат в time_delta
	mov	rsi, QWORD PTR -48[rbp]		# получаем time_delta
	lea	rdi, .LC7[rip]				# загрузка строки "Time delta: %ld ns\n"
	mov	eax, 0						# обнуляем eax
	call	printf@PLT				# вызываем printf()
	mov	rdx, QWORD PTR -16[rbp]		# получаем result со стека
	mov	rdi, QWORD PTR -24[rbp]		# получаем output со стека
	movq	xmm0, rdx				# для работы с double
	lea	rsi, .LC6[rip]				# загрузка строки "%f"
	call	fprintf@PLT				# вызываем printf()
.L12:								# метка ".L8" - выход из программы 
	leave							# (эпилог)
	ret								# выход из функции