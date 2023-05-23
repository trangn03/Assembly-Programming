#!/bin/bash

#Program: Arrays
#Author: Trang Ngo
#Section: CPSC240-13

#Clear any previously compiled outputs
rm *.lis
rm *.o
rm *.out

echo "Assemble manager.asm"
nasm -f elf64 -l manager.lis -o manager.o manager.asm

echo "Assemble magnitude.asm"
nasm -f elf64 -l magnitude.lis -o magnitude.o magnitude.asm

echo "Assemble append.asm"
nasm -f elf64 -l append.lis -o append.o append.asm

echo "Assemble input_array.asm"
nasm -f elf64 -l input_array.lis -o input_array.o input_array.asm

echo "Compile main.c using the gcc compiler standard 2017"
gcc -c -Wall -m64 -no-pie -o main.o main.c -std=c17

echo "Compile display_array.c using the gcc compiler standard 2017"
gcc -c -Wall -m64 -no-pie -o display_array.o display_array.c -std=c17

echo "Link object files using the gcc Linker standard 2017"
gcc -m64 -no-pie -o Arrays.out manager.o magnitude.o append.o input_array.o main.o display_array.o -std=c17

echo "[===== Run the Arrays program =====]"
./Arrays.out

# For cleaner working directory, you can:
rm *.lis
rm *.o
rm *.out

echo "[===== Program finished =====]"
