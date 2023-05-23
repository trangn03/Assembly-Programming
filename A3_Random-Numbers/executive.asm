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
;  File name: executive.asm
;  Language: X86 with Intel syntax.
;  Max page width: 132 columns
;  Assemble: nasm -f elf64 -l executive.lis -o executive.o executive.asm

;===== Begin code area ================================================================================================

extern printf
extern scanf
extern stdin
extern fgets
extern strlen
extern qsort
extern atoi

extern fill_random_array
extern show_array
extern quick_sort

max_input_size equ 256 ; max bytes of name, title

global executive ; Name of the function

segment .data

ask_name db "Please enter your name: ", 0
ask_title db "Please enter your title (Mr,Ms,Sargent,Chief,Project Leader,etc): ", 0
greeting db "Nice to meet you ", 0

intro db "This program will generate 64-bit IEEE float numbers.", 10, 0
number db "How many numbers do you want. Today's limit is 100 per customer. ", 0
display db "Your numbers have been stored in an array. Here is that array.", 10, 10, 0
sort_array db 10,"The array is now being sorted.", 10, 0
update db 10,"Here is the updated array.", 10, 10, 0

normalize db 10,"The random numbers will be normalized. Here is the normalized array", 10, 10, 0
sort_normalize db 10,"The normalized array is now being sorted.", 10, 0

goodbye db "Good bye " , 0
goodbye2 db ". You are welcome any time.", 10, 0

invalid db "The value entered is invalid. Please input again. ", 10, 0

space db " ", 0
newline db " ", 10, 0
one_string_format db "%s", 0
one_int_format db "%ld", 0

segment .bss

name resb max_input_size ; reserve byte for name
title resb max_input_size ; reserve byte for title

array resq 100 ; array to store random numbers (max capacity: 100)
array_size resq 50 ; store input of user for generating the random 

segment .text

executive: ; Name of the function

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

;=========User's input for name and title===================

; Prompt the user to enter name
push qword 0
mov rax, 0 ; Indicate 0 floating point arguments
mov rdi, one_string_format ; Move string format argument into register rdi
mov rsi, ask_name ; "Please enter your name: "
call printf ; Call external function printf
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

; Prompt the user to enter title
push qword 0
mov rax, 0 ; Indicate 0 floating point arguments
mov rdi, one_string_format ; Move string format argument into register rdi
mov rsi, ask_title ; "Please enter your title (Mr,Ms,Sargent,Chief,Project Leader,etc): "
call printf ; Call external function printf
pop rax

; Extract title from the user and store it in title variable
push qword 0
mov rax, 0 ; Indicate we have no floating point arguments to pass to external function
mov rdi, title ; Move title variable as first argument into register rdi
mov rsi, max_input_size ; Provide fgets with second argument, the size of the byte reserves
mov rdx, [stdin] ; Move the contents at address of stdin, i.e dereference, into third argument
call fgets ; Call external function fgets
pop rax

; Remove newline char from fgets input of title
push qword 0
mov rax, 0 ; Indicate 0 floating point arguments
mov rdi, title ; Move title variable as first argument into register rdi
call strlen ; Call the external function strlen, which returns the length of the string
sub rax, 1 ; The length is now store in rax. We subtract 1 from rax to obtain the location of '\n'
mov byte [title + rax], 0 ; Replace the byte where '\n' exits with '\0'
pop rax

; Display greeting message that contains title and name of user that entered
push qword 0
mov rax, 0
mov rdi, one_string_format
mov rsi, greeting ; "Nice to meet you "
call printf
pop rax

; Display the user's title
push qword 0
mov rax, 0
mov rdi, one_string_format
mov rsi, title
call printf
pop rax

; Place a space between title and name of the user
push qword 0
mov rax, 0
mov rdi, one_string_format
mov rsi, space
call printf
pop rax

; Display the user's name
push qword 0
mov rax, 0
mov rdi, one_string_format
mov rsi, name
call printf
pop rax

; Print a newline 
push qword 0
mov rax, 0
mov rdi, newline
call printf
pop rax

; Print a newline
push qword 0
mov rax, 0
mov rdi, newline
call printf
pop rax

; Display the description of the program
push qword 0
mov rax, 0
mov rdi, intro ; "This program will generate 64-bit IEEE float numbers."
call printf
pop rax

;=========User's input of numbers===================

; Prompt the user to enter the amount of float to store into the array
begin_loop_1:
push qword 0
mov rax, 0
mov rdi, number ; How many numbers do you want. Today's limit is 100 per customer.
call printf
pop rax

; Extract input from user 
push qword 0
mov rax, 0
mov rdi, one_string_format
mov rsi, array_size
call scanf
pop rax

;=========Reject invalid input value from the user===================

; Convert the string of the amount of random number that entered by user into integer
push qword 0
mov rdi, array_size         
call atoi ; Call external function atoi that will convert the string and return it in integer                
; The value returned by atoi in rax will store to r15
; r15 becomes the amount of random numbers to be generated
mov r15, rax               
pop rax    

