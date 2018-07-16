
#include <stdio.h>

//Zachary Goss 3515 takes 2 array inputs, and an array length, multiplies them, and compares to check if identical

void multi_vec(int v1[],int v2[], int v3[], int n); //function declaration for the multiplying function

int comp_vec(int v1[], int v2[], int n); //function declaration for comparing the arrays

int main() 
{
   int vector1[50] = {}; //  When I first wrote the code with a dynamically allocated array length
   int vector2[50] = {};// I continued to get fragmentation fault 11, no matter what I did
   int vector3[50] = {0};
   int compare = 2;
   int i = 0;
   int array_length = 0;
   
   printf("Please enter the length of the vectors: ");
   scanf("%d", &array_length);
   
   printf("Please enter the elements of the first vector: ");
   for (i = 0; i < array_length; i++) 
    {
      scanf("%d", &vector1[i]);
    } 
   
   printf("Please enter the elements of the second vector: ");
   for (i = 0; i < array_length; i++) 
    {
      scanf("%d", &vector2[i]);
    } 
   
   multi_vec(vector1, vector2, vector3, array_length); //function call for multiplication function
   
   compare = comp_vec(vector1, vector2, array_length); //function call for comparative function
   
   printf("The multiplication of the vectors is : ");
   for (i = 0; i < array_length; i++)
   {
      printf("%d ", vector3[i]);
   }
   
   printf("\n");
      
   if(compare == 1)
   {
       printf("The vectors are identical");
   }
   else
   {
       printf("The vectors are not identical");
   }
    return 0;
}

void multi_vec(int v1[],int v2[], int v3[], int n) //function that multiplies each element in the two arrays
{                                                  //and stores it into a third array of equal size
    for(int i = 0; i < n; i++)
    {
        v3[i] = v1[i] * v2[i];
    }
}

int comp_vec(int v1[], int v2[], int n) //function to compare the two vector, returns a 1 if identical, 0 if otherwise
{
    int i = 0;
    int counter = 0;
    for(i = 0; i < n; i++)
    {
        if(v1[i] == v2[i])
        {
            counter += 0;
        }
        else
        {
            counter += 1;;
        }
    }
    
    if(counter == 0)
    {
        return 1;
    }
    else
    {
        return 0;
    }
}

