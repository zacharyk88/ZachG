// File: card.h
// Programmer: 
// Class: COP 2931
// Description: This program simulates the checking out and checking in of books from a library

#ifndef CARD_H

#define CARD_H



class Card 
{
private:
	char name[30];
	char phone[15];
	int CardID;
	int BookID;

public:
	Card();
	Card(char n[], char p[], int c);
	void setCardID(int c);
	void setName(char n[]);
	void setPhone(char p[]);
	void setBookID(int b);
	int getBookID();
	int getCardID();
	void print();
	
};

#endif

