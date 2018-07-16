/*
 * Zachary Goss COP3515 remove.c 
 * Takes user inputted string, removes any comments, and outputs that edited string
*/

#include <stdio.h>

void remove_comment(char *s1, char *s2); //function to remove said comments

int read_line(char *str, int n); //function to receive string input with spaces

int main(void) 
{
    char string1[101];
    char string2[101];
    int temp = 0;
    char *s1 = NULL;
    s1 = string1;
    
    char *s2 = NULL;
    s2 = string2;
    
    printf("Input: ");
    temp = read_line(s1, 101);
    //invokes read_line function, assigns to string1 through pointer s1
    
    remove_comment(s1, s2);
    //copies edited string from string1 to string2 with remove_comments function
    
    printf("Output: %s \n", s2);
    //prints out edited string2
    
    return 0;
}

void remove_comment(char *s1, char *s2)
{
    int n = 101;
    char *p;
    for(p = s1; p < s1 + n; p++)
    {
        if(*p == '/')
        {
            return;
        }
        else
        {
            *s2 = *p;
            s2++;
        }
    }
}

int read_line(char *str, int n)
{
     int ch, i = 0; 
     while ((ch = getchar()) != '\n')
     {  if (i < n)
        {  
           *str++ = ch;
           i++;
         }
     }
     *str = '\0';   /* terminates string */
     return i;        /* number of characters stored */

}
