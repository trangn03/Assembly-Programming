; Author name: Trang Ngo
; Author email: trangn0102@csu.fullerton.edu
; Course and section: CPSC240-13
; Today's date: Mar 22, 2023

;===== Begin code area ================================================================================================

extern printf
extern scanf
extern fgets
extern strlen
extern stdin

max_input_size equ 256 ; Max bytes of name, title

global faraday ; Name of the function

segment .data

align 16

welcome db "This program will help discover your work.", 10, 0
voltage db "Please enter the voltage applied to your electric device: ", 0
resistance db "Please enter the electric resistance found in your device: ", 0
time db "Please enter the time in seconds when your electric device was running: ", 0

ask_last_name db "What is your last name? ", 0
ask_title db "What is your title? ", 0

thanks db "Thank you " , 0
work db ". The work performed by your device was %0.10lf joules.", 10, 0

bye db "Good-bye ", 0
bye2 db ".", 0

space db " ", 0
newline db " ", 10, 0
one_string_format db "%s", 0
one_float_format db "%lf", 0

align 64

segment .bss

last_name resb max_input_size ; Reserve byte for name
title resb max_input_size ; Reserve byte for title

segment .text

faraday: ; Name of the function

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

push qword 0 ; Remain on boundary

; Display welcome message
push qword 0
mov rax, 0
mov rdi, welcome
call printf
pop rax

; Ask user for voltage input
push qword 0
mov rax, 0
mov rdi, one_string_format
mov rsi, voltage
call printf
pop rax

; Get the input voltage and store them into xmm12 register
push qword 0
mov rax, 0
mov rdi, one_float_format
mov rsi, rsp
call scanf
movsd xmm12, [rsp]
pop rax

; Ask user for electric resistance input
push qword 0
mov rax, 0
mov rdi, one_string_format
mov rsi, resistance
call printf
pop rax

; Get the input voltage and store them into xmm13 register
push qword 0
mov rax, 0
mov rdi, one_float_format
mov rsi, rsp
call scanf
movsd xmm13, [rsp]
pop rax

; Ask user for time input
push qword 0
mov rax, 0
mov rdi, one_string_format
mov rsi, time
call printf
pop rax

; Get the input voltage and store them into xmm14 register
push qword 0
mov rax, 0
mov rdi, one_float_format
mov rsi, rsp
call scanf
movsd xmm14, [rsp]
pop rax

; Calculation
; xmm12 - voltage, xmm13 - resistance, xmm14 - time in seconds
; W = P x T
; W = V x I x T
; W = Voltage x Voltage / Resistance x Time
mulsd xmm12, xmm12
divsd xmm12, xmm13
mulsd xmm12, xmm14
movsd xmm15, xmm12 ; Save the calculation in register xmm15

; Ask user to enter last name
push qword 0
mov rax, 0
mov rdi, one_string_format
mov rsi, ask_last_name
call printf
pop rax

; Consumes the extra new line character created by scanf
push qword 0
mov rax, 0
mov rdi, last_name
mov rsi, max_input_size
mov rdx, [stdin]
call fgets ; Call the external function fgets
pop rax

; This block actually receives the input from user
push qword 0
mov rax, 0
mov rdi, last_name
mov rsi, max_input_size
mov rdx, [stdin]
call fgets ; Call the external function fgets
pop rax

; Remove newline char from fgets input of name
push qword 0
mov rax, 0 
mov rdi, last_name
call strlen
sub rax, 1 ; The length is now store in rax. We subtract 1 from rax to obtain the location of '\n'
mov byte [last_name + rax], 0 ; Replace the byte where '\n' exits with '\0'
pop rax

; Ask for title
push qword 0
mov rax, 0
mov rdi, one_string_format
mov rsi, ask_title
call printf
pop rax

; Extract title from the user and store it in title variable
push qword 0
mov rax, 0
mov rdi, title
mov rsi, max_input_size
mov rdx, [stdin]
call fgets ; Call external function fgets
pop rax

; Remove newline char from fgets input of title
push qword 0
mov rax, 0
mov rdi, title
call strlen
sub rax, 1 ; The length is now store in rax. We subtract 1 from rax to obtain the location of '\n'
mov byte [title + rax], 0 ; Replace the byte where '\n' exits with '\0'
pop rax

; Display thank you message
push qword 0
mov rax, 0
mov rdi, one_string_format
mov rsi, thanks
call printf
pop rax

; Display the user's title
push qword 0
mov rax, 0
mov rdi, one_string_format
mov rsi, title
call printf
pop rax

; Display work message
push qword 0
mov rax, 1 
mov rdi, work
movsd xmm0, xmm15
call printf
pop rax

; Output goodbye message
push qword 0
mov rax, 0
mov rdi, one_string_format
mov rsi, bye ; "Good-bye "
call printf
pop rax

; Display user's title in goodbye message
push qword 0
mov rax, 0
mov rdi, one_string_format
mov rsi, title
call printf
pop rax

; Place a space between title and last name of the user
push qword 0
mov rax, 0
mov rdi, one_string_format
mov rsi, space
call printf
pop rax

; Display the user's last name in goodbye message
push qword 0
mov rax, 0
mov rdi, one_string_format
mov rsi, last_name
call printf
pop rax

; Display the rest of goodbye message
push qword 0
mov rax, 0
mov rdi, one_string_format
mov rsi, bye2 ; "."
call printf
pop rax

pop rax ; counter push at the beginning

movsd xmm0, xmm15

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