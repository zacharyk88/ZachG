--Total points obtained:      (leave blank for TA's grading)

--Your name: Zachary Goss

--50 points in total

--Partial credits is possible, depending on how complete and correct of your statement.

--Do not include statements other than the one(s) to be graded.

--Do not change the file name and its extension.

--Note:
--Statements executed in this assignment will modify table contents. Whenever you need
--a fresh copy of the original [MyGuitarShop] database, you can open the script named 
--CreateMyGuitarShop.sql that’s provided in previous assignment. Then, run this script
--without selecting any particular lines. That should restore the data in the database.


use [MyGuitarShop]

/* Query 1.  (10 points)
Write an INSERT statement with an OUTPUT clause to add a new row to the Categories 
table in MyGuitarShop database. The OUTPUT clause must display the new inserted values
of both columns of Categories. The CategoryName of this new row is 'Brass'. Your
INSERT statement should not insert a value into the CategoryID column because this
column is an IDENTITY column, meaning its values are generated automatically by
the server.
Hint: see lecture video about how to add an OUTPUT clause to meet the above requirement.
*/

INSERT INTO Categories (CategoryName)
OUTPUT INSERTED.*
VALUES('Brass');




/* Query 2.  (10 points)
Once Query 1 is done, write an UPDATE statement with an OUTPUT clause to modify rows 
of Categories table. This statement should change the CategoryName value by appending 
"***" to its end if the CategoryName value begins with a letter 'B'. The OUTPUT clause 
must display three columns: CategoryID column, 'Old_CategoryName' column for the 
CategoryName value before update, and 'New_CategoryName' column for the CategoryName 
value after update.
*/


UPDATE Categories
SET CategoryName = CategoryName + '***'
OUTPUT INSERTED.CategoryID, DELETED.CategoryName AS 'Old_CategoryName', INSERTED.CategoryName AS 'New_CategoryName'
WHERE LEFT(CategoryName, 1) = 'B';


/* Query 3.  (30 points)
Once Query 2 is done, write a DELETE statement to delete rows of Categories table 
if their CategoryName value ends with '***'. 

When you execute this statement, it will produce an error since these categories to
be deleted have related rows in the Products table. You may open or create a database
diagram to easily see how these tables are related. To fix that, precede the DELETE 
statement with another DELETE statement that deletes all products in these categories.
Hint: use a subquery in the WHERE clause of the DELETE statement.

Again, when you execute this new statement to delete products that are related to 
the above categories, you get another error since these products have related rows
in OrderItems table. Using the same approach, precede the above DELETE statement with 
another new DELETE statement that deletes all order items related to the products that
belong to categories whose CategoryName value ends with '***'.
Hint: this DELETE statement requires a subquery nested in another subquery.

Include an OUTPUT clause in all three DELETE statements, each must display all columns 
of the rows that are deleted.

Correct answer of this query should contain three DELETE statements in the following
order. The first one contains two levels of subqueries to delete rows from OrderItems 
table. The second one contains only one level of subquery to delete rows from Products 
table. And, the third DELETE statement deletes rows of Categories table with no subquery.
*/
DELETE OrderItems
OUTPUT DELETED.*
WHERE ProductID IN 
	(SELECT ProductID
	FROM Products
	WHERE CategoryID IN
		(SELECT CategoryID
		FROM Categories
		WHERE RIGHT(CategoryName, 3) = '***'));


DELETE Products
OUTPUT DELETED.*
WHERE  CategoryID IN
	(SELECT CategoryID
	FROM Categories
	WHERE RIGHT(CategoryName, 3) = '***');

DELETE Categories
OUTPUT DELETED.*
WHERE RIGHT(CategoryName, 3) = '***';





--------------------------------END--------------------------------