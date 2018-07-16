/*
 * Zachary Goss COP3515 Insert2.c 
 * inserts zero between each inputted array element 
 * Reiterated to use pointer arithmetic rather than subscripting arrays in function
*/
#include <stdio.h>

//reiterated function to use pointer arithmetic rather than subscripting to fill second array
void insert0(int n, int *a1, int *a2);

int main(void) 
{   
  int i;
  int N;
  printf("Please enter the length of the input array: ");
  scanf("%d", &N);
    
  int a[N];
  int b[2*N];
  int *a1 = NULL;
  int *a2 = NULL;
  
  printf("Enter %d numbers for the array: ", N);
  for (i = 0; i < N; i++)
  {
      scanf("%d", &a[i]);
  }
  
  a1 = &a[0];
  a2 = &b[0];
  
  insert0(N, a1,  a2);
  
  printf("Output array:");
  for (i = 0; i < 2*N; i++) 
  {
      printf(" %d", b[i]); 
  } 
  printf("\n");
  return 0;
}
void insert0(int n, int *a1, int *a2) 
{
    int *j = NULL; 
    j = a2;
    j += n;
    for(a2 = a2; a2 < j; a2++)
        {    
            *a2 = *a1;
            a2++;
            a1++;
            *a2 = 0; 
        }
}   
     
