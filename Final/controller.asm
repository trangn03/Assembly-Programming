; Author name: Trang Ngo
; Author email: trangn0102@csu.fullerton.edu
; Course and section: CPSC240-13 Final
; Today's date: May 15, 2023

;===== Begin code area ================================================================================================

extern printf
extern scanf
extern clock_speed
extern getfrequency
extern cos

global controller ; Name of the function

segment .data

two_sides db 10, "Please enter the lengths of two sides of a triangle separated by ws: ", 0
angle db 10, "Please enter the size of the angle in degrees between the two sides: ", 0
third_side db 10, "The length of the third side is %.4lf ", 10, 0
time_before db 10, "The time on the clock before the computation was %llu tics ", 10, 0
time_after db 10, "The time on the clock after the computation was %llu tics.", 10,0
elapsed_time db 10, "The elapsed time was %llu tics", 10, 0
frequency db 10, "The frequency of the clock in this computer is %llu tics/sec.", 10, 0

one_string_format db "%s",0
one_float_format db "%lf",0

segment .bss

cpu_inf resb 100

segment .text

controller:

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

; Prompt the user to enter two sides 
push qword 0 ; Reserves 64 bits / 8 bytes on the top of stack
mov rax, 0
mov rdi, two_sides
call printf
pop rax

; Store input 1
push qword 0
mov rax, 0
mov rdi, one_float_format
mov rsi, rsp
call scanf
movsd xmm10, [rsp]
pop rax

; Store input 2
push qword 0
mov rax, 0
mov rdi, one_float_format
mov rsi, rsp
call scanf
movsd xmm11, [rsp]
pop rax

; Prompt the user to enter size of angle
push qword 0 ; Reserves 64 bits / 8 bytes on the top of stack
mov rax, 0
mov rdi, angle
call printf
pop rax

; Store input size of angle
push qword 0
mov rax, 0
mov rdi, one_float_format
mov rsi, rsp
call scanf
movsd xmm12, [rsp]
pop rax

; Convert degree to radian
mov rax, 0x400921FB54442D18 
push rax                    
movsd xmm0, [rsp]           
pop rax
mov r10, 180 ; r10 stores 180
cvtsi2sd xmm1, r10 ; xmm1 stores 180
; (π/180) * angle in degrees
movsd xmm12, xmm15 ; xmm12 stores a copy of the angle in degrees
divsd xmm12, xmm1
mulsd xmm12, xmm0 ; xmm12 now stores the angle in radians

movsd xmm0, xmm12
call cos ; Calculate cosine of the angle in radians
movsd xmm15, xmm0 ; xmm15 now stores the cosine value

; Calculation for third side
; c^2 = a^2 + b^2 - 2ab*cos(angle)
movsd xmm13, xmm10 ; xmm13 stores a copy of a
mulsd xmm13, xmm13 ; xmm13 now stores a^2

movsd xmm14, xmm11 ; xmm14 stores a copy of b
mulsd xmm14, xmm14 ; xmm14 now stores b^2

mulsd xmm10, xmm11 ; xmm10 now stores a*b
mulsd xmm10, xmm15 ; xmm10 now stores a*b*cos(angle in radians)

subsd xmm13, xmm10 ; xmm13 now stores a^2 - a*b*cos(angle in radians)
subsd xmm14, xmm10 ; xmm14 now stores b^2 - a*b*cos(angle in radians)

addsd xmm13, xmm14 ; xmm13 now stores a^2 + b^2 - 2ab*cos(angle in radians)
sqrtsd xmm13, xmm13 ; xmm13 now stores the square root of c^2

; Output third side
push qword 0
mov rax, 1
mov rdi, third_side
movsd xmm0, xmm13
call printf
pop rax

; Get the time in tics before and put it in r14
cpuid
rdtsc
shl rdx, 32
add rdx, rax
mov r14, rdx

; Display the time in tics
push r14
push r14
push qword 0
mov rax, 0
mov rdi, time_before
mov rsi, r14
call printf
pop rax
pop r14
pop r14

; Get the time in tics after and put it in r13
cpuid
rdtsc
shl rdx, 32
add rdx, rax
mov r13, rdx

; Display the time in tics
push r13
push r13
push qword 0
mov rax, 0
mov rdi, time_after
mov rsi, r13
call printf
pop rax
pop r13
pop r13

; Calculate elapsed time
sub r13, r14

; Output elapsed time
push r13
push r13
push qword 0
mov rax, 0
mov rdi, elapsed_time
mov rsi, r13
call printf
pop rax
pop r13
pop r13

; CPU information
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

; Frequency
call clock_speed
movsd xmm15, xmm0

; Convert max clock speed
mov rax, 1000000000
cvtsi2sd xmm1, rax
movsd xmm14, xmm15
mulsd xmm14, xmm1

; Display frequency of the clock
push qword 0
mov rax, 1
mov rdi, frequency
movsd xmm0, xmm14
call printf
pop rax

pop rax
cvttsd2si rax, xmm14 ; Return frequency to main

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