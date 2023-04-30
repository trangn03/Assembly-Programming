#!/bin/bash

#Program: Benchmark
#Author: Trang Ngo
#Section: CPSC240-13

#Clear any previously compiled outputs
rm *.lis
rm *.o
rm *.out

echo "Assemble manager.asm"
nasm -f elf64 -l manager.lis -o manager.o manager.asm

echo "Assemble get_clock_freq.asm"
nasm -f elf64 -l get_clock_freq.lis -o get_clock_freq.o get_clock_freq.asm

echo "Assemble getfreq.asm"
nasm -f elf64 -l getfreq.lis -o getfreq.o getfreq.asm

echo "Assemble getradicand.asm"
nasm -f elf64 -l getradicand.lis -o getradicand.o getradicand.asm

echo "Compile main.c using the gcc compiler standard 2017"
gcc -c -Wall -m64 -no-pie -o main.o main.c -std=c17

echo "Link object files using the gcc Linker standard 2017"
gcc -m64 -no-pie -o final.out manager.o get_clock_freq.o getfreq.o getradicand.o main.o -std=c17

echo "[===== Run the Benchmark program =====]"
./final.out

# For cleaner working directory, you can:
rm *.lis
rm *.o
rm *.out

echo "[===== Program finished =====]"
