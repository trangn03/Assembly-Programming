//****************************************************************************************************************************
//Program name: " ".  This program takes . Copyright (C) 2023 Trang Ngo.                                                                             *
//                                                                                                                           *
//This file is part of the software program " ".                                                                   *
//This is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License   *
//version 3 as published by the Free Software Foundation.                                                                    *
//This is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied          *
//warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
//A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.                            *
//****************************************************************************************************************************

//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
//
//Author information
//  Author name: Trang Ngo
//  Author email: trangn0102@csu.fullerton.edu
//
//Program information
//  Program name: 
//  Programming languages:  modules in C++ and  module in X86
//  Date program began: 2023 March 20
//  Date of last update: 2023 March 22
//  Files in this program: driver.cpp, filename.asm
//  Status: Finished.
//
//Purpose
//  
//
//This file
//   File name: driver.cpp
//   Language: C++
//   Max page width: 132 columns
//   Compile: 
//   Link: 
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

extern "C" double filename();

int main(int argc, char* argv[])
{
  double p = 0.0;
  p = filename();
  printf("Bla bla %1.5lf.\n", p);
  return 0;
}