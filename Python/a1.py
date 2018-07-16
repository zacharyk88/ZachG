"""Author: Zachary Goss
   Plays a guess the number game with user """

import random

def main():

    limitLow = int (input("Enter the smaller number in the range: "))
    limitHigh = int (input("Enter the larger number in the range: "))

    print("Now think of a number between ",limitLow, " and ",limitHigh)
    
    myNumber = (limitHigh - limitLow) // 2 + 1

    answer = '.'
    
    count = 1
    while answer != "=":
       
        answer = input ("Is your number %d? \nEnter =, <, or >: " % myNumber)
        count += 1
        if answer == "<":
            limitHigh = myNumber
            myNumber = ((limitHigh - limitLow) // 2) + limitLow + 1
            print("Hmm I know your number is between ",limitLow, " and  ", limitHigh)
        elif answer == ">":
            limitLow = myNumber
            print("Hmm I know your number is between ",limitLow, " and ", limitHigh)
            myNumber = ((limitHigh - limitLow) // 2) + limitLow + 1
        else:
            print("Hooray! I got it in ", count, "attempts!")
            break
    
if __name__ == "__main__":
    main()
