;****************************************************************************************************************************
;Program name: "Arrays". This program takes in the user input of two array and calculate their magnitude. Copyright (C) 2023 Trang Ngo.                                                                           *
;                                                                                                                           *
;This file is part of the software program "Arrays".                                                                   *
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
;
;  Section: CPSC240-13
;Program information
;  Program name: Arrays
;  Programming languages: Two modules in C and four modules in X86
;  Date program began: 2023 Feb 07
;  Date of last update: 2023 Feb 18
;
;  Files in this program: main.c, display_array.c, input_array.asm, manager.asm, magnitude.asm, append.asm, r.sh
;  Status: Finished.
;
;References for this program
;  Jorgensen, X86-64 Assembly Language Programming with Ubuntu
;
;Purpose
;  Calculate the magnitude of two arrays based on user input
;
;This file
;   File name: manager.asm
;   Language: X86 with Intel syntax.
;   Max page width: 132 columns
;   Assemble: nasm -f elf64 -l manager.lis -o manager.o manager.asm

;===== Begin code area ================================================================================================

extern printf
extern scanf
extern input_array
extern append
extern magnitude
extern Display

global manager ; Name of the function

segment .data
intro db "This program will manage your arrays of 64-bit floats.", 10, 0

prompt_array_a db "For array A enter a sequence of 64-bit floats separate by white space", 10, 0
press_a db "After the last input press enter followed by Control+D: ", 10, 0
receive_a db "These number were received and placed into array A: ", 10, 0
magnitude_a db "The magnitude of array A is %.5lf", 10, 0

prompt_array_b db "For array B enter a sequence of 64-bit floats separated by white space.", 10, 0
press_b db "After the last input press enter followed by Control+D: ", 10, 0
receive_b db "These number were received and placed into array B: ", 10, 0
magnitude_b db "The magnitude of array B is %.5lf", 10, 0

append_ab db "Arrays A and B have been appended and given the name A", 0xE2, 0x8A, 0x95," B" ,10,0
contain_ab db "A", 0xE2, 0x8A, 0x95," B contains", 10, 0
magnitude_ab db "The magnitude of A", 0xE2, 0x8A, 0x95," B is %.5lf", 10, 0

segment .bss

array_a resq 50
array_b resq 50
array_ab resq 100

segment .text

manager: ; Name of the function

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

; This program will manage your arrays of 64-bit floats.
push qword 0
mov rax, 0
mov rdi, intro
call printf
pop rax

;=========Inputs for array A===================

; For array A enter a sequence of 64-bit floats separate by white space.
push qword 0
mov rax, 0
mov rdi, prompt_array_a
call printf
pop rax

; After the last input press enter followed by Control+D:
push qword 0
mov rax, 0
mov rdi, press_a
call printf
pop rax

; Fill the arrays
push qword 0
mov rax, 0
mov rdi, array_a
mov rsi, 6
call input_array
mov r15, rax
pop rax

; These number were received and placed into array A:
push qword 0
mov rax, 0
mov rdi, receive_a
call printf
pop rax

; Display the array A
push qword 0
mov rax, 0
mov rdi, array_a
mov rsi, r15
call Display
pop rax

; Call magnitude for array A
push qword 0
mov rax, 0
mov rdi, array_a
mov rsi, r15
call magnitude
movsd xmm15, xmm0
pop rax

; The magnitude of the array A is
push qword 0
mov rax, 1
mov rdi, magnitude_a
movsd xmm0, xmm15
call printf
pop rax

;=========Inputs for array B===================

; For array B enter a sequence of 64-bit floats separate by white space.
push qword 0
mov rax, 0
mov rdi, prompt_array_b
call printf
pop rax

; After the last input press enter followed by Control+D:
push qword 0
mov rax, 0
mov rdi, press_b
call printf
pop rax

; Fill the arrays
push qword 0
mov rax, 0
mov rdi, array_b
mov rsi, 6
call input_array
mov r14, rax
pop rax

; These number were received and placed into array B:
push qword 0
mov rax, 0
mov rdi, receive_b
call printf
pop rax

; Display the array B
push qword 0
mov rax, 0
mov rdi, array_b
mov rsi, r14
call Display
pop rax

; Call magnitude for array B
push qword 0
mov rax, 0
mov rdi, array_b
mov rsi, r14
call magnitude
movsd xmm14, xmm0
pop rax

; The magnitude of the array B is
push qword 0
mov rax, 1
mov rdi, magnitude_b
movsd xmm0, xmm14
call printf
pop rax

;=========Append array A and array B===================

; Arrays A and B have been appended and given the name A⊕ B
push qword 0
mov rax, 0
mov rdi, append_ab
call printf
pop rax

; Append (array_a, array_b, array_ab, s1, s2)
push qword 0
mov rdi, array_a
mov rsi, array_b
mov rdx, array_ab
mov rcx, r15
mov r8, r14
call append
mov r15, rax
pop rax

; A⊕ B contains
push qword 0
mov rax, 0
mov rdi, contain_ab
call printf
pop rax

; Display the arrays
push qword 0
mov rax, 0
mov rdi, array_ab
mov rsi, r15
call Display
pop rax

;=========Magnitude of Array A and B===================

; Call magnitude of array A and array B
push qword 0
mov rax, 0
mov rdi, array_ab
mov rsi, 12
call magnitude
movsd xmm15, xmm0
pop rax

; The magnitude of A⊕ B is
push qword 0
mov rax, 1
mov rdi, magnitude_ab
movsd xmm0, xmm15
call printf
pop rax

movsd xmm0, xmm15

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
