/*
 * Zachary Goss COP3515 numbers.c 
 * Takes user inputted string, removes any comments, and outputs that edited string
*/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

//function prototype for string comparison to check command-line validity
int strcmp(const char *s1, const char *s2);

int main(int argc, char *argv[]) 
{
    int smallest = 0;
    int largest = 0;
    int temp = 0;
    int i = 0;

    char *smallest_ch = "-s";
    char *largest_ch = "-l";
    
    //was receiving a segmentation fault 11 if this statement wasn't present
    if (argc < 12)
    {
        printf("ERROR: Please use -l for finding the largest number and -s for finding the smallest \n");
        return 0;
    } 
    
    //smallest number argument
    if(strcmp(argv[1],smallest_ch) == 0)
    {
	for (i = 2; i < argc; i++)
        {
            temp = atoi(argv[i]);
            
            if(i == 2)
            {
                smallest = temp;
            }
            else
            {
                if(temp < smallest)
                {
                    smallest = temp;
                }
            }
        }
        printf("The Smallest Number You Entered Is: %d\n",smallest);
    }
    //largest number argument
    else if(strcmp(argv[1],largest_ch) == 0)
    {
	for (i = 2; i < argc; i++)
        {
            temp = atoi(argv[i]);
            
            if(i == 2)
            {
                largest = temp;
            }
            else
            {
                if(temp > largest)
                {
                    largest = temp;
                }
            }
        }
        printf("The Largest Number You Entered Is: %d\n",largest);
    }
    
    else
    {
        printf("ERROR: Please use -l for finding the largest number and -s for finding the smallest\n");
    }

    return (0);
}

