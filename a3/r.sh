#!/bin/bash

#Program: Non-deterministic Random Numbers
#Author: Trang Ngo
#Section: CPSC240-13

#Clear any previously compiled outputs
rm *.lis
rm *.o
rm *.out

echo "Assemble executive.asm"
nasm -f elf64 -l executive.lis -o executive.o executive.asm

echo "Assemble fill_random_array.asm"
nasm -f elf64 -l fill_random_array.lis -o fill_random_array.o fill_random_array.asm

echo "Assemble isnan.asm"
nasm -f elf64 -l isnan.lis -o isnan.o isnan.asm

echo "Assemble show_array.asm"
nasm -f elf64 -l show_array.lis -o show_array.o show_array.asm

echo "Compile main.c using the gcc compiler standard 2017"
gcc -c -Wall -m64 -no-pie -o main.o main.c -std=c17

echo "Compile quick_sort.c using the gcc compiler standard 2017"
gcc -c -Wall -m64 -no-pie -o quick_sort.o quick_sort.c -std=c17

echo "Link object files using the gcc Linker standard 2017"
gcc -m64 -no-pie -o Numbers.out executive.o fill_random_array.o isnan.o show_array.o main.o quick_sort.o -std=c17

echo "[===== Run the Non-deterministic Random Numbers program =====]"
./Numbers.out

# For cleaner working directory, you can:
rm *.lis
rm *.o
rm *.out

echo "[===== Program finished =====]"
