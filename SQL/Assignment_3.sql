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


USE ClearWater;


/* Query 1. (10 points)
Which products whose ProductName is ended with 't' and has a UnitPrice higher than $30?
Display their ProductID, ProductName, and UnitPrice in the order of UnitPrice from highest
to lowest. Solve this query by writing a SELECT statement with the LIKE operator.

Hint: correct output has 5 products.
*/

SELECT ProductID, ProductName, UnitPrice
FROM Products
WHERE ProductName LIKE '%t' 
	  AND UnitPrice > 30
ORDER BY UnitPrice DESC;



/* Query 2. (10 points)
Solve Query 1 again by writing another SELECT statement that uses LEFT() or RIGHT() 
functions without the LIKE operator. For the output of Query 2, an extra column of
CategoryID is wanted and only products with the smallest CategoryID value are desired. 

Hint 1: different sorting from Query 1
Hint 2: TOP x WITH TIES
Hint 3: correct output has three products
*/

SELECT TOP 1 WITH TIES ProductID, ProductName, UnitPrice, CategoryID 
FROM Products
WHERE  RIGHT(ProductName, 1) = 't' 
      AND UnitPrice > 30
ORDER BY CategoryID ASC;


/* Query 3.
Display SupplierID and Phone of suppliers whose phone number, including area code, 
contains two and only two '0's. For example, supplier 11 should not appear in the 
output because its phone number (010) 9984510 contains three '0's.

Hint 1: correct output has three suppliers.
Hint 2: considering two LIKE operators.
*/

SELECT SupplierID, Phone
FROM Suppliers
WHERE Phone LIKE '_0%0%[1-9]' 
	  OR Phone LIKE '__00%';

/* Query 4.
Find products that satisfy BOTH conditions below:
(a) Its unit price must NOT below $22.
(b) Its category ID is 4 or 7 or 8. If its category ID is 1 or 3, then it must 
    have at least 40 units in stock.

Display their ProductID, UnitPrice, CategoryID, and UnitsInStock. The output should 
be sorted by CategoryID in A -> Z order (i.e., from smallest to largest). For those
with the same CategoryID, the one with the highest UnitPrice should be displayed first.

Hint 1: a compound condition with AND, OR, NOT.
Hint 2: correct output has 16 products.
*/

SELECT ProductID, UnitPrice, CategoryID, UnitsInStock
FROM Products
WHERE CategoryID NOT IN (1, 2, 3, 5, 6) 
	  AND UnitPrice >= 22 
	  OR CategoryID NOT IN (2, 4, 5, 6, 7, 8) 
	  AND UnitPrice >= 22 
	  AND UnitsInStock >= 40
ORDER BY CategoryID, UnitPrice DESC;

/* Query 5.
For products that meet both (a) and (b) conditions of Query 4, if we rank them in Z -> A 
order of ProductID, i.e., from largest to smallest and the one with the largest ProductID 
will be ranked as #1. Based on this rank, find only three of them which are ranked #8, #9, 
#10 and #11. The output should contains same four columns as in Query 4.

Hint: extend ORDER BY with OFFSET.
*/

SELECT ProductID, UnitPrice, CategoryID, UnitsInStock
FROM Products
WHERE CategoryID NOT IN (1, 2, 3, 5, 6) 
	  AND UnitPrice >= 22 
	  OR CategoryID NOT IN (2, 4, 5, 6, 7, 8) 
	  AND UnitPrice >= 22 
	  AND UnitsInStock >= 40
ORDER BY ProductID DESC
	OFFSET 7 ROWS
	FETCH NEXT 4 ROWS ONLY;




----------END----------

