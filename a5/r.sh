#!/bin/bash

#Program: Data Validation
#Author: Trang Ngo
#Section: CPSC240-13

#Clear any previously compiled outputs
rm *.lis
rm *.o
rm *.out

echo "Assemble manager.asm"
nasm -f elf64 -l manager.lis -o manager.o manager.asm

echo "Assemble isfloat.asm"
nasm -f elf64 -l isfloat.lis -o isfloat.o isfloat.asm

echo "Compile main.c using the gcc compiler standard 2017"
g++ -c -Wall -m64 -no-pie -o driver.o driver.cpp -std=c++17

echo "Link object files using the gcc Linker standard 2017"
g++ -m64 -no-pie -o final.out manager.o isfloat.o driver.o -std=c++17

echo "[===== Run the Benchmark program =====]"
./final.out

# For cleaner working directory, you can:
rm *.lis
rm *.o
rm *.out

echo "[===== Program finished =====]"
