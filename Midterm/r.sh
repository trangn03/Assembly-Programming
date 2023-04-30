#!/bin/bash

# Author name: Trang Ngo
# Author email: trangn0102@csu.fullerton.edu
# Course and section: CPSC240-13
# Today's date: Mar 22, 2023

#Clear any previously compiled outputs
rm *.lis
rm *.o
rm *.out

echo "Assemble faraday.asm"
nasm -f elf64 -l faraday.lis -o faraday.o faraday.asm

echo "Compile ampere.c using the g++ compiler standard 2017"
gcc -c -Wall -no-pie -m64 -std=c17 -o ampere.o ampere.c

echo "Link object files using the gcc Linker standard 2017"
gcc -m64 -no-pie -o final.out faraday.o ampere.o -std=c17

echo "[===== Run the program =====]"
./final.out

# For cleaner working directory, you can:
rm *.lis
rm *.o
rm *.out

echo "[===== Program finished =====]"