#!/bin/bash

max=6
for i in `seq 1 $max`
do
    echo "Test $i"
    ./c.exe 1 0 tests/test$i.in output
    diff output tests/test$i.out
    echo
done
