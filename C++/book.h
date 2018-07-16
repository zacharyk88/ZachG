// File: book.h
// Programmer: 
// Class: COP 2931
// Description: This program simulates the checking out and checking in of books from a library

#ifndef BOOK_H
#define BOOK_H


#include <iostream>
#include <iomanip>

class Book 
{
private:
	int BookID;
	char Title[30];
	char AUthor[25];
	bool CheckedOut;
	int CardID;
	
public:
	Book();
	Book(int b, char t[], char a[]);
	bool isCheckedOut();
	void printBook();
	void SetCardID(int c);
	int getCardID();
	void setCheckedOut(int c);
	void setBookID(int b);
	void setTitle(char t[]);
	void setAuthor(char a[]);
};
#endif