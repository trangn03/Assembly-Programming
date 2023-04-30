//****************************************************************************************************************************
//Program name: "Hypotenuse".  This program takes in the user input of the length of the two sides of the right triangle 
//and calculates the hypotenuse. Copyright (C) 2023 Trang Ngo.                                                                             *
//                                                                                                                           *
//This file is part of the software program "Hypotenuse".                                                                   *
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
//  Section: CPSC240-13
//
//Program information
//  Program name: Trang Ngo
//  Programming languages: One modules in C++ and one module in X86
//  Date program began: 2023 Jan 25
//  Date of last update: 2023 Feb 04
//  Files in this program: driver.cpp, pythagoras.asm
//  Status: Finished.
//
//References for this program
//  Jorgensen, X86-64 Assembly Language Programming with Ubuntu
//
//Purpose
//  Calculate the hypotenuse based on user input
//
//This file
//   File name: driver.cpp
//   Language: C++
//   Max page width: 132 columns
//   Compile: g++ -c -Wall -no-pie -m64 -std=c++17 -o driver.o driver.cpp
//   Link: g++ -m64 -no-pie -o final-pythagoras.out pythagoras.o driver.o -std=c++17
//   Optimal print specification: 132 columns width, 7 points, monospace, 8½x11 paper
//
//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
//
//
//===== Begin code area ===========================================================================================================#include <stdio.h>

#include <stdint.h>
#include <time.h>
#include <sys/time.h>
#include <stdlib.h>
#include <ios>
#include <iostream>

extern "C" double pythagoras();

int main (int argc, char* argv[]) 
{
	printf("Welcome to Pythagoras' Math Lab programmed by Trang Ngo.\n");
	printf("Please contact me at trangn0102@csu.fullerton.edu if you need assistance.\n");
	
	double length = 0.0;
	length = pythagoras();
	
	printf("The main file recieved this number: %1.12lf, and will keep it for now.\n", length);
	printf("We hoped you enjoyed your right angles. Have a good day. A zero will be sent to your operating system.\n");
	return 0;
}