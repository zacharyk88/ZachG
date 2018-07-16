// File: Library.cpp

// Programmer: Zachary Goss

// Class: COP 2931
   Project 3
// Description: This program simulates the checking out and checking in of books from a library


#include <iostream>
#include <iomanip>
#include <fstream>
#include "Card.h"
#include "Book.h"
using namespace std;

void showMenu();
int findLibraryCard(int card, cards[]); //test
int findBook(int book, books[]); //test
int main() 
{

	
	// declare an array of 20 cards
	Card cards[20];
	int numCards = 0;
	int numBooks = 0;
	int i = 0;
	int command;
	// declare an array of 20 books
	Book books[20];

	// declare a file pointer and open the cards file 
	ifstream cardInput("cards.txt"); //annoucement
	if (!cardInput)
	{
		cout << "ERROR: Cannot open file cards.txt." << endl;
		system("pause");
		exit(1); //sends error message to OS to cancel the program
	}
	cout << "File opened.  Reading cards.txt..." << endl;

	// read the next line from the file
	char name[30];
	char phone[15];
	int cardID;
	char junk[5]; //you need this

	cardInput.getline(name, 30,','); //reads name up to 30 characters or when it finds a comma

	while(cardInput)
	{
		cardInput.getline(junk, 5, ' '); //to skip the space
		//cardInput.getline(name, 30, ','
		cardInput.getline(phone, 15, ',');
		cardInput.getline(junk, 5, ' '); //to skip the space
		cardInput >> cardID; //works just like cin
		cardInput.getline(junk, 5, '\n');

		//update the next empty card
		cards[i].setName(name);
		cards[i].setPhone(phone);
		cards[i].setCardID(cardID);
		numCards++;
		i++;
		cardInput.getline(name, 30,',');
	}




	// declare a file pointer and open the books file 
	
	//skip false and 0 in the while loop
	ifstream bookInput("books.txt"); //annoucement
	if (!bookInput)
	{
		cout << "ERROR: Cannot open file book.txt." << endl;
		system("pause");
		exit(1); //sends error message to OS to cancel the program
	}
	cout << "File opened.  Reading books.txt..." << endl;

	// read the next line from the file
	char title[30];
	char author[15];
	int  bookID;
	char junk[5]; //you need this

	cardInput.getline(name, 30,','); //reads name up to 30 characters or when it finds a comma

	while(cardInput)
	{
		cardInput.getline(junk, 5, ' '); //to skip the space
		cardInput.getline(author, 15, ',');
		cardInput.getline(junk, 5, ' '); //to skip the space
		cardInput >> bookID; //works just like cin
		cardInput.getline(junk, 5, '\n');

		//update the next empty card
		cards[i].setName(name);
		cards[i].setPhone(phone);
		cards[i].setCardID(cardID);
		numBooks++;
		i++;
		cardInput.getline(name, 30,',');
	}
	
	// display main menu
	ShowMenu();
	cout << "Enter a command: ";
	cin >> command;
	while(command != 0)
	{
		switch(command)
		{
		case 1: //print all cards
			for (i = 0; i < numCards; i++)
			{
				cards[i].print();
			}
			break;
		case 2: //print books
			for (i = 0; i < numBooks; i++)
			{
				books[i].print();
			}
			break;
		case 3: //check out book
			 cout << "Enter a Card ID: ";
                cin >> cardID;
                // Search cards[] for ID
                i = 0;
                while (i < numCards && cardID != cards[i].getCardID())
                {
                    i++;
                }
                // If NOT found, Error and stop
                if (i == numCards)
                {
                    cout << "ERROR: Card Not Found. " << endl;
                }
                else
                {
                
                // if have a book, error and stop
                    if (cards[i].getBookID() != 0)
                    {
                        cout << "ERROR: Already have a book checked out." << endl;
                    }
                    else
                    {
                
                        // Ask for bookID
                        cout << "Enter the BookID: ";
                        cin >> bookID;
                
                // Search books[] for ID
                      int j = 0;
                        
                        while (j < numBooks && bookID != books[j].getBookID())
                        {
                            j++;
                        }
                
                // if NOT found. error and stop
                        // If NOT found, Error and stop
                        if (j == numBooks)
                        {
                            cout << "ERROR: Book Not Found." << endl;
                        }
                        else
                        {
                            
                            // if have a book, error and stop
                            if (books[j].isCheckedOut())
                            {
                                cout << "ERROR: Book checked out." << endl;
                            }
                            else
                            {
                
                // check out the book
                                cards[i].setBookID(BookID);
                                
                                books[j].setCardID(CardID);
                            }
                        }
                    }
                }
                break;
                
		case 4: //check in book
			cout << "Enter a Card ID: ";
                cin >> CardID;
                // Search cards[] for ID
                i = findLibraryCard(CardID);
				// If NOT found, Error and stop
               if(i >= 0)
               {
                // Ask for bookID
                cout << "Enter the BookID: ";
                cin >> BookID;
                
                
                j = findBook(BookID);
                   
                   if(j >= 0 && !books[j].isCheckedOut())
                   {
                       // check out the book
                       Cards[i].setBookID(0);
                       Books[j].setCardID(0);
                   }
                break;

		case 5: //create card
			cout << "Enter your name with an underscore instead of space: ";
			cin >> name; //John_Gorp
			cout << "Enter your phone number: ";
			cin >> phone; //use 999-999-9999 format
			cout << "Enter a Card ID: ";
			cin >> cardID;
			cards[numCards].setName(name);
			cards[numCards].setPhone(phone);
			cards[numCards].setCardID(cardID);
			numCards++;
			break;
		default:
			cout << "ERROR: Menu options must be between 0 and 5" << endl;
		}
	
		ShowMenu();
	cout << "Enter a command: ";
	cin >> command;
	}


}


void ShowMenu()
{
	cout << endl << endl;
    cout << "    [ M a i n   M e n u]      " << endl;
    cout << "============================= " << endl;
    cout << " 1. Show all Library Cards    " << endl;
    cout << " 2. Show all Books            " << endl;
    cout << " 3. Check Out a Book          " << endl;
    cout << " 4. Check In a Book           " << endl;
    cout << " 5. Create a New Library Card " << endl;
    cout << " 0. Exit The System           " << endl << endl;

}

int findLibraryCard(int card, cards[])
{    
    // Search cards array for ID
    int i = 0;
    
    while (i < numCards && cardID != cards[i].getCardID())
    {
        i++;
    }
    // If NOT found, Error and stop
    if (i == numCards)
    {
        cout << "ERROR: Card Not Found. Go to create card ID to make one. " << endl;
        return -1;
    }
    else
    {
        return i;
    }
}

int findBook(int book, books[])
{
	    int f = 0;
    
    // Search books[] for ID
    
    while (f < numBooks && bookID != books[j].getBookID())
    {
        f++;
    }
    
    // if NOT found. error and stop
    // If NOT found, Error and stop
    if (f == numBooks)
    {
        cout << "ERROR: Book Not Found." << endl;
        
        return -1;
    }
    else
    {
        return f;
    }
}
