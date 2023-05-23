;****************************************************************************************************************************
;Program name: "Benchmark". This program benchmarks the performance of the square root instruction in SSE 
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
;  File name: manager.asm
;  Language: X86 with Intel syntax.
;  Max page width: 132 columns
;  Assemble: nasm -f elf64 -l manager.lis -o manager.o manager.asm

;===== Begin code area ================================================================================================

extern printf
extern scanf
extern get_clock_freq
extern getfreq
extern getradicand
extern clock_speed
extern atoi

global manager ; Name of the function

segment .data

welcome db "Welcome to Square Root Benchmarks by Trang Ngo", 10, 0
contact db 10,"For customer service contact me at trangn0102@csu.fullerton.edu", 10, 0

cpu_type db 10,"Your CPU is %s.", 10, 0
max_clock_speed db 10,"Your max clock speed is %0.0lf MHz", 10, 0

sqrt db 10,"The square root of %0.10lf is %0.10lf.", 10, 0

enter_iteration db 10,"Next enter the number of times iteration should be performed: ", 0

time_start db 10,"The time on the clock is %llu tics.", 10, 0
benchmark_sqrtsd db 10,"The bench mark of the sqrtsd instruction is in progress.", 10, 0
time_end db 10,"The time on the clock is %llu tics and the benchmark is completed.", 10, 0
elapsed_time db 10,"The elapsed time was %llu tics", 10, 0
time_one_sqrt_computation db 10,"The time for one square root computation is %0.5lf tics which equals %0.5lf ns.", 10, 0

one_float_format db "%lf", 0
one_int_format db "%ld", 0
one_string_format db "%s", 0

segment .bss

cpu_inf resb 100
input_times resq 50

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

;===================Introduction===================

; Display welcome message
push qword 0
mov rax, 0
mov rdi, welcome ; "Welcome to Square Root Benchmarks by Trang Ngo"
call printf
pop rax

; Display contact message
push qword 0
mov rax, 0
mov rdi, contact ; "For customer service contact me at trangn0102@csu.fullerton.edu"
call printf
pop rax

;===================CPU name===================

mov r15, 0x80000002 ; This value is passed to cpuid to get information about the processor
mov rax, r15 ; Get processor brand and information
cpuid ; Get cpu information

mov [cpu_inf], rax
mov [cpu_inf + 4], rbx
mov [cpu_inf + 8], rcx
mov [cpu_inf + 12], rdx

mov r15, 0x80000003
mov rax, r15
cpuid

mov [cpu_inf + 16], rax
mov [cpu_inf + 20], rbx
mov [cpu_inf + 24], rcx
mov [cpu_inf + 28], rdx

mov r15, 0x80000004
mov rax, r15
cpuid

mov [cpu_inf + 32], rax
mov [cpu_inf + 36], rbx
mov [cpu_inf + 40], rcx
mov [cpu_inf + 44], rdx

; Display CPU type of the computer
push qword 0
mov rax, 0
mov rdi, cpu_type ; "Your CPU is %s."
mov rsi, cpu_inf ; CPU data get from cpu_inf
call printf
pop rax

;===================Get max clock speed===================

call clock_speed
movsd xmm15, xmm0 ; Store the cpu max clock speed in xmm15 (Ghz)

; Convert max clock speed from Ghz to Mhz
mov rax, 1000
cvtsi2sd xmm1, rax
movsd xmm14, xmm15
mulsd xmm14, xmm1

; Display max clock speed
push qword 0
mov rax, 1
mov rdi, max_clock_speed ; "Your max clock speed is %0.0lf MHz"
movsd xmm0, xmm14 ; Move the cpu max clock speed stored in xmm14 to xmm0
call printf
pop rax

;===================Call getradicand to prompt the user to enter float===================

; Get float radicand
push qword 0      
mov rax, 0 
call getradicand
movsd xmm12, xmm0 ; Store the float entered by user in xmm12
pop rax

; Calculate square root of the float entered by user
movsd xmm14, xmm12
sqrtsd xmm12, xmm12

; Display square root of the float
push qword 0
mov rax, 2 ; 2 xmm registers will be use to print the message
mov rdi, sqrt ; "The square root of %0.10lf is %0.10lf."
movsd xmm0, xmm14
movsd xmm1, xmm12 ; xmm12 holds the sqrt computation
call printf
pop rax

;===================Number of times iteration===================

; Prompt the user to enter number of times iterations should be performed
push qword 0
mov rax, 0
mov rdi, enter_iteration ; "Next enter the number of times iteration should be performed: "
call printf
pop rax

; Use scanf to extract user input
push qword 0
mov rax, 0
mov rdi, one_string_format
mov rsi, input_times ; Store the value in input_times that entered by user
call scanf
pop rax

; Convert the string to integer for the number of times iterations entered by user
push qword 0
mov rax, 0
mov rdi, input_times
call atoi
mov r15, rax
pop rax

;===================Time in tics===================

; Get the time in tics (start) r14
xor rdx, rdx
xor rax, rax 
cpuid
rdtsc
shl rdx, 32
add rdx, rax
mov r14, rdx

; Start benchmark iteration
mov r13, 0
begin_loop:
    cmp r15, r13
    je end_loop
    movsd xmm13, xmm14
    sqrtsd xmm13, xmm13 
    inc r13
    jmp begin_loop
end_loop:

; Get the time in tics (end) r13
xor rdx, rdx
xor rax, rax 
cpuid
rdtsc
shl rdx, 32
add rdx, rax
mov r13, rdx

; Display the time in tics at the start
push qword 0
mov rax, 0
mov rdi, time_start ; "The time on the clock is %llu tics."
mov rsi, r14 ; Store tics value in r14
call printf
pop rax

; Display the benchmark is in progress
push qword 0
mov rax, 0
mov rdi, benchmark_sqrtsd ; "The bench mark of the sqrtsd instruction is in progress."
call printf
pop rax

; Display the time in tics at the end and the benchmark completed
push qword 0
mov rax, 0
mov rdi, time_end ; "The time on the clock is %llu tics and the benchmark is completed."
mov rsi, r13 ; Store tics value in r13
call printf
pop rax

;===================Calculate the elapsed time===================
sub r13, r14  ; End (r13) - Start (r14)

; Display elapsed time in tics
push qword 0
mov rax, 0
mov rdi, elapsed_time ; "The elapsed time was %llu tics"
mov rsi, r13 ; Store the elapsed time in r13
call printf
pop rax

;===================Calculate time for one square root computation===================

cvtsi2sd xmm13, r13 ; xmm13 store copy of elapsed time
cvtsi2sd xmm12, r15 ; xmm12 store copy of number of iteration times
divsd xmm13, xmm12 ; Divide elapsed time with number of iteration times
movsd xmm11, xmm13 ; xmm11 stores a copy of time for one square root computation
divsd xmm11, xmm15 ; Divide to get ns

; Display final computation --> result
push qword 0
mov rax, 2 ; 2 xmm registers will be use to print the message
mov rdi, time_one_sqrt_computation ; "The time for one square root computation is %0.5lf tics which equals %0.5lf ns."
movsd xmm0, xmm13 ; Move the time in tics for one square root computation stored in xmm13 to xmm0
movsd xmm1, xmm11 ; Move the time in ns for one square root computation stored in xmm11 to xmm1
call printf
pop rax 

pop rax

movsd xmm0, xmm13 ; Return the result in ns to main

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
