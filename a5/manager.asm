;****************************************************************************************************************************
;Program name: "Data Validation". This program will ask the user to enter a number and then perform comparision of two
; version of the sine function which is from Taylor series and in math C library. The program also make a check if the 
; number entered by user valid or not. 
; Copyright (C) 2023 Trang Ngo.                                                                           *
;                                                                                                                           *
;This file is part of the software program "Data Validation".                                                                   *
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
;  Program name: Data Validation
;  Programming languages: One module in C and three modules in X86
;  Date program began: 2023 April 17
;  Date of last update: 2023 April 29
;
;  Files in this program: driver.c, manager.asm, isfloat.asm, r.sh
;  Status: Finished.
;
;References for this program
;  Jorgensen, X86-64 Assembly Language Programming with Ubuntu
;  Johnson Tong SI of CPSC-240
;  Professor Holliday's lecture
;
;Purpose
; This program will ask the user to enter a number and then perform comparision of two
; version of the sine function which is from Taylor series and in math C library. The program also make a check if the 
; number entered by user valid or not.  
;
;This file
;  File name: manager.asm
;  Language: X86 with Intel syntax.
;  Max page width: 132 columns
;  Assemble: nasm -f elf64 -l manager.lis -o manager.o manager.asm

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

global manager ; Name of the function

segment .data

program db 10,"This program Sine Function Benchmark is maintained by Trang Ngo", 10,0                                 ;Output welcome message of program to user
enter_name db 10,"Please enter your name: ",0                                                                           ;prompt user to enter name
greet db 10,"It is nice to meet you ",0                                                                             ;Greet user with the entered name
enter_angle db ". Please enter an angle number in degrees: ",0                                                          ;prompt user for an angle number in degrees to be used 
enter_terms db 10,"Thank you. Please enter the number of terms in a Taylor series to be computed: ",0                 ;prompt user for number of terms in a Taylor series to be computed
compute_taylor db 10,"Thank you. The Taylor series will be used to compute the sine of your angle.",10,0                ;Output user that Taylor series is in progress
complete_taylor db 10,"The computation completed in %llu tics and the computed value is %.9lf",10,0                             ;Output the elapsed tics and result from the Taylor series
compute_sin db 10,"Next the sine of %.9lf will be computed by the function “sin” in the library <math.h>.",10,0   ;Output user that sin library function calculation is in progress
complete_sin db 10,"The computation completed in %llu tics and gave the value %.9lf",10,0                                    ;Output the elapsed tics and result from sin library function

error db "Invalid. Please try again: ",0                                                                        ;tell user that the last input is not a vaild float       

max_input_size equ 256 ; Max bytes of name
one_string_format db "%s",0
one_float_format db "%lf",0

segment .bss

name resb max_input_size ; Reserve bytes for name
input_times resq 50

segment .text

manager:

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

; Welcome message
push qword 0             
mov rax, 0              
mov rdi, program ; "This program Sine Function Benchmark is maintained by Trang Ngo"
call printf             
pop rax                 

; Prompt the user to enter name
push qword 0 
mov rax, 0              
mov rdi, enter_name ; "Please enter your name: "
call printf             
pop rax                 

; Extract name from the user and store it in name variable
push qword 0
mov rax, 0 ; Indicate we have no floating point arguments to pass to external function
mov rdi, name ; Move name variable as first argument into register rdi
mov rsi, max_input_size ; Provide fgets with second argument, the size of the byte reserves
mov rdx, [stdin] ; Move the contents at address of stdin, i.e dereference, into third argument
call fgets ; Call the external function fgets
pop rax

; Remove newline char from fgets input of name
push qword 0
mov rax, 0 ; Indicate 0 floating point arguments
mov rdi, name ; Move name variable as first argument into register rdi
call strlen ; Call the external function strlen, which returns the length of the string
sub rax, 1 ; The length is now store in rax. We subtract 1 from rax to obtain the location of '\n'
mov byte [name + rax], 0 ; Replace the byte where '\n' exits with '\0'
pop rax

; Greeting
push qword 0                
mov rax, 0                  
mov rdi, greet ; "It is nice to meet you "
call printf                
pop rax                     

; Display the name of user
push qword 0
mov rax, 0
mov rdi, name
call printf
pop rax

; Prompt the user to enter angle
push qword 0                
mov rax, 0                  
mov rdi, enter_angle ; ". Please enter an angle number in degrees: "
call printf                 
pop rax 

; Start loop - extract float entered by user
begin_loop1:
    push qword 0                    
    mov rax, 0                      
    mov rdi, one_string_format ; "%s"
    mov rsi, rsp                    
    call scanf                      
    ; Check the input
    mov rax, 0                      
    mov rdi, rsp                    
    call isfloat ; Call asm isfloat module
    cmp rax, -1                     
    je end_loop1                    
    ; Invalid input
    mov rax, 0                      
    mov rdi, error ; "Invalid. Please try again: "
    call printf                     
    pop rax                         
    jmp begin_loop1
; Valid input - is a float
end_loop1:
    mov rdi, rsp              
    call atof                   
    movsd xmm15, xmm0           
    pop rax                     

; Enter the number of terms in a Taylor series for computation
push qword 0               
mov rax, 0                  
mov rdi, enter_terms ; "Thank you. Please enter the number of terms in a Taylor series to be computed: "
call printf                
pop rax                     

