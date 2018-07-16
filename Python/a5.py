"""
File: a5.py
Zachary Goss
Determines if user-entered String is a palindrome via Stack Class
"""

from stack import Stack

def isPalindrome(sentence):          
    """Returns True if sentence is a palindrome
    or False otherwise."""
    stk = Stack() # Creates a stack called stk.
    
    # *** Write your code here ***
    i = 0
    length = len(sentence)

    for i in range(length):
        if sentence[i] != ' ':
            stk.push(sentence[i])
        
    sentence = sentence.replace(' ', '')
    
    j = 0
    for j in range(stk.size()):
        if stk.pop() != sentence[j]:
            return False
    
    return True
    
# *** Do not modify main() ***
def main():
    while True:
        sentence = input("Enter some text or just hit Enter to quit: ")
        if sentence == "":
            break
        elif isPalindrome(sentence):
            print("It's a palindrome.")
        else:
            print("It's not a palindrome.")

main()
