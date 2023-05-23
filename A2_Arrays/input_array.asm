;****************************************************************************************************************************
;Program name: "Arrays". This program takes in the user input of two array and calculate their magnitude. Copyright (C) 2023 Trang Ngo.                                                                           *
;                                                                                                                           *
;This file is part of the software program "Arrays".                                                                   *
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
;  Section: CPSC240-13
;
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
;   File name: input_array.asm
;   Language: X86 with Intel syntax.
;   Max page width: 132 columns
;   Assemble: nasm -f elf64 -l input_array.lis -o input_array.o input_array.asm

;===== Begin code area ================================================================================================

extern printf
extern scanf
extern clearerr
extern stdin

global input_array ; Name of the function

segment .data

one_float_format db "%lf", 0

segment .bss

segment .text

input_array: ; Name of the function

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

mov r15, rdi ; Hold the array
mov r14, rsi ; Hold size of the array

; For loop for array
mov r13, 0 ; Store array index in r13
begin_loop:
  cmp r14, r13 ; Compare r13 (index) to r14 (size of the array)
  je end_loop
  ; Scan user input
  mov rax, 0
  mov rdi, one_float_format
  push qword 0
  mov rsi, rsp
  call scanf
  ; Check user input for program exit (Ctrl+D)
  cdqe
  cmp rax, -1
  pop r12
  je end_loop
  ; Store user input into the array
  mov [r15 + r13 * 8], r12
  inc r13 ; Increment loop counter
  jmp begin_loop
end_loop:

; Set the failbit to zero.
mov rax, 0
mov rdi, [stdin]
call clearerr

pop rax

mov rax, r13 ; Store array size in rax for return

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