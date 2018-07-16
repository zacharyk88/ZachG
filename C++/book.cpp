//Book.cpp
//

#include <iostream>
#include "Book.h"
using namespace std;

Book::Book()
{
	BookID = 0;
	CardID = 0;
	CheckedOut = false;
}

Book::Book(int b, char t[], char a[])
{
	char Author [25];
	BookID = b;
	CardID = 0;
	CheckedOut = false;
	strcpy_s(Title, t);
	strcpy_s(Author, a);
}

void Book::setTitle(char t[])
{
	strcpy(Title, t);
}

void Book::setAuthor(char a[])
{
	char Author [25];
	strcpy(Author, a);
}

bool Book::isCheckedOut()
{
	if(CardID == 0)
	{
		CheckedOut = false;
	}
	else
	{
		CheckedOut = true;
	}
	return CheckedOut;
	
}

void Book::setCheckedOut(int c)
{

}

int Book::getCardID()
{

}

void Book::SetCardID(int c)
{

}

void Book::printBook()
{
	char Author [25];
	cout << BookID << "  " 
		 << Title << "  "
		 << Author << "  "
		 << (CheckedOut ? "Checked Out  " : "On Shelf  ")
		 << CardID << endl;
}
void Book::SetCardID(int c)
{
	int CardID = c;
}
