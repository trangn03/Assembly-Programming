//****************************************************************************************************************************
//Program name: "Sleep Time". This program will output a happy birthday message for chris 
// for a user specified amount of times 
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
//  Program name: Sleep Time
//  Programming languages: One module in C and one module in X86
//  Date program began: 2023 May 4
//  Date of last update: 2023 May 15
//  Files in this program: main.c, birthday.asm, r.sh
//  Status: Unfinished
//
//References for this program
//  Jorgensen, X86-64 Assembly Language Programming with Ubuntu
//  Johnson Tong SI of CPSC-240
//  Professor Holliday's lecture
//
//Purpose
//  This program will output a happy birthday message for chris 
//  for a user specified amount of times
//
//This file
//  File name: main.c
//  Language: C
//  Max page width: 132 columns
//  Compile: gcc -c -Wall -m64 -no-pie -o main.o main.c -std=c17
//  Link: gcc -m64 -no-pie -o final.out birthday.o main.o -std=c17
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

extern long long unsigned int birthday();

int main (int argc, char* argv[])
{

    printf("Welcome to Daylight Sleeping Time brought to you by Trang Ngo\n");

    long long unsigned int number = birthday();

    printf("\nThe main received this number %llu and will keep it.\n", number);
    printf("\nA zero will be sent to the Operating System.  Bye.\n");
	
    return 0;
}
