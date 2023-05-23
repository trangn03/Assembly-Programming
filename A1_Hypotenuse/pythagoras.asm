;****************************************************************************************************************************
;Program name: "Hypotenuse".  This program takes in the user input of the length of the two sides of the right triangle 
;and calculates the hypotenuse. Copyright (C) 2023 Trang Ngo.                                                                *
;                                                                                                                           *
;This file is part of the software program "Hypotenuse".                                                                   *
;This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License   *
;version 3 as published by the Free Software Foundation.                                                                    *
;This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied          *
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
;  Program name: Hypotenuse
;  Programming languages: One modules in C++ and one module in X86
;  Date program began: 2023 Jan 25
;  Date of last update: 2023 Feb 04
;
;  Files in this program: driver.cpp, pythagoras.asm
;  Status: Finished.
;
;References for this program
;  Jorgensen, X86-64 Assembly Language Programming with Ubuntu
; 
;Purpose
;  Calculate the hypotenuse based on user input
;
;This file
;   File name: pythagoras.asm
;   Language: X86 with Intel syntax.
;   Max page width: 132 columns
;   Assemble: nasm -f elf64 -l pythagoras.lis -o pythagoras.o pythagoras.asm

;===== Begin code area ================================================================================================

; Declaration

extern printf
extern scanf
global pythagoras   ; Name of the function

segment .data

prompt_side1 db "Enter the length of the first side of the triangle: ", 0
prompt_side2 db "Enter the length of the second side of the triangle: ", 0

one_float_form db "%lf", 0

invalid db "Negative values not allowed. Try again: ", 0

confirm db "Thank you. You entered two sides: %1.8lf and %1.8lf", 10,0
output db "The length of the hypotenuse is %1.8lf ", 10,0

segment .bss	
; Empty

segment .text
pythagoras: ; Name of the function

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

;=========Begin inputs for the length of the first side===================
first:

; Prompt for 1st side
push qword 0 ; Reserves 64 bits / 8 bytes on the top of stack
mov rax, 0
mov rdi, prompt_side1 ; "Enter the length of the first side of the triangle: "
call printf
pop rax

; Input for 1st side
push qword 0
mov rax, 0
mov rdi, one_float_form
mov rsi, rsp
call scanf
movsd xmm12, [rsp]
pop rax

; Check for negative input of first side
check_1:
push qword 0
movsd xmm11, [rsp] ; Store first float in xmm11
ucomisd xmm11, xmm12 ; Compare side 1 with 0.0
pop rax
jb second ; Jump to second prompt if number is positive

; Display invalid message 
mov rax, 0
mov rdi, invalid ; "Negative values not allowed. Try again: "
push qword 0
call printf
pop rax

; Scan the input from user
mov rax, 0
mov rdi, one_float_form
push qword 0
mov rsi, rsp
call scanf
movsd xmm12, [rsp]
pop rax
jmp check_1


;=========Begin inputs for the length of the second side===================
second:

; Prompt for 2nd side
push qword 0
mov rax, 0
mov rdi, prompt_side2 ; "Enter the length of the second side of the triangle: "
call printf
pop rax 

; Input for 2nd side
push qword 0
mov rax, 0
mov rdi, one_float_form
mov rsi, rsp
call scanf
movsd xmm13, [rsp]
pop rax

; Check for negative input of second side
check_2:
push qword 0
movsd xmm11, [rsp] ; Store first float in xmm11
ucomisd xmm11, xmm13 ; Compare side 2 with 0.0
pop rax
jb two_side_confirm ; Jump to confirmation message if number is positive
jb calculate ; Jump to calculate the hypotenuse if number is positive

; Display invalid message 
mov rax, 0
mov rdi, invalid ; "Negative values not allowed. Try again: "
push qword 0
call printf
pop rax

; Scan the input from user
mov rax, 0
mov rdi, one_float_form
push qword 0
mov rsi, rsp
call scanf
movsd xmm13, [rsp]
pop rax
jmp check_2

two_side_confirm: 
; Confirm input of user
push qword 0
mov rax, 2 ; Print out the user input with 2 numbers
mov rdi, confirm ; "Thank you. You entered two sides: "
movsd xmm0, xmm12
movsd xmm1, xmm13
call printf
pop rax

;=================Calculate hypotenuse=====================
; a^2 + b^2 = c^2
; square a
; square b
; add square a + square b
; sqrt
; movsd xmm0
; xmm12 - a, xmm13 - b

calculate: 

mulsd xmm12, xmm12 ; square first float
mulsd xmm13, xmm13 ; square second float
addsd xmm13, xmm12 ; add xmm12 and xmm13
sqrtsd xmm12, xmm13 ; taking square root of xmm13 and store answer to xmm12

; Display the length of the hypotenuse
push qword 0
mov rax, 1
mov rdi, output ; "The length of the hypotenuse is "
movsd xmm0, xmm12
call printf
pop rax

movsd xmm0, xmm12 ; Return the hypotenuse to the global function hypotenuse

pop rax ; Reverse the push qword 0 at the beginning

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
