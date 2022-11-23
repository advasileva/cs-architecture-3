#!/bin/bash

declare -a arr=("non" "o0" "o1" "o2" "o3" "ofast" "os" "my")
count=10000000
for i in "${arr[@]}"
do
    echo "~~~Test $i-optimization~~~"
    main_lines=$(wc -l < optimization/main_$i.s)
    calc_lines=$(wc -l < optimization/calc_$i.s)
    sum_lines=$(expr $main_lines + $calc_lines)
    echo "Number of lines: $sum_lines"
    main_size=$(stat --printf="%s\n" optimization/main_$i.s)
    calc_size=$(stat --printf="%s\n" optimization/calc_$i.s)
    sum_size=$(expr $main_size + $calc_size)
    echo "Size in bytes: $sum_size"
    ./optimization/$i.exe $count 0 tests/test6.in output
    echo
done