; Check if the value of the user entered is out of bounds
cmp r15, 100 ; Compare the value with 100
jg out_of_range ; Jump to out_of_range if the value is greater than 100
cmp r15, 0 ; Compare the value with 0 to check for negative input
js out_of_range ; Jump to out_of_range if the value is less than 0, which is negative input entered
jmp end_loop_1 ; Jump to end_loop_1 if the value is within the bounds of 0<=x<=100

; Print error message if the value entered is out of bounds
; Then jump to begin_loop_1 for the user to enter a new value
out_of_range:
push qword 0
mov rax, 0
mov rdi, invalid ; "The value entered is invalid. Please input again. "
call printf
pop rax
jmp begin_loop_1 ; Jump to begin_loop_1 for user to input new value
end_loop_1:

;=========Fill and store the array===================

; Fill random array
push qword 0
mov rax, 0
mov rdi, array
mov rsi, r15
call fill_random_array ; Call asm file fill_random_array to fill the array with random numbers
pop rax

; Display the message of numbers have been stored in the array from user's input
push qword 0
mov rax, 0
mov rdi, display ; Your numbers have been stored in an array. Here is that array.
call printf
pop rax

; Call show_array to display the contents of the array
push qword 0
mov rax, 0
mov rdi, array
mov rsi, r15
call show_array
pop rax

;=========Sort the array===================

; Display message for user to know that the array is being sorted
push qword 0
mov rax, 0
mov rdi, sort_array ; The array is now being sorted.
call printf
pop rax

; Call quick_sort
; Which sort the array from smallest to largest
push qword 0
mov rax, 0
mov rdi, array
mov rsi, r15
mov rdx, 8
mov rcx, quick_sort
call qsort
pop rax

; After finish sorting, display message to tell the user that the array is sorted
push qword 0
mov rax, 0
mov rdi, update ; "Here is the updated array."
call printf
pop rax

; Call show_array 
; Display the array in both IEEE754 and scientific decimal format
push qword 0
mov rax, 0
mov rdi, array
mov rsi, r15
call show_array
pop rax

;=========Normalize the array===================

; Display normalize message 
push qword 0
mov rax, 0
mov rdi, normalize ; "The random numbers will be normalized. Here is the normalized array"
call printf
pop rax

; Normalize the array
push qword 0
mov rax, 0
mov r13, 0 ; r13 is the index
begin_loop_2:
    cmp r13, r15
    jge end_loop_2

    cmp r13, 99 ; Check if r13 is greater than the index of the last element
    jg out_of_bounds ; Jump to out_of_bounds if r13 exceeds this limit

    mov rbx, [array + 8 * r13] ; Load the value at the current index of the array into rbx
    shl rbx, 12 ; Shift the value in rbx left by 12 bits to align the mantissa
    shr rbx, 12 ; Shift the value in rbx right by 12 bits to set the mantissa to the lower 52 bits
    mov r8, 1023 ; Load the value 1023 into r8
    shl r8, 52 ; Shift the value in r8 left by 52 so it has 1023 infront 
    or rbx, r8 ; Combine rbx and r8 together so it will form IEEE754 number between 1.0<=num<=2.0
    mov [array + 8 * r13], rbx ; Store the resulting floating point number back into the array at the current index (rbx)

    inc r13 ; Increment the counter variable
    jmp begin_loop_2

out_of_bounds:

end_loop_2:
pop rax

; Call show_array 
; Prints the array in both IEEE754 and scientific decimal format
push qword 0
mov rax, 0
mov rdi, array
mov rsi, r15
call show_array
pop rax

;=========Sort the normalized array===================

; Display message for user to know that the normalized array is being sorted
push qword 0
mov rax, 0
mov rdi, sort_normalize ; The normalized array is now being sorted
call printf
pop rax

; Call quick_sort
; Which sort the array from smallest to largest
push qword 0
mov rax, 0
mov rdi, array
mov rsi, r15
mov rdx, 8
mov rcx, quick_sort
call qsort
pop rax

; After finish sorting, display message to tell the user that the normalized array is sorted
push qword 0
mov rax, 0
mov rdi, update ; Here is the updated array
call printf
pop rax

; Call show_array 
; Display the array in both IEEE754 and scientific decimal format
push qword 0
mov rax, 0
mov rdi, array
mov rsi, r15
call show_array
pop rax

;=========Goodbye message===================

; Display goodbye message
push qword 0
mov rax, 0
mov rdi, one_string_format
mov rsi, goodbye ; "Goodbye "
call printf
pop rax

; Display the title between goodbye message
push qword 0
mov rax, 0
mov rdi, one_string_format
mov rsi, title
call printf
pop rax

; Display the rest of goodbye message
push qword 0
mov rax, 0
mov rdi, one_string_format
mov rsi, goodbye2 ; ". You are welcome any time."
call printf
pop rax

pop rax

; Move name into rax general purpose register
; which is used to return values to the calling function (main.c)
mov rax, name

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
