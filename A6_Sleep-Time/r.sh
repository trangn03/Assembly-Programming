#!/bin/bash

#Program: Sleep Time
#Author: Trang Ngo
#Section: CPSC240-13

#Clear any previously compiled outputs
rm *.lis
rm *.o
rm *.out

echo "Assemble birthday.asm"
nasm -f elf64 -l birthday.lis -o birthday.o birthday.asm

echo "Compile main.c using the gcc compiler standard 2017"
gcc -c -Wall -m64 -no-pie -o main.o main.c -std=c17

echo "Link object files using the gcc Linker standard 2017"
gcc -m64 -no-pie -o final.out birthday.o main.o -std=c17

echo "[===== Run the Sleep Time program =====]"
./final.out

# For cleaner working directory, you can:
rm *.lis
rm *.o
rm *.out

echo "[===== Program finished =====]"
