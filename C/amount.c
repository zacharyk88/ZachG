
#include <stdio.h>

int main(void) 
{
    int num_quarters = 6;
    int num_dimes = 10;
    int num_nickles = 3;
    int num_pennies = 2;
    
    int amount = num_quarters * 25 + num_dimes * 10 + num_nickles * 5 + num_pennies;
    
    printf("The total amount is %d cents \n", amount);

    return 0;
}

