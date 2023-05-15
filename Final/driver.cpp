// Author name: Trang Ngo
// Author email: trangn0102@csu.fullerton.edu
// Course and section: CPSC240-13
// Today's date: May 15, 2023

//===== Begin code area ===========================================================================================================
#include <stdio.h>
#include <stdint.h>
#include <time.h>
#include <sys/time.h>
#include <stdlib.h>
#include <math.h>

extern "C" long long unsigned int controller();

int main (int argc, char* argv[])
{

    printf("Welcome to triangle by Trang Ngo\n");

    long long unsigned int number = controller();

    printf("\nThe driver received this number for safekeeping: %llu \n", number);
	
    return 0;
}