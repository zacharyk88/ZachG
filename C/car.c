/*
 * Zachary Goss COP3515 car.c 
 * Scans cars.txt and sorts them by average mpg in ascending order in sorted_cars.txt
*/

#include <stdio.h>
#include <stdlib.h>

struct car {
    char make[30];
    char model[30];
    int year;
    int city_mpg;
    int highway_mpg;
    int average_mpg; 
};

//function prototype for selection sort function to swap order in struct array
void selection_sort(struct car cars[], int n);

int main(void) {
    
    int nextline = 0;
    int counter = 0;
    struct car cars[1000];
    
    FILE* pFile;
    pFile = fopen("cars.txt", "r"); 
    if (pFile == NULL)
    {
        printf ("Error opening file\n"); 
        return 1;
    }
    
    //while loop to fill struct array with information from cars.txt
    while(nextline != EOF)
    {
        nextline = fscanf(pFile, "%s %s %d %d %d \n", cars[counter].make, cars[counter].model, &cars[counter].year, &cars[counter].city_mpg, &cars[counter].highway_mpg);
        cars[counter].average_mpg = (cars[counter].city_mpg + cars[counter].highway_mpg) / 2; //calculates average mpg
        counter++;
    }
    fclose(pFile);
    
    //function call to sort array now that information has been filled
    selection_sort(cars, counter);
    
    FILE* pFile2;
    pFile2 = fopen("sorted_cars.txt", "w"); 
    if (pFile == NULL)
    {
        printf ("Error opening file\n"); 
        return 1;
    }
    
    //for loop used to print newly sorted struct array into sorted_cars.txt
    for (int i = 0; i < 9; i++)
    {
        fprintf(pFile2, "%s %s %d %d %d %d \n", cars[i].make, cars[i].model, cars[i].year, cars[i].city_mpg, cars[i].highway_mpg, cars[i].average_mpg );
    }
    fclose(pFile2);
    return (0);
}

//nested for loop permits sorting array elements in ascending order
void selection_sort(struct car cars[], int n)
{
    struct car temp;
    for(int i = 0; i < n; i++)
    {
        for(int j = i + 1; j < n; j++)
        {
            if(cars[i].average_mpg > cars[j].average_mpg)
                
            {
                temp = cars[i];
                
                cars[i] = cars[j];
                
                cars[j] = temp;
            }
        }
    }
}