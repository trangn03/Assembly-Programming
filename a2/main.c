//****************************************************************************************************************************
//Program name: "Arrays". This program takes in the user input of two array and calculate their magnitude. Copyright (C) 2023 Trang Ngo.                                                                             *
//                                                                                                                           *
//This file is part of the software program "Arrays".                                                                   *
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
//  Program name: Trang Ngo
//  Programming languages: Two modules in C and four modules in X86
//  Date program began: 2023 Feb 07
//  Date of last update: 2023 Feb 18
//  Files in this program: main.c, display_array.c, input_array.asm, manager.asm, magnitude.asm, append.asm, r.sh
//  Status: Finished.
//
//References for this program
//  Jorgensen, X86-64 Assembly Language Programming with Ubuntu
//
//Purpose
//  Calculate magnitude of two arrays based on user input
//
//This file
//   File name: main.c
//   Language: C
//   Max page width: 132 columns
//   Compile: gcc -c -Wall -m64 -no-pie -o main.o main.c -std=c17
//   Link: gcc -m64 -no-pie -o Arrays.out manager.o magnitude.o append.o input_array.o main.o display_array.o -std=c17
//   Optimal print specification: 132 columns width, 7 points, monospace, 8½x11 paper
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
	printf("Welcome to Arrays of Integers\n");
	printf("Bought to you by Trang Ngo\n");

	double array = manager();

	printf("Main file recieved %.10lf., and will keep it for future use\n", array);
	printf("Main will return 0 to the operating system. Bye\n");
	return 0;
}
