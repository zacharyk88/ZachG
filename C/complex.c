/* 
 * File:   complex.c
 * Author: Zach
 * calculates the sum and difference of 2 inputted complex numbers
 */

#include <stdio.h>

void sum_diff(double *r3, double *i3, double *r4, double *i4);

int main() 
{
   double sum_r = 0; //variable to pass for sum of the real portion of the value
   double sum_i = 0; //variable to pass for sum of the imaginary portion of the value
    
   double diff_r = 0; //variable to pass for difference of the real portion of the value
   double diff_i = 0;//variable to pass for difference of the imaginary portion of the value
    
   sum_diff(&sum_r, &sum_i, &diff_r, &diff_i); //passing variable locations into function
   
   printf("the sum of the complex numbers is %.3lf + %.3lfi\n", sum_r, sum_i);
   
   printf("The difference of the complex numbers is %.3lf + %.3lfi", diff_r, diff_i);
   //prints sum and difference of inputted complex numbers to 3 decimal places
   
   return (0);
}

void sum_diff(double *r3, double *i3, double *r4, double *i4)
{
    double num1_r = 0; //variables for holding real and imaginary components to be processed
    double num1_i = 0;
    double num2_r = 0;
    double num2_i = 0;
    
    printf("Please input the real component of the first complex number: ");
    scanf("%lf", &num1_r);
    
    printf("Please input the imaginary component of the first complex number: ");
    scanf("%lf", &num1_i);
    
    printf("Please input the real component of the second complex number: ");
    scanf("%lf", &num2_r);
    
    printf("Please input the imaginary component of the second complex number: ");
    scanf("%lf", &num2_i);
    
    *r3 = num1_r + num2_r; //setting pointers to proper sum and difference values
    *i3 = num1_i + num2_i;
    *r4 = num1_r - num2_r;
    *i4 = num1_i - num2_i;
}