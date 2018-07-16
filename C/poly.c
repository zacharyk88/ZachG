/*
 * Zachary Goss COP3515 poly.c 
 * Evaluates 8 degree polynomials as array with pointer arithmetic
*/

#include <stdio.h>
#include <math.h>

void get_poly(double *coeff); //function to fill coefficient array with pointer arithmetic

double eval_poly(double *coeff, double x); //calculates sum of 8 degree polynomial

double pow(double x, double y);

int main(void)
{
    double coefficients[8] = {0};
    double *coeff = NULL;
    double x = 0.0;
    double output = 0.0;
    
    coeff = &coefficients[0];
    
    get_poly(coeff);
    
    printf("Please input the value for x: ");
    scanf("%lf",&x);
    
    coeff = &coefficients[0];
    
    output = eval_poly(coeff, x);
    
    printf("Output: %.2lf", output);
    
    return 0;
}

void get_poly(double *coeff)
{
    double *p = NULL;
    p = coeff;
    p += 8;
    double holder = 0.0;
    
    /*attempting to fill array with a for loop without index variables
     * led to the passing of the final number input rather than all coefficients passed
     */
    
    printf("Enter the first coefficient ");
    scanf("%lf", &holder); 
    *coeff = holder;
    coeff++; 
    
    printf("Enter the second coefficient ");
    scanf("%lf", &holder); 
    *coeff = holder;
    coeff++; 
    
    printf("Enter the third coefficient ");
    scanf("%lf", &holder); 
    *coeff = holder;
    coeff++; 
    
    printf("Enter the fourth coefficient ");
    scanf("%lf", &holder); 
    *coeff = holder;
    coeff++; 
    
    printf("Enter the fifth coefficient ");
    scanf("%lf", &holder); 
    *coeff = holder;
    coeff++; 
    
    printf("Enter the sixth coefficient ");
    scanf("%lf", &holder); 
    *coeff = holder;
    coeff++;
    
    printf("Enter the seventh coefficient ");
    scanf("%lf", &holder); 
    *coeff = holder;
    coeff++; 
    
    printf("Enter the eighth coefficient ");
    scanf("%lf", &holder); 
    *coeff = holder;
    coeff++;
}

double eval_poly(double *coeff, double x)
{
    double temp = 0.0;
    double sum = 0.0;
    
    //takes value of first coefficient into sum due to the first segment being multiplied by one
    sum = *coeff;
    coeff++;
    
    //this offset is reflected in i starting at 1 rather than 0
    for(int i = 1; i < 8; i++)
    {
        temp = (*coeff * pow(x,i));
        sum += temp;
        coeff++;
    }
    return sum;
}