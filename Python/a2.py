#Author: Zachary Goss
#Purpose: Copies any .txt file lines as list elements to be printed off with error checking
def main():
    count = 0
    while True:
        fName = input("enter the input file name please: ")
        try:
            inputFile = open(fName, 'r')
        except:
            print("I cannot open the file",fName,"- Please check the name and try again")
        else:
            break

    for line in inputFile:
        count += 1
    

    print("There are", count,"lines!")
    lines = open(fName).readlines()

    lineNumber = 1
    while lineNumber != 0:
        try:
            lineNumber = int(input("Enter a line number to print (0 to quit): "))
            print (lines[lineNumber])
        except:
            print("Please try again, line number must be between 0 and ",count)

main()
