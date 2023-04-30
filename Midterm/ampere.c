// Author name: Trang Ngo
// Author email: trangn0102@csu.fullerton.edu
// Course and section: CPSC240-13
// Today's date: Mar 22, 2023

//===== Begin code area ===========================================================================================================

#include <stdio.h>
#include <stdint.h>
#include <time.h>
#include <sys/time.h>
#include <stdlib.h>

extern double faraday();

int main(int argc, char* argv[])
{
  printf("Welcome to the High Voltage Software System by Trang Ngo\n");

  double result = 0.0;
  result = faraday();

  printf("\nThank you for your number %.10lf. Have a nice research party.\n", result);
  printf("Zero is returned to the operating system.\n");
  return 0;
}