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

*ASCII-строка — строка, содержащая символы таблицы кодировки ASCII. (https://ru.wikipedia.org/wiki/ASCII). Размер строки может быть достаточно большим, чтобы вмещать многостраничные тексты, например, главы из книг, если задача связана с использованием файлов или строк, порождаемых генератором случайных чисел. Тексты при этом могут не нести смыслового содержания. Для обработки в программе предлагается использовать данные, содержащие символы только из первой половины таблицы (коды в диапазоне 0–127), что связано с использованием кодировки UTF-8 в ОС Linux в качестве основной. Символы, содержащие коды выше 127, должны отсутствовать во входных данных кроме оговоренных специально случаев.*

*Вариант 2. Разработать программу, находящую в заданной ASCII–строке первую при обходе от конца к началу последовательность N символов, каждый элемент которой определяется по условию «больше предшествующего» (N вводится в качестве параметра)*

Задача эквивалентна поиску последней убывающей последовательности из N символов

## Отчёт

**Делала на оценку 9 баллов**

Для удобства проверки структурировала отчёт по критериям

### 4 балла

+ *Приведено решение задачи на C.*

    Код на C находится в `main.c` и `find.c`

    Скомпилированная программа на C находится в `c.exe`

+ *В полученную ассемблерную программу, откомпилированную без оптимизирующих и отладочных опций, добавлены комментарии, поясняющие эквивалентное представление переменных в программе на C.*

    Полностью прокомментированная ассемблерная программа находится в `main.s` и `find.s`

    Скомпилированная ассемблерная программа находится в `asm.exe`

    Пример комментария, поясняющего эквивалентное представление переменных:
    ```
	mov	r13d, edi					# записываем в регистр: n (int - 4 byte)
	mov	r14d, esi					# записываем в регистр: size (int - 4 byte)
	mov	r15, rdx					# записываем в регистр: str (char* - 8 byte)
	mov	r12d, eax					# записываем в регистр: i = 0 (int - 4 byte)
    ```

+ *Из ассемблерной программы убраны лишние макросы за счет использования соответствующих аргументов командной строки и/или за счет ручного редактирования исходного текста ассемблерной программы.*

    Ассемблерная программа сразу после получения ассемблера находится в `stages/main.bare.s` и `stages/find.bare.s`

    Использованы соответствующие аргументы командной строки, которые указаны в `scripts/make-asm.sh`

    За счёт ручного редактирования ассемблерной программы размер `main.s` сократился с 311 строк до 242

    Примеры удалённого из `main.s`:
    ```
	.file	"main.c"
    ```
    ```
	.type	timeDelta, @function
    ```
    ```
	cdqe                            # знаковое расширение, входило 5 раз
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

    Примеры удалённого из `find.s`:
    ```
    .file	"find.c"
    ```
    ```
	.type	find, @function
    ```
    ```
	cdqe                            # знаковое расширение
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
        mov	rax, QWORD PTR -112[rbp]
        mov	rdx, QWORD PTR -104[rbp]
        mov	rdi, QWORD PTR -128[rbp]
        mov	rsi, QWORD PTR -120[rbp]
        mov	rcx, rdx
        mov	rdx, rax
        ```
        Стало:
        ```
        mov	rdx, QWORD PTR -112[rbp]	# получаем start.tv_sec со стека
        mov	rcx, QWORD PTR -104[rbp]	# получаем start.tv_nsec со стека
        mov	rdi, QWORD PTR -128[rbp]	# получаем finish.tv_sec со стека
        mov	rsi, QWORD PTR -120[rbp]	# получаем finish.tv_nsec со стека
        ```

+ *Модифицированная ассемблерная программа отдельно откомпилирована и скомпонована без использования опций отладки.*

    Скомпилированная ассемблерная программа находится в `asm.exe`

+ *Представлено полное тестовое покрытие, дающее одинаковый результат на обоих программах. Приведены результаты тестовых прогонов для обоих программ, демонстрирующие эквивалентность функционирования.*

    Тесты находятся в `tests/`. Их 6, размеры соответственно 3, 4, 15, 100, 1000 и 10000 символов в строке. Последние три теста сгенерированы моей же программой на ассемблере с помощью генератора рандомных чисел

    Результаты прогонов (в скрипте есть печать diff, поэтому результаты работы программ на С и на ассемблере идентичны и совпадают с эталонным ответом)
    ```bash
    $ make test
    Test ASM
    Test 1
    Time delta: 57 ns

    Test 2
    Time delta: 92 ns

    Test 3
    Time delta: 160 ns

    Test 4
    Time delta: 403 ns

    Test 5
    Time delta: 432 ns

    Test 6
    Time delta: 365 ns

    Test C
    Test 1
    Time delta: 50 ns

    Test 2
    Time delta: 144 ns

    Test 3
    Time delta: 278 ns

    Test 4
    Time delta: 406 ns

    Test 5
    Time delta: 457 ns

    Test 6
    Time delta: 453 ns
    ```

+ *Сформировать отчет, описывающий результаты тестовых прогонов и используемых опций компиляции и/или описания проведенных модификаций.*

    Отчёт сформирован

### 5 баллов

+ *В реализованной программе использовать функции с передачей данных через параметры.*

    Функция `find(int n, int size, char *str)` использует передачу данных через параметры, в ассемблерной программе эта функция работает аналогично

+ *Использовать локальные переменные.*

    Пример использования локальной переменной в `main.c`:
    ```
    int max = 1000000;
    ```
    и её же в `main.s`:
    ```
    mov	DWORD PTR -44[rbp], 1000000	# кладём на стек: max = 10000 (int - 4 byte)
    ```

+ *В ассемблерную программу при вызове функции добавить комментарии, описывающие передачу фактических параметров и перенос возвращаемого результата.*

    Полностью прокомментированная ассемблерная программа находится в `main.s` и `find.s`

    Пример комментария, описывающего передачу фактических параметров:
    ```
    mov	rdx, QWORD PTR -64[rbp]		# получаем str со стека
	mov	esi, DWORD PTR -28[rbp]		# получаем size со стека
	mov	edi, DWORD PTR -72[rbp]		# получаем n со стека
	call	find@PLT				# вызываем find()
    ```
    Пример комментария, описывающего перенос возвращаемого результата:
    ```
	call	find@PLT				# вызываем find()
	mov	DWORD PTR -24[rbp], eax		# записываем результат в result
    ```

+ *В функциях для формальных параметров добавить комментарии, описывающие связь между параметрами языка Си и регистрами (стеком).*

    Полностью прокомментированная ассемблерная программа находится в `main.s` и `find.s`

    Пример комментария, описывающего связь между параметрами языка Си и регистрами (стеком):
    ```
    mov	rdx, QWORD PTR -112[rbp]	# получаем start.tv_sec со стека
	mov	rcx, QWORD PTR -104[rbp]	# получаем start.tv_nsec со стека
	mov	rdi, QWORD PTR -128[rbp]	# получаем finish.tv_sec со стека
	mov	rsi, QWORD PTR -120[rbp]	# получаем finish.tv_nsec со стека
    ```

+ *Информацию о проведенных изменениях отобразить в отчете.*

    Информация добавлена в отчёт

### 6 баллов

+ *Рефакторинг программы на ассемблере за счет оптимизации использования регистров процессора. Или написание ассемблерной программы с нуля, используя собственное распределение регистров.*

    Так как в основной программе многократно вызывает функция `find`, то использование регистров процессора было сделано в ней, а именно были произведены следующие замены:
    ```
    rbp[-8]  -> r12d
    rbp[-20] -> r13d
    rbp[-24] -> r14d
    rbp[-32] -> r15
    ```
    В результате вместо
    ```
    mov	DWORD PTR -20[rbp], edi
	mov	DWORD PTR -24[rbp], esi
	mov	QWORD PTR -32[rbp], rdx
	mov	DWORD PTR -8[rbp], eax
    ```
    получили
    ```
	mov	r13d, edi					# записываем в регистр: n (int - 4 byte)
	mov	r14d, esi					# записываем в регистр: size (int - 4 byte)
	mov	r15, rdx					# записываем в регистр: str (char* - 8 byte)
	mov	r12d, eax					# записываем в регистр: i = 0 (int - 4 byte)
    ```

    Программа после рефакторинга находится в `main.s` и `find.s`

    Исходная ассемблерная программа находится в `stages/main.bare.s` и `stages/find.bare.s`

+ *Добавление комментариев в разработанную программу, поясняющих эквивалентное использование регистров вместо переменных исходной программы на C.*

    Полностью прокомментированная ассемблерная программа находится в `main.s` и `find.s`

    Пример комментария, описывающего эквивалентное использование регистров вместо переменных исходной программы на C:
    ```
	mov	r13d, edi					# записываем в регистр: n (int - 4 byte)
	mov	r14d, esi					# записываем в регистр: size (int - 4 byte)
	mov	r15, rdx					# записываем в регистр: str (char* - 8 byte)
	mov	r12d, eax					# записываем в регистр: i = 0 (int - 4 byte)
    ```

+ *Представление результатов тестовых прогонов для разработанной программы. Оценка корректности ее выполнения на основе сравнения тестовых прогонов результатами тестирования программы, разработанной на языке C.*

    Результат тестового прогона (diff ничего не вывел - всё хорошо):
    ```bash
    $ make test
    Test ASM
    Test 1
    Time delta: 57 ns

    Test 2
    Time delta: 92 ns

    Test 3
    Time delta: 160 ns

    Test 4
    Time delta: 403 ns

    Test 5
    Time delta: 432 ns

    Test 6
    Time delta: 365 ns

    Test C
    Test 1
    Time delta: 50 ns

    Test 2
    Time delta: 144 ns

    Test 3
    Time delta: 278 ns

    Test 4
    Time delta: 406 ns

    Test 5
    Time delta: 457 ns

    Test 6
    Time delta: 453 ns
    ```

+ *Сопоставление размеров программы на ассемблере, полученной после компиляции с языка C с модифицированной программой, использующей регистры.*

    Программа, полученная после компиляции с языка С занимает 374 строки и 6873 байта, а модифицированная программа - 299 строк и 19580 байт

+ *Добавление информации о проведенных изменениях в отчет.*

    Информация добавлена в отчёт

### 7 баллов

+ *Реализация программы на ассемблере в виде двух или более единиц компиляции (программу на языке C разделять допускается, но не обязательно)*

    Использованы две единицы компиляции:
    + `main.s`
    + `find.s`

+ *Использование файлов с исходными данными и файлов для вывода результатов. Имена файлов задаются с использованием аргументов командной строки. Командная строка проверяется на корректность числа аргументов и корректное открытие файлов.*

    Использованы аргументы командной строки для задания входного и выходного файлов:
    ```c
    input = fopen(argv[4], "r");
    output = fopen(argv[5], "w");
    ```

    Проверко командной строки на корректность числа аргументов:
    ```c
    if (argc < 4) {
        printf("Incorrect input\n");
        return 0;
    }
    ```

    Проверко командной строки на корректное открытие файлов:
    ```c
    if (argc < 5 || access(argv[4], F_OK) != 0) {
        printf("Incorrect input\n");
        return 0;
    }
    ```

    Во входном файле находится только читаемая строка

+ *Подготовка нескольких файлов, обеспечивающих тестовое покрытие разработанной программы.*

    Подготовлено 12 файлов с тестами, которые находятся в директории `tests/`. Результаты тестовых прогонов выше

+ *Добавление в отчет информации о проведенном функциональном расширении, формате входных файлов, формате командной строки и результатах работы с тестовыми файлами.*

    Информация добавлена в отчёт

### 8 баллов

+ *Использование в разрабатываемых программах генератора случайных наборов данных, расширяющих возможности тестирования.*

    Первый аргумент командной строки - `count` - количество повторов функции `find`

    Второй аргумент командной строки - `n` - длина исходной подпоследовательности

    Вариант ввода данных выбирается с помощью третьего аргумента командной строки:
    + `0` - ввод из указанного в четвёртом аргументе файла, вывод в указанный пятым аргументом файл
    + `1` - ввод с помощью генератора, количество символов в строке задаётся четвёртым аргументом, сгенерированныая строка выводится в `input`, найденная подпоследовательность выводится в `output`

    Ввод строки:
    ```c
    if (atoi(argv[3]) == 0) {
        if (argc < 5 || access(argv[4], F_OK) != 0) {
            printf("Incorrect input\n");
            return 0;
        }
        input = fopen(argv[4], "r");
        output = fopen(argv[5], "w");
        size = 0;
        do {
            if (size > max) {
                printf("Incorrect input\n");
                return 0;
            }
            ch = fgetc(input);
            str[size++] = ch;
        } while(ch != -1);
        size--;
        str[size] = '\0';
    } else {
        input = fopen("input", "w");
        output = fopen("output", "w");
        size = atoi(argv[4]);
        if (size > max) {
            printf("Incorrect input\n");
            return 0;
        }
        for(i = 0; i < size; i++) {
            str[i] = rand() % 128;
            fprintf(input, "%c", str[i]);
        }
    }
    ```

+ *Изменение формата командной строки с учетом выбора ввода из файлов или с использованием генератора.*

    Описано в предыдущем пункте

+ *Включение в программы функций, обеспечивающих замеры времени для проведения сравнения на производительность. Необходимо добавить замеры во времени, которые не учитывают время ввода и вывода данных. Для увеличения времени работы минимум до 1 секунды, в зависимости от особенностей программы, можно либо выбирать соответствующие размеры исходных данных, либо зацикливать для многократного выполнения ту часть программы, которая выполняет вычисления. В последнем случае можно использовать соответствующую опцию командной строки, задающей количество повторений.*

    Замер времени выполнения без ввода-вывода:
    ```c
    clock_gettime(CLOCK_MONOTONIC, &start);

    for(i = 0; i < count; i++) {
        result = find(n, size, str);
    }

    clock_gettime(CLOCK_MONOTONIC, &finish);

    time_delta = timeDelta(finish, start);
    printf("Time delta: %ld ns\n", time_delta);
    ```

    Вычисления программы выполняются `count` раз

    Результат тестового прогона со сравнением работы программы на C и ассемблерной программы
    ```
    $ make compare
    Test 1
    ~~~ASM-program~~~
    Time delta: 63767937 ns
    ~~~~C-program~~~~
    Time delta: 80189839 ns

    Test 2
    ~~~ASM-program~~~
    Time delta: 219170746 ns
    ~~~~C-program~~~~
    Time delta: 283150230 ns

    Test 3
    ~~~ASM-program~~~
    Time delta: 425214183 ns
    ~~~~C-program~~~~
    Time delta: 479503776 ns

    Test 4
    ~~~ASM-program~~~
    Time delta: 1872359215 ns
    ~~~~C-program~~~~
    Time delta: 1631125983 ns

    Test 5
    ~~~ASM-program~~~
    Time delta: 2162047890 ns
    ~~~~C-program~~~~
    Time delta: 2341752955 ns

    Test 6
    ~~~ASM-program~~~
    Time delta: 1631133206 ns
    ~~~~C-program~~~~
    Time delta: 1824037521 ns
    ```
    Видим, что ассемблерная программа работает быстрее на больших входных данных (строка от 1000 символов)

+ *Представить полученные временные данные в отчете для разных вариантов тестовых прогонов (наряду с другими данными, полученные при выполнении ранее описанных требований).*

    Информация добавлена в отчёт


### 9 баллов

+ *Используя опции оптимизации по скорости, сформировать из модифицированной программы на C исходный код ассемблере. Провести сравнительный анализ с предыдущими ассемблерными программами по размеру ассемблерного кода, размеру исполняемого файла и производительности. Сопоставить эти программы с собственной программой, разработанной на ассемблере, в которой вместо переменных максимально возможно используются регистры.*

    Для оптимизации по скорости использовались флаги `-O0` `-O1` `-O2` `-O3` `-Ofast`, также для сравнения представлены программа, скомпилированная без флагов оптимизации и опитимизированная мной программа (последняя версия с комментариями)

    Скрипт для формирования программ с использованием опций оптимизации находится в `scripts/optimize.sh`

    Результат сравнительного анализа:
    ```bash
    $ make compare.opt
    ~~~Test non-optimization~~~
    Number of lines: 405
    Size in bytes: 6907
    Time delta: 2148129146 ns

    ~~~Test o0-optimization~~~
    Number of lines: 405
    Size in bytes: 6907
    Time delta: 2333783713 ns

    ~~~Test o1-optimization~~~
    Number of lines: 282
    Size in bytes: 4573
    Time delta: 1029008647 ns

    ~~~Test o2-optimization~~~
    Number of lines: 294
    Size in bytes: 4850
    Time delta: 796954874 ns

    ~~~Test o3-optimization~~~
    Number of lines: 298
    Size in bytes: 4923
    Time delta: 820721860 ns

    ~~~Test ofast-optimization~~~
    Number of lines: 298
    Size in bytes: 4923
    Time delta: 766802415 ns

    ~~~Test os-optimization~~~
    Number of lines: 247
    Size in bytes: 4008
    Time delta: 694209607 ns

    ~~~Test my-optimization~~~
    Number of lines: 299
    Size in bytes: 19580
    Time delta: 1575283742 ns
    ```

    Вывод: моя программа работает быстрее, чем программы без оптимизации и с флагом `-00`

+ *Аналогично, используя опции оптимизации по размеру, сформировать код на ассемблере. Провести сравнительный анализ с неоптимизированной программой по размеру ассемблерного кода, размеру исполняемого файла и производительности. Сопоставить эти программы с собственной программой, разработанной на ассемблере, в которой вместо переменных максимально возможно используются регистры.*

    Для оптимизации по размеру использовалась опция `-0s`, полный отчёт представлен в предыдущем пункте

    Вывод: моя программа уступает всем по размеру файла, но короче по количеству строк программы без оптимизации и с флагом `-00`

+ *Представить в отчете полученные результаты, дополнив данные, представленные в предыдущем по предыдующим требованиям.*

    Результаты представлены в отчёте

## Дерево проекта

```bash
.
├── asm.exe                             # последняя скомпилированная версия ассемблерной программы
├── c.exe                               # последняя скомпилированная версия программы на С
├── find.c                              # вспомогательная единица компиляции программы на С
├── find.s                              # вспомогательная единица компиляции программы на ассемблере
├── input                               # файл с входными данными
├── main.c                              # главная единица компиляции программы на С
├── main.s                              # главная единица компиляции программы на ассемблере
├── Makefile                            # команды для работы с программой
├── optimization                        # директория с файлами для анализа опций оптимизации
│   ├── find_my.s
│   ├── find_non.s
│   ├── find_o0.s
│   ├── find_o1.s
│   ├── find_o2.s
│   ├── find_o3.s
│   ├── find_ofast.s
│   ├── find_os.s
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
│   ├── find.bare.s
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
    make rand.asm n=100 size=1000
    ```
+ программы на С:
    ```
    make rand.c n=100 size=1000
    ```  

Получение программ с помощью разных опций оптимизации (в директории `optimization/`):
```
make optimize
```

Сравнение программ с различными опциями оптимизации (работает долго, потому что прогоняется на больших тестах):
```
make compare.opt
```
