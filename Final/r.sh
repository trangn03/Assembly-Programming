#!/bin/bash

# Author name: Trang Ngo
# Author email: trangn0102@csu.fullerton.edu
# Course and section: CPSC240-13 Final
# Today's date: May 15, 2023

#Clear any previously compiled outputs
rm *.lis
rm *.o
rm *.out

echo "Assemble controller.asm"
nasm -f elf64 -l controller.lis -o controller.o controller.asm

echo "Assemble getfrequency.asm"
nasm -f elf64 -l getfrequency.lis -o getfrequency.o getfrequency.asm

echo "Compile main.c using the gcc compiler standard 2017"
g++ -c -Wall -m64 -no-pie -o driver.o driver.cpp -std=c++17

echo "Link object files using the gcc Linker standard 2017"
g++ -m64 -no-pie -o final.out controller.o getfrequency.o driver.o -std=c++17

echo "[===== Run the program =====]"
./final.out

# For cleaner working directory, you can:
rm *.lis
rm *.o
rm *.out

echo "[===== Program finished =====]"