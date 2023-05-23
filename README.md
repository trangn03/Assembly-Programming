# CPSC 240 Computer Organization and Assembly Language

x86 assembly programs mixed with some C++ and C programming.

Developed using VSCode within the Windows Subsystem for Linux (WSL) with default Ubuntu distribution.

## Author

Name: Trang Ngo

Email: trangn0102@csu.fullerton.edu

Semester: Spring 2023

Professor: Floyd Holliday 

Institution: California State University, Fullerton

## Instruction

How to run? `sh r.sh` 

How to debug using GDB? `sh g.sh`

## Assignments Description

### Problem 1

Takes in the user input of the length of the two sides of the right triangle and calculates the hypotenuse. Additionally, detect and reject if the user enter a negative value.

### Problem 2

Create the arrays, takes in the user input of two array, calculate their magnitude, and append the two arrays

### Problem 3

Takes user input of their name and title, then ask how many numbers they want in an array, which can generate up to 100 random numbers. After that, the array will be sorted and normalize within the interval 1.0<=num<=2.0. The array also prints in both IEEE725 and scientific decimal format.

### Problem 4

Benchmarks the performance of the square root instruction in SSE and also the square root program in the standard C library.

### Problem 5

Ask the user to enter a number and then perform comparision of two version of the sine function which is from Taylor series and in math C library. The program also make a check if the number entered by user valid or not. 

### Problem 6

Output a happy birthday message for chris for a user specified amount of times. 

### Midterm

Compute the value of Work (W) in jules from inputs Time (T), Current (I), and Voltage (V).

### Final

Take the user input of two sides of a triangle and the size of the angle in degrees between the two sides. Then compute the third side of a triangle using `c^2  =  a^2  +  b^2  -  2ab*cos(angle opposite to side c in radians)`.The time on the clock in tics before and after the process is recorded to calculate the elapsed tics. Finally get the CPU frequency of the device running the program.