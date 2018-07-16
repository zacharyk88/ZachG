#Author: Zachary Goss
#Purpose: Prints reversed string list of user input
#Big O Notation: O(n) - Linear

def main():
    list2 = ''
    
    list1 = input("Enter a setence to be reversed: ")
    
    for i in range (len(list1), 0, -1):
        list2 += list1[i - 1]

    print(list2)
    
main()
