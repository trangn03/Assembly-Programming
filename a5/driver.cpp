//****************************************************************************************************************************
//Program name: "Data Validation". This program will ask the user to enter a number and then perform comparision of two
// version of the sine function which is from Taylor series and in math C library. The program also make a check if the 
// number entered by user valid or not. 
// Copyright (C) 2023 Trang Ngo.                                                                            *
//                                                                                                                           *
//This file is part of the software program "Data Validation".                                                                   *
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
//  Program name: Data Validation
//  Programming languages: One module in C and three modules in X86
//  Date program began: 2023 April 17
//  Date of last update: 2023 April 29
//  Files in this program: main.c, manager.asm, r.sh
//  Status: Finished.
//
//References for this program
//  Jorgensen, X86-64 Assembly Language Programming with Ubuntu
//  Johnson Tong SI of CPSC-240
//  Professor Holliday's lecture
//
//Purpose
//  
// This program will ask the user to enter a number and then perform comparision of two
// version of the sine function which is from Taylor series and in math C library. The program also make a check if the 
// number entered by user valid or not. 
//
//This file
//  File name: driver.cpp
//  Language: C++
//  Max page width: 132 columns
//  Compile: g++ -c -Wall -m64 -no-pie -o driver.o driver.c -std=c17
//  Link: g++ -m64 -no-pie -o final.out manager.o isfloat.o driver.o -std=c17
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
#include <math.h>

extern "C" double manager ();

int main (int argc, char* argv[])
{
    printf ("\nWelcome to Asterix Software Development Corporation\n");

	double data = manager();

    printf("\nThank you for using this program. Have a great day\n");
	printf("\nThe driver program received this number %.12lf. A zero will be returned to the OS. Bye.\n", data);
    
	return 0;
}
