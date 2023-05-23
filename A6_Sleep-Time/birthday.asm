;****************************************************************************************************************************
;Program name: "Sleep Time". This program will output a happy birthday message for chris 
; for a user specified amount of times                                                                 *
; Copyright (C) 2023 Trang Ngo.                                                                           *
;                                                                                                                           *
;This file is part of the software program "Sleep Time".                                                                   *
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
;  Program name: Sleep Time
;  Programming languages: One module in C and one module in X86
;  Date program began: 2023 May 4
;  Date of last update: 2023 May 15
;
;  Files in this program: main.c, birthday.asm, r.sh
;  Status: Unfinished
;
;References for this program
;  Jorgensen, X86-64 Assembly Language Programming with Ubuntu
;  Johnson Tong SI of CPSC-240
;  Professor Holliday's lecture
;
;Purpose
;  This program will output a happy birthday message for chris 
;  for a user specified amount of times
;
;This file
;  File name: birthday.asm
;  Language: X86 with Intel syntax.
;  Max page width: 132 columns
;  Assemble: nasm -f elf64 -l birthday.lis -o birthday.o birthday.asm

;===== Begin code area ================================================================================================

extern printf
extern scanf
extern stdin
extern strlen
extern fgets
extern atoi
extern atof
extern isfloat
extern sin                 
extern usleep

global birthday ; Name of the function

segment .data

greeting db 10, "We will send a birthday greeting to Chris.", 10,0
card db 10, "How many birthday cards do you wish to send? ", 0
delay_time db 10, "What is the delay time (ms) between sending greetings? ", 0
max_frequency db 10, "What is the max frequency of the cpu in this computer as a whole integer? ", 0
clock_start db 10, "Thank you.  The time on the clock is now %llu tics. ", 10,0
happy_birthday db 10, "Happy Birthday, Chris", 10, 0
clock_end db 10, "The time on the clock is now %llu tics", 10, 0
elapsed_time db 10, "The elapsed time was %llu tics.", 10, 0
return db 10, "The elapsed time will be returned to the caller.", 10, 0

one_string_format db "%s",0
one_float_format db "%lf",0

segment .bss

input_times resq 50
delay_times resq 50

segment .text

birthday:

;Prolog ===== Insurance for any caller of this assembly module ============================================================================================================
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

; Introduction - greeting
push qword 0
mov rax, 0
mov rdi, greeting
call printf
pop rax

; Prompt the user to enter birthday card
push qword 0
mov rax, 0
mov rdi, card
call printf
pop rax

; Get the user input number
push qword 0
mov rax, 0
mov rdi, one_string_format
mov rsi, input_times
call scanf
pop rax

; Convert number of birthday cards from string to integer
push qword 0
mov rax, 0
mov rdi, input_times
call atoi
mov r15, rax 
pop rax

; Prompt the user for delay time
push qword 0
mov rax, 0
mov rdi, delay_time
call printf
pop rax

; Get the user delay time
push qword 0
mov rax, 0
mov rdi, one_string_format
mov rsi, delay_times
call scanf
pop rax

; Convert number of birthday cards from string to integer
push qword 0
mov rax, 0
mov rdi, delay_times
call atoi
mov r15, rax 
pop rax

; Convert delay time from milliseconds to microseconds
mov rax, r14
mov rbx, 1000
mul rbx
mov r14, rax

; Prompt user to enter frequency
push qword 0
mov rax, 0
mov rdi, max_frequency
call printf
pop rax

; Get max clock speed
push qword 0
mov rax, 0
mov rdi, one_float_format
mov rsi, rsp
call scanf
movsd xmm15, xmm0
pop rax

; Get the time in tics (start) r13
xor rdx, rdx 
xor rax, rax               
cpuid                     
rdtsc                      
shl rdx, 32                
add rdx, rax                
mov r13, rdx

; Display tics start
push qword 0
mov rax, 0
mov rdi, clock_start
mov rsi, r13
call printf
pop rax

; Display a loop that print the iteration of birthday cards
; that the user enter

mov r12, 0 ; Counter
begin_loop:
    cmp r12, r15
    je end_loop

    push qword 0
    mov rax, 0
    mov rdi, happy_birthday
    call printf
    pop rax 

    ; Iteration 
    push qword 0
    mov rax, 0
    mov rdi, r14
    call usleep
    pop rax

    inc r12
    jmp end_loop
end_loop:

; Get the time in tics (end) r12
xor rdx, rdx
xor rax, rax 
cpuid
rdtsc
shl rdx, 32
add rdx, rax
mov r12, rdx

; Display tics end
push qword 0
mov rax, 0
mov rdi, clock_end
mov rsi, r12
call printf
pop rax

; Calculate elapsed tics
sub r12, r13

; Display elapsed tics
push qword 0
mov rax, 0
mov rdi, elapsed_time
mov rsi, r12
call printf
pop rax

; Return the elapsed to main
push qword 0
mov rax, 0
mov rdi, return
call printf
pop rax

pop rax
mov rax, r12 ; Return r12 (elapsed tics) to main

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