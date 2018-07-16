
/* Selected exercises of end of Chapter 4 (p.156-7) */

--Total points obtained:      (leave blank for TA's grading)

--Your name: Zachary Goss

--Write one SELECT statement in the given space beneath each problem description 
--to answer the query. Query 1 requires two SELECT statements.

--Each SELECT statement is worth 10 points with a possible total of 50 points.

--Partial credits is possible, depending on how complete and correct of the statement.

--Each clause of SELECT, FROM, WHERE, and ORDER BY is expected to be coded on its own
--line and each line is left justified.

--Only one SELECT statement is allowed to be the answer of each query. If you include
--more than one statement, they will be all graded and all point deductions are counted.

--DO not change the file name and its extension.

--Please be sure the file you submit is not one with empty answer. Some students make 
--an extra copy of the download file and submit a wrong file for grading.


use AP

/* Q1. This is Exercise #2 of end of Chapter 4 (p.156)
Write a SELECT statement that returns four columns:
VendorName		From the Vendors table
InvoiceNumber	From the Invoices table
InvoiceDate		From the Invoices table
Balance			Derived from the Invoices table, 
				i.e., InvoiceTotal minus the sum of PaymentTotal and CreditTotal

The result set should have one row for each invoice with a non-zero balance. Sort 
the result set by VendorName in ascending order.

Hint: correct query results 11 rows
*/

SELECT VendorName, InvoiceNumber, InvoiceDate, InvoiceTotal - PaymentTotal - CreditTotal AS Balance
FROM Vendors INNER JOIN Invoices
	ON Vendors.VendorID = Invoices.VendorID
WHERE InvoiceTotal - PaymentTotal - CreditTotal > 0
ORDER BY VendorName ASC;




/* Q2. This is Exercise #5 of end of Chapter 4 (p.157)
Write a SELECT statement that returns five columns from three tables, all using 
column aliases:

	Vendor		VendorName column
	Date		InvoiceDate column
	Number		InvoiceNumber column
	#			InvoiceSequence column
	LineItem	InvoiceLineItemAmount column

Assign the following correlation names to the tables:
	v		Vendors table 
	i		Invoices table 
	li		InvoiceLineItems table

Sort the final result set by Vendor, Date, Number, and #.

Hint: correct query results 118 rows
*/

SELECT VendorName AS Vendor, InvoiceDate AS Date, InvoiceNumber AS Number, InvoiceSequence AS #, InvoiceLineItemAmount AS LineItem
FROM Vendors AS v JOIN Invoices AS i
	ON v.VendorID = i.VendorID
JOIN InvoiceLineItems AS li
	ON i.invoiceID = li.invoiceID
ORDER BY Vendor, Date, Number, #;



/* Q3. This is Exercise #6 of end of Chapter 4 (p.157)
Write a SELECT statement that returns three columns: 

	VendorID		From the Vendors table 
	VendorName		From the Vendors table
	Name			A concatenation of VendorContactFName and VendorContactLName, 
					with a space in between 
					
The result set should have one row for each vendor whose contact has the same first name as 
another vendor’s contact. Sort the final result set by Name. 

Hint 1: Use a self-join
Hint 2: correct query results 6 rows
*/

SELECT DISTINCT Vendors1.VendorID, Vendors1.VendorName, Vendors1.VendorContactFName + ' ' + Vendors1.VendorContactLName AS Name
FROM Vendors AS Vendors1 JOIN Vendors AS Vendors2
	ON Vendors1.VendorID != Vendors2.VendorID AND
Vendors1.VendorContactFName = Vendors2.VendorContactFName
ORDER BY Name;





/* Q4. This is Exercise #7 of end of Chapter 4 (p.157)
Write a SELECT statement that returns two columns from the GLAccounts table: AccountNo and 
AccountDescription. The result set should have one row for each account number that has never
been used in InvoiceLineItems. Sort the final result set by AccountNo.

Hint 1: Use an outer join to the InvoiceLineItems table
Hint 2: correct query results 54 rows
*/

SELECT GLAccounts.AccountNo, AccountDescription
FROM GLAccounts LEFT OUTER JOIN InvoiceLineItems
	ON GLAccounts.AccountNo = InvoiceLineItems.AccountNo
WHERE InvoiceLineItems.AccountNo IS NULL
ORDER BY GLAccounts.AccountNo;




/* Q5. This is Exercise #8 of end of Chapter 4 (p.157)
Use the UNION operator to generate a result set consisting of two columns from the Vendors table: 
VendorName and VendorState. If the vendor is in California, the VendorState value should be “CA”; 
otherwise, the VendorState value should be “Outside CA”. Sort the final result set by VendorName.
*/

SELECT VendorName, VendorState
FROM Vendors
WHERE VendorState = 'CA'

UNION

SELECT VendorName, 'Outside CA'
FROM Vendors
WHERE VendorState != 'CA'
ORDER BY VendorName;





-------------------------END-------------------------
