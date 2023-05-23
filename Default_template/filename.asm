;****************************************************************************************************************************
;Program name: " ".  This program . Copyright (C) 2023 Trang Ngo.                                                                           *
;                                                                                                                           *
;This file is part of the software program " ".                                                                   *
;Rectangle is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License   *
;version 3 as published by the Free Software Foundation.                                                                    *
;Rectangle is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied          *
;warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
;A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.                            *
;****************************************************************************************************************************




;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;
;Author information
;  Author name: Trang Ngo
;  Author email: trangn0102@csu.fullerton.edu
;
;Program information
;  Program name: 
;  Programming languages: One modules in C++ and one module in X86
;  Date program began: 2023 March 
;  Date of last update: 2023 March 
;
;  Files in this program: driver.cpp, filename.asm
;  Status: Finished.
;
;References for this program
;  Jorgensen, X86-64 Assembly Language Programming with Ubuntu
; 
;Purpose
;  
;
;This file
;   File name: filename.asm
;   Language: X86 with Intel syntax.
;   Max page width: 132 columns
;   Assemble: nasm -f elf64 -l .lis -o .o .asm

;===== Begin code area ================================================================================================

extern printf
extern scanf
global filename ; RENAME THIS TO THE NAME OF YOUR MODULE/FUNCTION THAT YOU ARE WRITING

segment .data
welcome db "Welcome to a friendly assembly program by ",10,0
welcome2 db "This program will compute the perimeter and the average side length of a rectangle.", 10, 0

one_float_format db "%lf",0
three_float_format db "%lf %lf %lf", 0

segment .bss

segment .text

filename: ; RENAME THIS TO THE NAME OF YOUR MODULE/FUNCTION THAT YOU ARE WRITING

;Prolog ===== Insurance for any caller of this assembly module ========================================================
;Any future program calling this module that the data in the caller's GPRs will not be modified.
push rbp
mov  rbp,rsp
push rdi                                                    ;Backup rdi
push rsi                                                    ;Backup rsi
push rdx                                                    ;Backup rdx
push rcx                                                    ;Backup rcx
push r8                                                     ;Backup r8
push r9                                                     ;Backup r9
push r10                                                    ;Backup r10
push r11                                                    ;Backup r11
push r12                                                    ;Backup r12
push r13                                                    ;Backup r13
push r14                                                    ;Backup r14
push r15                                                    ;Backup r15
push rbx                                                    ;Backup rbx
pushf                                                       ;Backup rflags

push qword 0

; WRITE YOUR CODE HERE!!!!!

pop rax

;===== Restore original values to integer registers ===================================================================
popf                                                        ;Restore rflags
pop rbx                                                     ;Restore rbx
pop r15                                                     ;Restore r15
pop r14                                                     ;Restore r14
pop r13                                                     ;Restore r13
pop r12                                                     ;Restore r12
pop r11                                                     ;Restore r11
pop r10                                                     ;Restore r10
pop r9                                                      ;Restore r9
pop r8                                                      ;Restore r8
pop rcx                                                     ;Restore rcx
pop rdx                                                     ;Restore rdx
pop rsi                                                     ;Restore rsi
pop rdi                                                     ;Restore rdi
pop rbp                                                     ;Restore rbp

ret