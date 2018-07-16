/* 
 * File:   rectangle.c
 * Author: Zach
 * Calculates the area and perimeter of a user inputted rectangle
 */

#include <stdio.h>

//function prototype for area and perimeter function
void area_perimeter(double width, double length, double *area, double *perimeter);

int main() 
{
    double width = 0;
    double length = 0;
    double area = 0;
    double perimeter = 0;

    
    printf("Please input the width of the rectangle: ");
    scanf("%lf", &width);
    
    printf("Please input the length of the rectangle: ");
    scanf("%lf", &length);
    
    area_perimeter(width, length, &area, &perimeter);
    
    printf("The area of the rectangle is: %lf \nThe perimeter of the rectangle is %lf", area, perimeter);
    
    return (0);
}

void area_perimeter(double width, double length, double *area, double *perimeter)
{
    //area pointer changes variable area in main function
    *area = width * length;
    
    //perimeter pointer changes variable perimeter in main function
    *perimeter = 2 * (width + length);
}