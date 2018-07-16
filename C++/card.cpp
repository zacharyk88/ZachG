#include <iostream>
#include "Card.h"
using namespace std;

Card::Card()
{
	BookID = 0;
	CardID = 0;
}

Card::Card(char n[], char p[], int c)
{
	CardID = 0;
	strcpy_s(name, n);
	strcpy_s(phone, p);
}

void Card::setCardID(int c)
{
	CardID = c;
}

Card::setName(char n[])
{
	char name[];
	strcpy(name, n);
}

void Card::setPhone(char p[])
{
	char phone[];
	strcpy(phone, p);
}

void Card::setBookID(int b)
{
	BookID = b;
}

int Card::getBookID()
{

}

void Card::print()
{
	cout << CardID << "  ";
		 << name << "  ";
		 << phone << "  ";
		 << BookID << endl;
}
