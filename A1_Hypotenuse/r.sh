#!/bin/bash

#Program: Hypotenuse
#Author: Trang Ngo
#Section: CPSC240-13

#Clear any previously compiled outputs
rm *.lis
rm *.o
rm *.out

echo "Assemble pythagoras.asm"
nasm -f elf64 -l pythagoras.lis -o pythagoras.o pythagoras.asm

echo "Compile driver.cpp using the g++ compiler standard 2017"
g++ -c -Wall -no-pie -m64 -std=c++17 -o driver.o driver.cpp

echo "Link object files using the gcc Linker standard 2017"
g++ -m64 -no-pie -o final-pythagoras.out pythagoras.o driver.o -std=c++17

echo "[===== Run the Pythagoras program =====]"
./final-pythagoras.out

# For cleaner working directory, you can:
rm *.lis
rm *.o
rm *.out

echo "[===== Program finished =====]"
