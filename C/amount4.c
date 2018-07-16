
#include <stdio.h>

#define QUARTER 25
#define DIME 10
#define NICKEL 5
#define PENNY 1

int main(void) 
{
    int num_quarters = 0;
    int num_dimes = 0;
    int num_nickles = 0;
    int num_pennies = 0;
    double dollars = 0;    

    
    printf("Please enter the number of quarters: ");
    scanf("%d", &num_quarters);
    
    printf("Please enter the number of dimes: ");
    scanf("%d", &num_dimes);

    printf("Please enter the number of nickels: ");
    scanf("%d", &num_nickles);

    printf("Please enter the number of pennies: ");
    scanf("%d", &num_pennies);

    int amount = num_quarters * QUARTER + num_dimes * DIME + num_nickles * NICKEL  + num_pennies;    
      
    dollars = amount / 100.0;

    printf("The total amount is %.2lf dollars \n", dollars);
   
    return 0;
}

