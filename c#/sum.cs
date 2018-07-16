using System;

class CNT4704Lab
{
  public static void Main(string[] myInput)
  {
     int i, sum = 0;
     Console.WriteLine("\nYou entered " + myInput.Length + " numbers:");
     //
     // Problem (1) Fix next line to complete the header of making a for loop......
     //
     for (i = 0; i < myInput.Length; i++) 
     {
	Console.Write(myInput[i] + "  ");
 	sum = sum + Int32.Parse(myInput[i]);
     }
     //
     // Problem (2) Fix next line so the actual sum is displayed......
     //
     Console.WriteLine("\n\nSum of your input numbers = {0}", sum);
     Console.WriteLine("\nGood Bye!");
  }
}