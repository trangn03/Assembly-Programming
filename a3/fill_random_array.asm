;****************************************************************************************************************************
;Program name: "Non-deterministic Random Numbers". This program takes user input of their name and title, 
; then ask how many numbers they want in an array, which can generate up to 100 random numbers,
; after that, the array will be sorted and normalize within the interval 1.0<=num<=2.0. The array also 
; prints in both IEEE725 and scientific decimal format. Copyright (C) 2023 Trang Ngo.                                                                           *
;                                                                                                                           *
;This file is part of the software program "Non-deterministic Random Numbers".                                                                   *
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
;  Program name: Non-deterministic Random Numbers
;  Programming languages: Two modules in C and four modules in X86
;  Date program began: 2023 Feb 26
;  Date of last update: 2023 March 10
;
;  Files in this program: main.c, quick_sort.c, executive.asm, fill_random_array.asm, isnan.asm, show_array.asm, r.sh
;  Status: Finished.
;
;References for this program
;  Jorgensen, X86-64 Assembly Language Programming with Ubuntu
;  Johnson Tong SI of CPSC-240
;  Professor Holliday's lecture
;
;Purpose
;  This program takes user input of their name and title, 
;  then ask how many numbers they want in an array, which can generate up to 100 random numbers,
;  after that, the array will be sorted and normalize within the interval 1.0<=num<=2.0. The array also 
;  prints in both IEEE725 and scientific decimal format
;
;This file
;  File name: fill_random_array.asm
;  Language: X86 with Intel syntax.
;  Max page width: 132 columns
;  Assemble: nasm -f elf64 -l fill_random_array.lis -o fill_random_array.o fill_random_array.asm

;===== Begin code area ================================================================================================
extern isnan

global fill_random_array ; Name of the function

segment .data

segment .bss

; array resq 100

segment .text

fill_random_array: ; Name of the function

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

mov r13, rdi ; r13 is the array
mov r14, rsi ; r14 is how many numbers in the array

mov r15, 0 ; r15 is the index, start at 0
begin_loop:
	cmp r15, r14 ; If r15 is less than r14
	jge end_loop
	rdrand rbx ; Generate random 64-bit number
	mov rdi, rbx ; Create a copy of the qword into rdi
	call isnan ; Call isnan function to check if qword generated is a nan
	cmp rax, 0 ; If qword is a nan then return 1, if not a nan then return 0
	jne begin_loop
	mov [r13 + 8 *r15], rbx ; store the qword into the array
	inc r15 ; Increment the counter variable
	jmp begin_loop
end_loop:

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