; Number of times iterations should be performed
push qword 0                
mov rax, 0                  
mov rdi, one_string_format ; "%s"
mov rsi, input_times ; Store the value entered by user in input_times
call scanf                  
pop rax                     

; Convert the string of number iteration to integer
push qword 0
mov rax, 0
mov rdi, input_times
call atoi
mov r15, rax
pop rax

;===================Compute Taylor series===================
; Compute taylor
push qword 0                
mov rax, 0                  
mov rdi, compute_taylor ;"Thank you. The Taylor series will be used to compute the sine of your angle."
call printf               
pop rax                     

; Get the time in tics (start) r13 for taylor series
xor rax, rax               
cpuid                     
rdtsc                      
shl rdx, 32                
add rdx, rax                
mov r13, rdx

; Taylor series begin
; Convert the angle in degrees to radians
mov rax, 0x400921FB54442D18 
push rax                    
movsd xmm0, [rsp]           
pop rax
mov r10, 180 ; r10 stores 180
cvtsi2sd xmm1, r10 ; xmm1 stores 180
; (π/180) * angle in degrees
movsd xmm3, xmm15 ; xmm3 stores a copy of the angle in degrees
divsd xmm3, xmm1
mulsd xmm3, xmm0 ; xmm3 now stores the angle in radians

;   -1*x^2
;----------------
;  (2k+3)*(2k+2)

; x is the user inputted number
; k is what iteration we are on

movsd xmm1, xmm3
; We need the numbers 3.0, 2.0, and -1.0 to multiply floats 
mov rax, 3
cvtsi2sd xmm13, rax ; xmm13 stores 3.0 for 3 in 2k+3
mov rax, 2         
cvtsi2sd xmm12, rax ; xmm12 stores 2.0 for 2 in 2k+2     
mov rax, -1        
cvtsi2sd xmm11, rax ; xmm11 stores -1.0 for -1
mov r14, 0 ; Counter
cvtsi2sd xmm14, r14 ; xmm14 stores counter in float
xorpd xmm10, xmm10 ; Total sum so far

begin_loop2:
    cmp r15, r14        
    je end_loop2        
    ; Otherwise, add the current term of the sequence
    addsd xmm10, xmm1

    ; 2k+2 - xmm12 * xmm14 + xmm12
    ; Creat temporary register for calculations xmm9
    movsd xmm9, xmm12
    mulsd xmm9, xmm14
    addsd xmm9, xmm12 ; xmm9 2k+2

    ; 2k+3 - xmm12 * xmm14 + xmm13
    ; Creat temporary register for calculations xmm8
    movsd xmm8, xmm12
    mulsd xmm8, xmm14
    addsd xmm8, xmm13 ; xmm8 stores 2k+3

    ; (2k+3) * (2k+2)
    mulsd xmm8, xmm9 ;xmm8 stores (2k+3) * (2k+2)

    ; x^2 
    ; Create temporary register for calculations xmm7
    movsd xmm7, xmm3 ; xmm7 stores a copy of angle in radians
    mulsd xmm7, xmm7 ; xmm7 stores x^2

    ;      x^2
    ;----------------
    ;  (2k+3)*(2k+2)

    divsd xmm7, xmm8 ; xmm7 stores x^2
    mulsd xmm7, xmm11 ; Multiply xmm7 with -1 to get final value
    mulsd xmm1, xmm7 ; Multiply xmm8 with current term of Taylor series
    inc r14 ; Increment counter
    cvtsi2sd xmm14, r14
    jmp begin_loop2
end_loop2:

; Get the time in tics (end) r14 for taylor series
xor rdx, rdx
xor rax, rax 
cpuid
rdtsc
shl rdx, 32
add rdx, rax
mov r14, rdx

; Calculate elapsed tics
sub r14, r13 

; Display elapsed tics and the complete taylor
push qword 0           
mov rax, 1 ; 1 xmm register will be printed             
mov rdi, complete_taylor ;"The computation completed in %llu tics and the computed value is %.9lf"
mov rsi, r14               
movsd xmm0, xmm10
call printf            
pop rax

;===================Compute Sine===================
; Compute sine
push qword 0      
mov rax, 1 ; 1 xmm register will be printed
mov rdi, compute_sin ;"Next the sine of %.9lf will be computed by the function “sin” in the library <math.h>."
movsd xmm0, xmm15        
call printf          
pop rax             

; Get the time in tics (start) r13 for sin
xor rdx, rdx              
xor rax, rax             
cpuid                     
rdtsc                 
shl rdx, 32               
add rdx, rax               
mov r13, rdx 

; Call sin library function
push qword 0                
mov rax, 0                
movsd xmm0, xmm3          
call sin ; Call sin library function to calculate the sin value of the angle
movsd xmm9, xmm0 ; xmm9 stores the result of sin library function
pop rax

; Get the time in tics (end) r14 for sin
xor rdx, rdx       
xor rax, rax         
cpuid              
rdtsc                   
shl rdx, 32              
add rdx, rax    
mov r14, rdx           

; Calculate elapsed tics
sub r14, r13

; Display elapsed tics and the complete sin function
push qword 0            
mov rax, 1 ; 1 xmm register will be printed                  
mov rdi, complete_sin ; "The computation completed in %llu tics and gave the value %.9lf"
mov rsi, r14        
movsd xmm0, xmm9
call printf            
pop rax                    

pop rax 
movsd xmm0, xmm9

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
