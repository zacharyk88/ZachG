
#include <stdio.h>

// Zach Goss COP3515 Coffee or Tea vending machine with error checking

int main(void)
{
    int total_inserted = 0;
    int coin = 1;
    int choice = 0;
    int change = 0;
    
    while (coin > 0) //sentinel control to break out of loop when user has deposited desired amount
    {
        printf("Please insert coins (0 to quit): ");
        scanf("%d", &coin);
        total_inserted += coin;
    }
    
    printf("You have inserted %d cents, Please enter 1. for Coffee, or 2. for Tea: ", total_inserted);
    scanf("%d", &choice); 
    
    while(choice != 1 && choice != 2) //Error checking to ensure choice is valid
    {
        printf("ERROR: Please select either 1. for Coffee, or 2. for Tea: ");
        scanf("%d", &choice);
    } 
    
    switch(choice) //switch to discern which choice and if there was enough money inserted
    {
        case 1:
            if(total_inserted >= 25)
            {
                change = total_inserted - 25;
                printf("Dispensing Coffee . . . \nYour change is %d cents \n", change);
            }
            else
            {
                printf("ERROR: Insufficient Funds . . .\n Your change is %d cents \n", total_inserted);
            }
            break;
        case 2:
            if(total_inserted >= 15)
            {
                change = total_inserted - 15;
                printf("Dispensing Tea . . . \nYour change is %d cents \n", change);
            }
            else
            {
                printf("ERROR: Insufficient Funds . . .\n Your change is %d cents \n", total_inserted);
            }
            break;
    }
    
    return 0;
}

