"""
File: a4.py
Assignment 4
Zachary Goss

Define a length function.
Define a printStructure function.
Define an insert function.
Test the above functions and the Node class.
"""

from node import Node

def length(head):
    """Returns the number of items in the linked structure
    referred to by head """
    count = 0
    probe = head
    
    while probe is not None:
        count += 1
        probe = probe.next
        
    return count
    
def insert(newItem, head):
    """Inserts newItem at the correct position (ascending order) in
    the linked structure referred to by head.
    Returns a reference to the new structure."""

    newNode = Node(newItem)
    
    if head is None:
        head = newNode
        
    elif head.data < newNode.data:
        probe = head
        while probe.next != None:
            probe = probe.next
            
        probe.next = newNode

    else:
        probe = head
        while probe.next != None:
            probe = probe.next
            
        probe.next = newNode
        
    return head

def printStructure(head):
    """Prints the items in the structure referred to by head."""
    
    while head is not None:
        print(head.data)
        head = head.next
def main():
    """Gets words from the user and inserts in the
    structure referred to by head."""
    
    head = None
    userInput = input('Please enter a word (or just hit enter to end): ')
    while userInput != '':
        head = insert(userInput, head)
        userInput = input('Please enter a word (or just hit enter to end): ')
    print('The structure contains', length(head), 'items:')
    printStructure(head)

if __name__ == "__main__": main()
