;****************************************************************************************************************************
;Program name: "Benchmark". This program This program benchmarks the performance of the square root instruction in SSE 
; and also the square root program in the standard C library. 
; Copyright (C) 2023 Trang Ngo.                                                                           *
;                                                                                                                           *
;This file is part of the software program "Benchmark".                                                                   *
;This is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License   *
;version 3 as published by the Free Software Foundation.                                                                    *
;This is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied          *
;warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
;A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.                            *
;****************************************************************************************************************************




;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;
;Author information
;  Author name: Trang Ngo
;  Author email: trangn0102@csu.fullerton.edu
;  Section: CPSC240-13
;
;Program information
;  Program name: Benchmark
;  Programming languages: One module in C and three modules in X86
;  Date program began: 2023 April 2
;  Date of last update: 2023 April 14
;
;  Files in this program: main.c, manager.asm, getradicand.asm, get_clock_freq.asm, r.sh
;  Status: Finished.
;
;References for this program
;  Jorgensen, X86-64 Assembly Language Programming with Ubuntu
;  Johnson Tong SI of CPSC-240
;  Professor Holliday's lecture
;
;Purpose
;  Benchmarks the performance of the square root instruction in SSE 
;  and also the square root program in the standard C library. 
;
;This file
;  File name: getradicand.asm
;  Language: X86 with Intel syntax.
;  Max page width: 132 columns
;  Assemble: nasm -f elf64 -l getradicand.lis -o getradicand.o getradicand.asm

;===== Begin code area ================================================================================================

extern printf
extern scanf

global getradicand ; Name of the function

segment .data

enter_float_radicand db 10,"Please enter a floating radicand for square root bench marking: ", 0

one_float_format db "%lf", 0

segment .bss

segment .text

getradicand: ; Name of the function

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

;=========Enter floating radicand===================
push qword 0
mov rax, 0
mov rdi, enter_float_radicand ; "Please enter a floating radicand for square root bench marking: "
call printf
pop rax

push qword 0
mov rax, 1 ; 1 xmm register will be use to display float value
mov rdi, one_float_format
mov rsi, rsp
call scanf
movsd xmm12, [rsp] ; Store the float enterd by user to xmm12
pop rax

pop rax

movsd xmm0, xmm12

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
