//****************************************************************************************************************************
//Program name: "Benchmark". This program benchmarks the performance of the square root instruction in SSE 
// and also the square root program in the standard C library. 
// Copyright (C) 2023 Trang Ngo.                                                                             *
//                                                                                                                           *
//This file is part of the software program "Benchmark".                                                                   *
//This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License   *
//version 3 as published by the Free Software Foundation.                                                                    *
//This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied          *
//warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
//A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.                            *
//****************************************************************************************************************************

//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
//
//Author information
//  Author name: Trang Ngo
//  Author email: trangn0102@csu.fullerton.edu
//	Section: CPSC240-13
//
//Program information
//  Program name: Benchmark
//  Programming languages: One module in C and three modules in X86
//  Date program began: 2023 April 2
//  Date of last update: 2023 April 14
//  Files in this program: main.c, manager.asm, getradicand.asm, get_clock_freq.asm, r.sh
//  Status: Finished.
//
//References for this program
//  Jorgensen, X86-64 Assembly Language Programming with Ubuntu
//  Johnson Tong SI of CPSC-240
//  Professor Holliday's lecture
//
//Purpose
//  Benchmarks the performance of the square root instruction in SSE 
//  and also the square root program in the standard C library. 
//
//This file
//  File name: main.c
//  Language: C
//  Max page width: 132 columns
//  Compile: gcc -c -Wall -m64 -no-pie -o main.o main.c -std=c17
//  Link: gcc -m64 -no-pie -o final.out manager.o get_clock_freq.o getradicand.o main.o -std=c17
//  Optimal print specification: 132 columns width, 7 points, monospace, 8½x11 paper
//
//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
//
//
//===== Begin code area ===========================================================================================================

#include <stdio.h>
#include <stdint.h>
#include <time.h>
#include <sys/time.h>
#include <stdlib.h>

extern double manager ();

int main (int argc, char* argv[])
{

	double benchmark = manager();

	printf("\nThe main function has recieve this number %.5lf and will keep it for future reference\n", benchmark);
	printf("\nThe main function will return a zero to the operating system\n");
    
	return 0;
}
