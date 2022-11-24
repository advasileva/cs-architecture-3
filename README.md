# Архитектура вычислительных систем ИДЗ 3

0. [**Задание**](#задание)
0. [**Отчёт**](#отчёт)
    + [*4 балла*](#4-балла)
    + [*5 баллов*](#5-баллов)
    + [*6 баллов*](#6-баллов)
    + [*7 баллов*](#7-баллов)
    + [*8 баллов*](#8-баллов)
    + [*9 баллов*](#9-баллов)
0. [**Дерево проекта**](#дерево-проекта)
0. [**Инструкции по запуску**](#инструкции-по-запуску)

## Задание

*Разработать программы на языках программирования C и Ассемблер, выполняющие вычисления над числами с плавающей точкой. Разработанные программы должны принимать числа в допустимом диапазоне. Например, нужно учитывать области определения и допустимых значений, если это связано с условием задачи.*

*Вариант 13.  Разработать программу, вычисляющую с помощью степенного ряда с точностью не хуже 0,1% значение функции e^x для заданного параметра x.*

## Отчёт

**Делала на оценку 9 баллов**

Для удобства проверки структурировала отчёт по критериям

### 4 балла

+ *Приведено решение задачи на C на планируемую оценку. Ввод данных осуществляется с клавиатры. Вывод данных осуществляется на дисплей.*

    Код на C находится в `main.c` и `calc.c`

    Скомпилированная программа на C находится в `c.exe`

    Ввод-вывод реализован с помощью файлов в соответствии с требованиями на 7, на дисплей выводятся сообщения об ошибках

+ *В полученную ассемблерную программу, откомпилированную без оптимизирующих и отладочных опций, добавлены комментарии, поясняющие эквивалентное представление переменных в программе на C. То есть, для всех ссылок на память, включая и относительные адреса и регистры, указать имя переменной на языке C исходной программы.*

    Полностью прокомментированная ассемблерная программа находится в `main.s` и `calc.s`

    Скомпилированная ассемблерная программа находится в `asm.exe`

    Пример комментария, поясняющего эквивалентное представление переменных:
    ```
	mov	QWORD PTR -32[rbp], rsi		# кладём на стек: finish.tv_sec
	mov	QWORD PTR -24[rbp], rdi		# кладём на стек: finish.tv_nsec
	mov	QWORD PTR -48[rbp], rdx		# кладём на стек: start.tv_sec
	mov	QWORD PTR -40[rbp], rcx		# кладём на стек: start.tv_nsec
    ```

+ *Из ассемблерной программы убраны лишние макросы за счет использования при компиляции из C соответствующих аргументов командной строки и/или за счет ручного редактирования исходного текста ассемблерной программы.*

    Ассемблерная программа сразу после получения ассемблера находится в `stages/main.bare.s` и `stages/calc.bare.s`

    Использованы соответствующие аргументы командной строки / опции компиляции, которые указаны в `scripts/make-asm.sh`

    За счёт ручного редактирования ассемблерной программы размер `main.s` сократился с 205 строк до 176

    Примеры удалённого из `main.s`:
    ```
	.file	"main.c"
    ```
    ```
	.type	timeDelta, @function
    ```
    ```
    mov	QWORD PTR -8[rbp], rax      # и много подобных конструкций
	mov	rax, QWORD PTR -8[rbp]
    ```
    ```
    .size	timeDelta, .-timeDelta
    ```
    ```
	mov	rdi, r9
    ```
    ```
	.size	main, .-main
	.ident	"GCC: (GNU) 10.3.1 20210703 (ALT Sisyphus 10.3.1-alt2)"
	.section	.note.GNU-stack,"",@progbits
    ```

    Примеры удалённого из `calc.s`:
    ```
    .file	"calc.c"
    ```
    ```
	.type	calc, @function
    ```
    ```
	.ident	"GCC: (GNU) 10.3.1 20210703 (ALT Sisyphus 10.3.1-alt2)"
	.section	.note.GNU-stack,"",@progbits
    ```

    Примеры оптимизации в `main.s`

    +   Было:
        ```
        mov	rax, QWORD PTR [rax]
        mov	rdi, rax
        ```
        Стало:
        ```
        mov	rdi, QWORD PTR [rax]
        ```

    +   Было:
        ```
        mov	r8, rdi
        mov	rsi, r8
        ```
        Стало:
        ```
        mov	rsi, rdi
        ```
    +   Было:
        ```
        mov	rax, QWORD PTR -80[rbp]
        mov	rdx, QWORD PTR -72[rbp]
        mov	rdi, QWORD PTR -96[rbp]
        mov	rsi, QWORD PTR -88[rbp]
        mov	rcx, rdx
        mov	rdx, rax
        ```
        Стало:
        ```
        mov	rdx, QWORD PTR -80[rbp]		# получаем start.tv_sec со стека
        mov	rcx, QWORD PTR -72[rbp]		# получаем start.tv_nsec со стека
        mov	rdi, QWORD PTR -96[rbp]		# получаем finish.tv_sec со стека
        mov	rsi, QWORD PTR -88[rbp]		# получаем finish.tv_nsec со стека
        ```

+ *Модифицированная ассемблерная программа отдельно откомпилирована и скомпонована без использования опций отладки.*

    Скомпилированная ассемблерная программа находится в `asm.exe`

+ *Представлено полное тестовое покрытие, дающее одинаковый результат на обоих программах. Приведены результаты тестовых прогонов для обоих программ, демонстрирующие эквивалентность функционирования.*

    Тесты находятся в `tests/`. Их 6, они включают как целые, так и вещественные значения аргумента

    Результаты прогонов (в скрипте есть печать diff, поэтому результаты работы программ на С и на ассемблере идентичны и совпадают с эталонным ответом)
    ```bash
    $ make test
    Test ASM
    Test 1
    Time delta: 3455 ns

    Test 2
    Time delta: 5073 ns

    Test 3
    Time delta: 4839 ns

    Test 4
    Time delta: 4166 ns

    Test 5
    Time delta: 4944 ns

    Test 6
    Time delta: 5421 ns

    Test C
    Test 1
    Time delta: 3051 ns

    Test 2
    Time delta: 5492 ns

    Test 3
    Time delta: 5413 ns

    Test 4
    Time delta: 5108 ns

    Test 5
    Time delta: 5953 ns

    Test 6
    Time delta: 5666 ns
    ```

+ *Для сопоставления с полученной ассемблерной программой необходимо также приложить исходные тексты на ассемблере, сформированные компилятором языка C.*

    Исходные тексты на ассемблере находится в `stages/main.bare.s` и `stages/calc.bare.s`

+ *Сформирован отчет с результатами тестовых прогонов и описанием используемых опций компиляции, проведенных модификаций ассемблерной программы.*

    Отчёт сформирован

### 5 баллов

+ *В программе на языке C необходимо использовать функции с передачей данных через формальные параметры.*

    Функция `calc(double x)` использует передачу данных через параметры, в ассемблерной программе эта функция работает аналогично

+ *Внутри функций необходимо использовать локальные переменные, которые при компиляции отображаются на стек.*

    Пример использования локальной переменной в `calc.c`:
    ```
    input = fopen("input", "w");
    ```
    и её же в `calc.s`:
    ```
    mov	QWORD PTR -40[rbp], rax		# input = fopen("input", "w");
    ```

+ *В ассемблерную программу в местах вызова функции добавить комментарии, описывающие передачу фактических параметров и перенос возвращаемого результата. При этом небходимо отметить, какая переменная или результат какого выражения соответствует тому или иному фактическому параметру.*

    Полностью прокомментированная ассемблерная программа находится в `main.s` и `calc.s`

    Пример комментария, описывающего передачу фактических параметров:
    ```
    mov	rdx, QWORD PTR -80[rbp]		# получаем start.tv_sec со стека
	mov	rcx, QWORD PTR -72[rbp]		# получаем start.tv_nsec со стека
	mov	rdi, QWORD PTR -96[rbp]		# получаем finish.tv_sec со стека
	mov	rsi, QWORD PTR -88[rbp]		# получаем finish.tv_nsec со стека
	call	timeDelta				# вызываем timeDelta()
    ```
    Пример комментария, описывающего перенос возвращаемого результата:
    ```
	call	timeDelta				# вызываем timeDelta()
	mov	QWORD PTR -48[rbp], rax		# записываем результат в time_delta
    ```

+ *В ассемблерных функциях для каждого формального параметра необходимо добавить комментарии, описывающие связь между именами формальных параметров на языке C и регистрами (или значением на стеке), через которые эти параметры передаются.*

    Полностью прокомментированная ассемблерная программа находится в `main.s` и `calc.s`

    Пример комментария, описывающего связь между параметрами языка Си и регистрами (стеком):
    ```
    mov	rdx, QWORD PTR -112[rbp]	# получаем start.tv_sec со стека
	mov	rcx, QWORD PTR -104[rbp]	# получаем start.tv_nsec со стека
	mov	rdi, QWORD PTR -128[rbp]	# получаем finish.tv_sec со стека
	mov	rsi, QWORD PTR -120[rbp]	# получаем finish.tv_nsec со стека
    ```

+ *Для сопоставления с полученной ассемблерной программой необходимо также приложить исходные тексты на ассемблере, сформированные компилятором языка C.*

    Исходные тексты на ассемблере находится в `stages/main.bare.s` и `stages/calc.bare.s`

+ *Информацию о проведенных изменениях отобразить в отчете наряду с информацией, необходимой на предыдущую оценку.*

    Информация добавлена в отчёт

### 6 баллов

+ *Рефакторинг программы на ассемблере. Помимо ранее описанных требований он должен включать дополнительную ручную оптимизацию, связанную с использованием регистров процессора вместо обращения к памяти. То есть, предполагается перенос в регистры ряда (не всех) переменных, что предположительно может ускорить выполнение программы. Возможно написание ассемблерной программы с нуля, используя собственное распределение регистров с самого начала.*

    Так как в основной программе многократно вызывает функция `calc`, то использование регистров процессора было сделано в ней, пример замены:
    ```
    rbp[-4]   -> r12d
    rbp[-16]  -> xmm5
    rbp[-24]  -> xmm6
    rbp[-32]  -> xmm7
    rbp[-40]  -> xmm8
    ```
    В результате вместо
    ```
    movsd	QWORD PTR -40[rbp], xmm0
	mov	DWORD PTR -4[rbp], 1
	movsd	xmm0, QWORD PTR .LC0[rip]
	movsd	QWORD PTR -16[rbp], xmm0
	movsd	xmm0, QWORD PTR .LC0[rip]
	movsd	QWORD PTR -24[rbp], xmm0
	mov	rax, QWORD PTR -40[rbp]
    ```
    получили
    ```
	movsd	xmm8, xmm0				# записываем в регистр: x
	mov	r12d, 1						# записываем в регистр: i = 1 (int - 4 byte)
	movsd	xmm5, QWORD PTR .LC0[rip]# записываем в регистр: el = 1
	movsd	xmm6, QWORD PTR .LC0[rip]# записываем в регистр: s = 1
	movsd	xmm0, xmm8				# получаем x
    ```

    Программа после рефакторинга находится в `main.s` и `calc.s`

    Исходная ассемблерная программа находится в `stages/main.bare.s` и `stages/calc.bare.s`

+ *Добавление комментариев в разработанную программу, поясняющих эквивалентное использование регистров вместо переменных исходной программы на C.*

    Полностью прокомментированная ассемблерная программа находится в `main.s` и `calc.s`

    Пример комментария, описывающего эквивалентное использование регистров вместо переменных исходной программы на C:
    ```
	movsd	xmm8, xmm0				# записываем в регистр: x
	mov	r12d, 1						# записываем в регистр: i = 1 (int - 4 byte)
	movsd	xmm5, QWORD PTR .LC0[rip]# записываем в регистр: el = 1
	movsd	xmm6, QWORD PTR .LC0[rip]# записываем в регистр: s = 1
	movsd	xmm0, xmm8				# получаем x
    ```

+ *Представление результатов тестовых прогонов для разработанной программы. Оценка корректности ее выполнения на основе сравнения тестовых прогонов результатами тестирования программы, разработанной на языке C.*

    Результат тестового прогона (diff ничего не вывел - всё хорошо):
    ```bash
    $ make test
    Test ASM
    Test 1
    Time delta: 3455 ns

    Test 2
    Time delta: 5073 ns

    Test 3
    Time delta: 4839 ns

    Test 4
    Time delta: 4166 ns

    Test 5
    Time delta: 4944 ns

    Test 6
    Time delta: 5421 ns

    Test C
    Test 1
    Time delta: 3051 ns

    Test 2
    Time delta: 5492 ns

    Test 3
    Time delta: 5413 ns

    Test 4
    Time delta: 5108 ns

    Test 5
    Time delta: 5953 ns

    Test 6
    Time delta: 5666 ns
    ```

+ *Сопоставление размеров программы на ассемблере, полученной после компиляции с языка C с модифицированной программой, использующей регистры. Сопоставление программ необходимо проводить на уровне объектных и бинарных файлов. Исходные тексты ассемблерных программ сравнивать вряд ли имеет смысл из-за наличия в модифицированной программе комментариев.*

    Программа, полученная после компиляции с языка С занимает 296 строк и 52656 байт, а модифицированная программа - 224 строки и 52432 байта

+ *Для сопоставления с полученной ассемблерной программой необходимо также приложить исходные тексты на ассемблере, сформированные компилятором языка C.*

    Исходные тексты на ассемблере находится в `stages/main.bare.s` и `stages/calc.bare.s`

+ *Добавление информации о проведенных изменениях в отчет.*

    Информация добавлена в отчёт

### 7 баллов

+ *Исходные данные и формируемые результаты должны вводиться и выводиться через файлы. Имена файлов задаются с использованием аргументов командной строки. Ввод данных в программу с клавиатуры и вывод их на дисплей не нужен. За исключением сообщений об ошибках.*

    Использованы аргументы командной строки для задания входного и выходного файлов:
    ```c
    input = fopen(argv[3], "r");
    output = fopen(argv[4], "w");
    ```

    Во входном файле находится только `x`

+ *Командная строка проверяется на корректность числа аргументов. В программе должна присутствовать проверка на корректное открытие файлов. При наличии ошибок должны выводиться соответствующие сообщения.*

    Проверка командной строки на корректность числа аргументов:
    ```c
    if (argc < 3) {
        printf("Incorrect input\n");
        return 0;
    }
    ```

    Проверка командной строки на корректное открытие файлов:
    ```c
    if (argc < 4 || access(argv[3], F_OK) != 0) {
        printf("Incorrect input\n");
        return 0;
    }
    ```

+ *Реализация программы на ассемблере в виде двух или более единиц компиляции (программу на языке C, реализующую новый функционал, разделять допускается, но не обязательно). Сформированная модульная ассемблерная программа должна быть модифицирована в соответствии с выше предъявляемыми требованиями. В нее также должны быть внесены соответствующие комментарии.*

    Использованы две полностью прокомментированные единицы компиляции:
    + `main.s`
    + `calc.s`

+ *Подготовка нескольких файлов, обеспечивающих тестовое покрытие разработанной программы.*

    Подготовлено 12 файлов с тестами, которые находятся в директории `tests/`. Результаты тестовых прогонов выше

+ *Для сопоставления с полученной ассемблерной программой необходимо также приложить исходные тексты на ассемблере, сформированные компилятором языка C (их число определяется количеством единиц компиляции в программе на языке C).*

    Исходные тексты на ассемблере находится в `stages/main.bare.s` и `stages/calc.bare.s`

+ *Отображение в отчете информации о проведенном функциональном расширении, формате входных файлов, формате командной строки и результатах работы с тестовыми файлами.*

    Информация добавлена в отчёт

### 8 баллов

+ *Использование в разрабатываемых программах генератора случайных наборов данных, расширяющих возможности тестирования. Выбор и объем данных для случайной генерации определяется особенностями разрабатываемой программы.*

    Первый аргумент командной строки - `count` - количество повторов функции `calc`

    Вариант ввода данных выбирается с помощью второго аргумента командной строки:
    + `0` - ввод из указанного в третьем аргументе файла, вывод в указанный четвёртым аргументом файл
    + `1` - ввод с помощью генератора, сгенерированное число `x` выводится в `input`, найденная сумма ряда выводится в `output`

    Ввод числа `x`:
    ```c
    if (atoi(argv[2]) == 0) {
        if (argc < 4 || access(argv[3], F_OK) != 0) {
            printf("Incorrect input\n");
            return 0;
        }
        input = fopen(argv[3], "r");
        output = fopen(argv[4], "w");
        fscanf(input, "%lf", &x);
    } else {
        input = fopen("input", "w");
        output = fopen("output", "w");
        x = rand() % 25;
        fprintf(input, "%f", x);
    }
    ```

+ *Изменение формата командной строки с учетом выбора ввода из файлов или с использованием генератора. При вводе команды необходимо однозначно определять ввод данных из файла или с использованием генератора случайных чисел. Вывод данных в обоих случаях осуществляется в файл. Помимо этого необходимо предусмотреть в командной строке дополнительную опцию, обеспечивающую выполнение программы в режиме многократного зацикливания основных вычислений, если размера вводимых данных недостаточно для проведения замеров времени.*

    Описано в предыдущем пункте

+ *Включение в программы функций, обеспечивающих замеры времени для проведения сравнения на производительность. Необходимо добавить замеры во времени, которые не учитывают время ввода и вывода данных.*

    Замер времени выполнения без ввода-вывода:
    ```c
    clock_gettime(CLOCK_MONOTONIC, &start);

    for(i = 0; i < count; i++) {
        result = calc(n, size, str);
    }

    clock_gettime(CLOCK_MONOTONIC, &finish);

    time_delta = timeDelta(finish, start);
    printf("Time delta: %ld ns\n", time_delta);
    ```

+ *Сравнение по времени осуществлять для программы, написанной на C и программы на ассемблере, сформированной в результате всех модификаций с учетом текущих и предшествующих требований. Именно эта программа должна быть модифицирована и прокомментирована.*

    Результат тестового прогона со сравнением работы программы на C и ассемблерной программы
    ```
    $ make compare
    Test 1
    ~~~ASM-program~~~
    Time delta: 198602820 ns
    ~~~~C-program~~~~
    Time delta: 192491831 ns

    Test 2
    ~~~ASM-program~~~
    Time delta: 774443775 ns
    ~~~~C-program~~~~
    Time delta: 668546864 ns

    Test 3
    ~~~ASM-program~~~
    Time delta: 571880539 ns
    ~~~~C-program~~~~
    Time delta: 423010603 ns

    Test 4
    ~~~ASM-program~~~
    Time delta: 4171296116 ns
    ~~~~C-program~~~~
    Time delta: 2944977538 ns

    Test 5
    ~~~ASM-program~~~
    Time delta: 7807834769 ns
    ~~~~C-program~~~~
    Time delta: 5554779563 ns

    Test 6
    ~~~ASM-program~~~
    Time delta: 12890935723 ns
    ~~~~C-program~~~~
    Time delta: 9980302399 ns
    ```
    Видим, что ассемблерная программа работает медленнее (до замены переменных на стеке на регистры работала быстрее)

+ *Для увеличения времени работы, в зависимости от особенностей программы, можно либо выбирать соответствующие размеры исходных данных, либо зацикливать для многократного выполнения ту часть программы, которая выполняет вычисления. В последнем случае можно использовать соответствующую опцию командной строки, задающей количество повторений для одних и тех же вычислений.*

    Вычисления программы выполняются `count` раз

+ *Для сопоставления с полученной ассемблерной программой необходимо также приложить исходные тексты на ассемблере, сформированные компилятором языка C (их число определяется количеством единиц компиляции в программе на языке C).*

    Исходные тексты на ассемблере находится в `stages/main.bare.s` и `stages/calc.bare.s`

+ *Представить полученные временные данные в отчете для разных вариантов тестовых прогонов (наряду с другими данными, полученные при выполнении ранее описанных требований). Сравнительные данные, как и данные о размере кода, можно представить в соответствующей таблице.*

    Информация добавлена в отчёт


### 9 баллов

+ *Используя опции оптимизации по скорости, сформировать из программы на на C исходный код ассемблере. Провести сравнительный анализ с ассемблерной программой без оптимизации по размеру ассемблерного кода, размеру исполняемого файла и производительности. Сопоставить эти программы с собственной программой, разработанной на ассемблере, в которой вместо переменных максимально возможно используются регистры.*

    Для оптимизации по скорости использовались флаги `-O0` `-O1` `-O2` `-O3` `-Ofast`, также для сравнения представлены программа, скомпилированная без флагов оптимизации и опитимизированная мной программа (последняя версия с комментариями)

    Скрипт для формирования программ с использованием опций оптимизации находится в `scripts/optimize.sh`

    Результат сравнительного анализа:
    ```bash
    $ make compare.opt
    ~~~Test non-optimization~~~
    Number of lines: 296
    Size in bytes: 52656
    Time delta: 11229743069 ns

    ~~~Test o0-optimization~~~
    Number of lines: 296
    Size in bytes: 52656
    Time delta: 9982603841 ns

    ~~~Test o1-optimization~~~
    Number of lines: 250
    Size in bytes: 52656
    Time delta: 8315850973 ns

    ~~~Test o2-optimization~~~
    Number of lines: 252
    Size in bytes: 52720
    Time delta: 5730843732 ns

    ~~~Test o3-optimization~~~
    Number of lines: 252
    Size in bytes: 52720
    Time delta: 5926900849 ns

    ~~~Test ofast-optimization~~~
    Number of lines: 252
    Size in bytes: 52720
    Time delta: 5956822835 ns

    ~~~Test os-optimization~~~
    Number of lines: 231
    Size in bytes: 52720
    Time delta: 10660777135 ns

    ~~~Test my-optimization~~~
    Number of lines: 224
    Size in bytes: 52432
    Time delta: 10882579724 ns
    ```

    Вывод: моя программа работает быстрее, чем программа без оптимизации

+ *Аналогично, используя опции оптимизации по размеру, сформировать код на ассемблере. Провести сравнительный анализ с неоптимизированной программой по размеру ассемблерного кода, размеру исполняемого файла и производительности. Сопоставить эти программы с собственной программой, разработанной на ассемблере, в которой вместо переменных максимально возможно используются регистры.*

    Для оптимизации по размеру использовалась опция `-0s`, полный отчёт представлен в предыдущем пункте

    Вывод: моя программа сравнима с остальными по размеру исполняемого файла, но короче всех программ по количеству строк

+ *Привести различные варианты ассемблерных текстов, полученные в ходе компиляции с применением различных опций. Все ассем6лерные программы рекомендуется разместить в отдельных подкаталогах с пояснением в отчете, что и где расположено.*

   Все полученные верианты ассемблерных текстов, полученные в ходе компиляции с применением различных опций, находятся в директории `optimization/` с соответсвующими названиями

+ *Представить в отчете полученные результаты, дополнив данные, представленные в предыдущем по предыдущим требованиям.*

    Результаты представлены в отчёте

## Дерево проекта

```bash
.
├── asm.exe                             # последняя скомпилированная версия ассемблерной программы
├── c.exe                               # последняя скомпилированная версия программы на С
├── calc.c                              # вспомогательная единица компиляции программы на С
├── calc.s                              # вспомогательная единица компиляции программы на ассемблере
├── input                               # файл с входными данными
├── main.c                              # главная единица компиляции программы на С
├── main.s                              # главная единица компиляции программы на ассемблере
├── Makefile                            # команды для работы с программой
├── optimization                        # директория с файлами для анализа опций оптимизации
│   ├── calc_my.s
│   ├── calc_non.s
│   ├── calc_o0.s
│   ├── calc_o1.s
│   ├── calc_o2.s
│   ├── calc_o3.s
│   ├── calc_ofast.s
│   ├── calc_os.s
│   ├── main_my.s
│   ├── main_non.s
│   ├── main_o0.s
│   ├── main_o1.s
│   ├── main_o2.s
│   ├── main_o3.s
│   ├── main_ofast.s
│   ├── main_os.s
│   ├── my.exe
│   ├── non.exe
│   ├── o0.exe
│   ├── o1.exe
│   ├── o2.exe
│   ├── o3.exe
│   ├── ofast.exe
│   └── os.exe
├── output                              # файл с выходными данными
├── README.md                           # отчёт
├── scripts                             # директория со скриптами
│   ├── compare-opt.sh                  # сравнительный анализ опций оптимизации
│   ├── compare.sh                      # сравнение скорости работы программ на С и на ассемблере
│   ├── compile-asm.sh                  # компиляция ассемблерной программы
│   ├── compile-c.sh                    # компиляция программы на С
│   ├── make-asm.sh                     # получение ассемблера
│   ├── optimize.sh                     # заполнение директории optimization/ соответствующими файлами
│   ├── rand-asm.sh                     # запуск ассемблерной программы с помощью генератора
│   ├── rand-c.sh                       # запуск программы на С с помощью генератора
│   ├── test-asm.sh                     # тестирование ассемблерной программы
│   └── test-c.sh                       # тестирование программы на С
├── stages                              # директория с ассемблерной программой сразу после получения
│   ├── calc.bare.s
│   └── main.bare.s
└── tests                               # директория c тестами
    ├── test1.in
    ├── test1.out
    ├── test2.in
    ├── test2.out
    ├── test3.in
    ├── test3.out
    ├── test4.in
    ├── test4.out
    ├── test5.in
    ├── test5.out
    ├── test6.in
    └── test6.out
```

## Инструкции по запуску

Чтобы не заниматься копированием команд из блокнота в консоль, написала Makefile

Тестирование:
+ обеих программ:
    ```
    make test
    ```
+ ассемблерной прогрммы:
    ```
    make test.asm
    ```
+ программы на С:
    ```
    make test.c
    ```  

Компиляция (программы уже скомпилированы):
+ обеих программ:
    ```
    make compile
    ```
+ ассемблерной прогрммы:
    ```
    make compile.asm
    ```
+ программы на С:
    ```
    make compile.c
    ```  

Cравнение скорости работы программ на С и на ассемблере
```
make compare
``` 

Запуск с помощью генератора (не имеет смысла запускать обе, потому что они используют одни и те же файлы):
+ ассемблерной прогрммы:
    ```
    make rand.asm
    ```
+ программы на С:
    ```
    make rand.c
    ```  

Получение программ с помощью разных опций оптимизации (в директории `optimization/`):
```
make optimize
```

Сравнение программ с различными опциями оптимизации (работает долго, потому что прогоняется на больших тестах):
```
make compare.opt
```
