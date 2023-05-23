//****************************************************************************************************************************
//Program name: "Non-deterministic Random Numbers". This program takes user input of their name and title, 
// then ask how many numbers they want in an array, which can generate up to 100 random numbers,
// after that, the array will be sorted and normalize within the interval 1.0<=num<=2.0. The array also 
// prints in both IEEE725 and scientific decimal format. Copyright (C) 2023 Trang Ngo.                                                                             *
//                                                                                                                           *
//This file is part of the software program "Non-deterministic Random Numbers".                                                                   *
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
//  Programming languages: Two modules in C and four modules in X86
//  Date program began: 2023 Feb 26
//  Date of last update: 2023 March 10
//  Files in this program: main.c, quick_sort.c, executive.asm, fill_random_array.asm, isnan.asm, show_array.asm, r.sh
//  Status: Finished.
//
//References for this program
//  Jorgensen, X86-64 Assembly Language Programming with Ubuntu
//  Johnson Tong SI of CPSC-240
//  Professor Holliday's lecture
//
//Purpose
//  This program takes user input of their name and title, 
//  then ask how many numbers they want in an array, which can generate up to 100 random numbers,
//  after that, the array will be sorted and normalize within the interval 1.0<=num<=2.0. The array also 
//  prints in both IEEE725 and scientific decimal format
//
//This file
//  File name: quick_sort.c
//  Language: C
//  Max page width: 132 columns
//  Compile: gcc -c -Wall -m64 -no-pie -o quick_sort.o quick_sort.c -std=c17
//  Link: gcc -m64 -no-pie -o Numbers.out executive.o fill_random_array.o isnan.o show_array.o main.o quick_sort.o -std=c17
//  Optimal print specification: 132 columns width, 7 points, monospace, 8½x11 paper
//
//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
//
//
//===== Begin code area ===========================================================================================================
#include <stdbool.h>

extern int quick_sort(const void *a, const void *b);

// quick_sort is the pointer to a function that compares two elements
int quick_sort(const void * a, const void * b) {
    if (*(double*)a > *(double*)b)
        return 1;

    if (*(double*)a < *(double*)b)
        return -1;

    return 0;
}
