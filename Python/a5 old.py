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
    sentence.replace(" ", "")
    sentencelist = list(sentence)

    for i in range(len(sentencelist)):
        stk.push(sentencelist[i])

    sentencelist.reverse()
    
    while stk.size() != 0:
        if stk.pop() != sentencelist[i]:
            return False
        else:
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
