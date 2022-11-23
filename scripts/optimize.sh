#!/bin/bash


gcc main.c -S -o optimization/main_non.s
gcc find.c -S -o optimization/find_non.s
gcc ./optimization/main_non.s ./optimization/find_non.s -o ./optimization/non.exe

gcc -O0 main.c -S -o optimization/main_o0.s
gcc -O0 find.c -S -o optimization/find_o0.s
gcc ./optimization/main_o0.s ./optimization/find_o0.s -o ./optimization/o0.exe

gcc -O1 main.c -S -o optimization/main_o1.s
gcc -O1 find.c -S -o optimization/find_o1.s
gcc ./optimization/main_o1.s ./optimization/find_o1.s -o ./optimization/o1.exe

gcc -O2 main.c -S -o optimization/main_o2.s
gcc -O2 find.c -S -o optimization/find_o2.s
gcc ./optimization/main_o2.s ./optimization/find_o2.s -o ./optimization/o2.exe

gcc -O3 main.c -S -o optimization/main_o3.s
gcc -O3 find.c -S -o optimization/find_o3.s
gcc ./optimization/main_o3.s ./optimization/find_o3.s -o ./optimization/o3.exe

gcc -Ofast main.c -S -o optimization/main_ofast.s
gcc -Ofast find.c -S -o optimization/find_ofast.s
gcc ./optimization/main_ofast.s ./optimization/find_ofast.s -o ./optimization/ofast.exe

gcc -Os main.c -S -o optimization/main_os.s
gcc -Os find.c -S -o optimization/find_os.s
gcc ./optimization/main_os.s ./optimization/find_os.s -o ./optimization/os.exe