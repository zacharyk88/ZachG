
#include <stdio.h>

int main(void) 
{
    int num_quarters = 0;
    int num_dimes = 0;
    int num_nickles = 0;
    int num_pennies = 0;
    

    
    printf("Please enter the number of quarters: ");
    scanf("%d", &num_quarters);
    
    printf("Please enter the number of dimes: ");
    scanf("%d", &num_dimes);

    printf("Please enter the number of nickels: ");
    scanf("%d", &num_nickles);

    printf("Please enter the number of pennies: ");
    scanf("%d", &num_pennies);
    
    int amount = num_quarters * 25 + num_dimes * 10 + num_nickles * 5 + num_pennies;    
    printf("The total amount is %d cents \n", amount);

    return 0;
}

