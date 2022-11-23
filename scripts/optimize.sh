#!/bin/bash


gcc main.c -S -lm -o optimization/main_non.s
gcc calc.c -S -lm  -o optimization/calc_non.s
gcc ./optimization/main_non.s ./optimization/calc_non.s -lm -o ./optimization/non.exe

gcc -O0 main.c -S -lm -o optimization/main_o0.s
gcc -O0 calc.c -S -lm -o optimization/calc_o0.s
gcc ./optimization/main_o0.s ./optimization/calc_o0.s -lm -o ./optimization/o0.exe

gcc -O1 main.c -S -lm -o optimization/main_o1.s
gcc -O1 calc.c -S -lm -o optimization/calc_o1.s
gcc ./optimization/main_o1.s ./optimization/calc_o1.s -lm -o ./optimization/o1.exe

gcc -O2 main.c -S -lm -o optimization/main_o2.s
gcc -O2 calc.c -S -lm -o optimization/calc_o2.s
gcc ./optimization/main_o2.s ./optimization/calc_o2.s -lm -o ./optimization/o2.exe

gcc -O3 main.c -S -lm -o optimization/main_o3.s
gcc -O3 calc.c -S -lm -o optimization/calc_o3.s
gcc ./optimization/main_o3.s ./optimization/calc_o3.s -lm -o ./optimization/o3.exe

gcc -Ofast main.c -S -lm -o optimization/main_ofast.s
gcc -Ofast calc.c -S -lm -o optimization/calc_ofast.s
gcc ./optimization/main_ofast.s ./optimization/calc_ofast.s -lm -o ./optimization/ofast.exe

gcc -Os main.c -S -lm -o optimization/main_os.s
gcc -Os calc.c -S -lm -o optimization/calc_os.s
gcc ./optimization/main_os.s ./optimization/calc_os.s -lm -o ./optimization/os.exe

gcc ./optimization/main_my.s ./optimization/calc_my.s -lm -o ./optimization/my.exe