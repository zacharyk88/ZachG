
#include <stdio.h>

//Zachary Goss 3515 copies inputted array and inserts 0 between each element

void insert0(int n, int a1[], int a2[]);

int main() {
   int input_array[50] = {}; //  When I first wrote the code with a dynamically allocated array length
   int output_array[50] = {0};// I continued to get fragmentation fault 11, no matter what I did
   int i = 0; 
   int array_length = 0;
   int output_array_length = 0; 
   
   printf("Please enter the number of elements : ");
   scanf("%d", &array_length); 
   
   output_array_length = array_length * 2; //ensures the array length for the output is the correct size
   
   printf("Please enter the elements of the array: ");
   for (i = 0; i < array_length; i++) 
    {
      scanf("%d", &input_array[i]);
    } 
 
   insert0(output_array_length, input_array, output_array); //calls insert array to update the output array accordingly
   
   printf("The output array is : ");
   for (i = 0; i < output_array_length; i++)
   {
      printf("%d ", output_array[i]);
   }
 
   return (0);
}

//insertion array that will insert a 0 between every number of the input array into the output array
void insert0(int n, int a1[], int a2[])
{
    
    for (int i = 0; i < n; i++) 
    {
        if(i % 2 == 0) //for loop checks if element number is even, if so it inserts the appropriate element,
          { 
            a2[i] = a1[i / 2];
            
          } //otherwise the number on the output array will remain a 0 as initialized. 
    } 
} 