//  Retail_Assistant.cpp
//  Retail Sales Assistant Program
//  Programmer: Zachary Goss
//  Date: 
//  Description:  This program calculates sales tax for a series of products.

#include <iostream>
#include <cmath>
#include <iomanip>
using namespace std;

int main()
{
	double cashDrawer = 500.00;
	int productID = 0;
       int quantity = 0;
	double price = 0.0;
	double subtotal = 0.0;
	double salesTax = 0.0;
	int anotherSale = 1;
	double productCost = 0;
	double total = 0.0;

	// Loop for repeat sales
	while (anotherSale != 0)
	{
		price = 0.0;
		subtotal = 0.0;
		salesTax = 0.0;
		productID = 0;
		total = 0;

		//soft reset all the variables except cashDrawer, to ensure loop runs through again

		cout << "Hello and welcome to Circle C++" << endl;

		// Main loop for each sale
		while (productID != -1)
	{
		//something to reset the values here!
		// Enter the first Product ID for the first sale (-1 to exit)
		cout << "Please enter the Product ID for the item you wish to purchase(-1 to quit): " << endl;
		cin >> productID;

		if (productID != -1)
		{
	// Switch statement to determine the price, and calculate sales tax, if any, for the item.
		switch (productID)
		{
		case 101: 
			cout << "How many of this would you like? " <<endl;
			cin >> quantity;
			price = 65.00;
			salesTax = salesTax + ((quantity * price) * 0.075);
			productCost = quantity * price;
			subtotal = subtotal + productCost;
			// calculates the price, sales tax, total cost for that one item and adds it to subtotal
			break;

		// Get next Product ID
		cout << "Please enter the next Product ID (-1 to finalize transaction): " << endl;
		cin >> productID;

		case 102:
			cout << "How many of this would you like? " <<endl;
			cin >> quantity;
			price = 12.50;
			productCost = quantity * price;
			subtotal = subtotal + productCost;
			break;

		cout << "Please enter the next Product ID (-1 to finalize transaction): " << endl;
		cin >> productID;

		case 103:
			cout << "How many of this would you like? " <<endl;
			cin >> quantity;
			price = 24.50;
			productCost = quantity * price;
			subtotal = subtotal + productCost;
			break;

		cout << "Please enter the next Product ID (-1 to finalize transaction): " << endl;
		cin >> productID;

		case 104:
			cout << "How many of this would you like? " <<endl;
			cin >> quantity;
			price = 38.75;
			salesTax = salesTax + ((quantity * price) * 0.075);
			productCost = quantity * price;
			subtotal = subtotal + productCost;
			break;

		cout << "Please enter the next Product ID (-1 to finalize transaction): " << endl;
		cin >> productID;

		case 105:
			cout << "How many of this would you like? " <<endl;
			cin >> quantity;
			price = 17.80;
			salesTax = salesTax + ((quantity * price) * 0.075);
			productCost = quantity * price;
			subtotal = subtotal + productCost;
			break;

		cout << "Please enter the next Product ID (-1 to finalize transaction): " << endl;
		cin >> productID;

		case 106:
			cout << "How many of this would you like? " <<endl;
			cin >> quantity;
			price = 16.50;
			productCost = quantity * price;
			subtotal = subtotal + productCost;
			break;

		cout << "Please enter the next Product ID (-1 to finalize transaction): " << endl;
		cin >> productID;

		case 107:
			cout << "How many of this would you like? " <<endl;
			cin >> quantity;
			price = 42.85;
			salesTax = salesTax + ((quantity * price) * 0.075);
			productCost = quantity * price;
			subtotal = subtotal + productCost;
			break;

		cout << "Please enter the next Product ID (-1 to finalize transaction): " << endl;
		cin >> productID;

		case 108:
			cout << "How many of this would you like? " <<endl;
			cin >> quantity;
			price = 32.99;
			salesTax = salesTax + ((quantity * price) * 0.075);
			productCost = quantity * price;
			subtotal = subtotal + productCost;
			break;

		cout << "Please enter the next Product ID (-1 to finalize transaction): " << endl;
		cin >> productID;

		case 109:
			cout << "How many of this would you like? " <<endl;
			cin >> quantity;
			price = 28.75;
			salesTax = salesTax + ((quantity * price) * 0.075);
			productCost = quantity * price;
			subtotal = subtotal + productCost;
			break;

		cout << "Please enter the next Product ID (-1 to finalize transaction): " << endl;
		cin >> productID;

		case 110:
			cout << "How many of this would you like? " <<endl;
			cin >> quantity;
			price = 51.55;
			productCost = quantity * price;
			subtotal = subtotal + productCost;
			break;

		cout << "Please enter the next Product ID (-1 to finalize transaction): " << endl;
		cin >> productID;
		
		default:
			cout << "ERROR please input an item number between 101 and 110 " << endl;
			cin >> productID;
	}
	}
}
	total = subtotal + salesTax;
	cashDrawer = cashDrawer + total;

	// Print properly formatted output for each sale
	cout << "Subtotal: $" << setw(11) << fixed << setprecision(2) << subtotal << endl;
	cout << "     Tax: $" << setw(11) << fixed << setprecision(2) << salesTax << endl;
	cout << "   Total: $" << setw(11) << fixed << setprecision(2) << total << endl << endl;


      // Another sale?
	cout << "Do you want another sale? (1 - YES, 0 - NO) " << endl;
	cin >> anotherSale;

	}
	cout << "thank you for shopping at Circle C++ !" << endl;

	// Display how much is in the cash drawer at the end
	cout << "The cash register contains: $" << setprecision(2) << cashDrawer << endl;

	system("pause");
}
