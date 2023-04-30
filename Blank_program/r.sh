#!/bin/bash

#Program: Blank
#Author : Trang Ngo

#Clear any previously compiled outputs
rm *.lis
rm *.o
rm *.out

echo "Assemble manager.asm"
nasm -f elf64 -l manager.lis -o manager.o manager.asm

echo "Compile main.c using the g++ compiler standard 2017"
gcc -c -Wall -no-pie -m64 -std=c17 -o main.o main.c

echo "Link object files using the gcc Linker standard 2017"
gcc -m64 -no-pie -o final.out manager.o main.o -std=c17

echo "[===== Run the program =====]"
./final.out

# For cleaner working directory, you can:
rm *.lis
rm *.o
rm *.out

echo "[===== Program finished =====]"