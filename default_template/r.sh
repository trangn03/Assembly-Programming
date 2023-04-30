#!/bin/bash

#Program: 
#Author:

#Clear any previously compiled outputs
rm *.lis
rm *.o
rm *.out

echo "Assemble filename.asm"
nasm -f elf64 -l filename.lis -o filename.o filename.asm

echo "Compile driver.cpp using the g++ compiler standard 2017"
g++ -c -Wall -no-pie -m64 -std=c++17 -o driver.o driver.cpp

echo "Link object files using the gcc Linker standard 2017"
g++ -m64 -no-pie -o final-filename.out filename.o driver.o -std=c++17

echo "Run the Filename Program:"
./final-filename.out

# For cleaner working directory, you can:
rm *.lis
rm *.o
rm *.out

echo "Script file terminated."