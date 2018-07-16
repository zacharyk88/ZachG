/*
	Assignment 13 (second part of Chapter 15, Triggers) 50 points
*/

--This assignment contains Q1 (10 points), Q2 (20 points), and Q3 (20 points), each 
--requires a trigger to be implemented.

--If you use other people's code and make it be your answer, both parties receive
--negative 50 points for this assignment and will be reported to the department and
--college. 

use ClearWater


--> Before solving Q1 and Q2 below, please execute the following IF and SELECT
--  statements to create a fresh copy of Products_copy from the original Products. 
--  You may execute them any time during this assignment when you need a brand new
--  Products_copy to test your triggers.

if object_id('Products_copy') is not null
	drop table Products_copy;

select * into Products_copy from Products;
go

/* Q1. (10 points)
According to the design of Products (and also Products_copy), products may not always 
have a unit price, meaning a product is allowed to have NULL value in its UnitPrice. 
Further, there is no limit what UnitPrice values could be, including a very large value
like $5,000,000.00 or negative values.

Assuming the manager of ClearWater wants to enforce a price range rule that requires
every price to be between $0.50 and $500.00. After a simple analysis, we figure out that
only INSERT and UPDATE operations can possibly violate this rule. If there is no such
price range rule, both operations can be executed with any price values, including NULL.

To implement this kind of business rules, there are generally three approaches:

APPROACH-1: Require the front-end applications, say, the web page or program of any 
			language (e.g., Java, Python, C#, Javascript, Objective-C, Swift, etc.) 
			to validate every user's input of product unit price. Then, all invalid 
			or "bad" prices will never come to the database.
APPROACH-2: Re-design or modify the Products (and Products_copy) table by adding a
			CHECK constraint to the UnitPrice column, which should be an ALTER TABLE
			statement with CHECK (UnitPrice between .05 and 500). Then, the server 
			will take care this constraint whenever a unit price is affected by INSERT
			and UPDATE.
APPROACH-3: Add a trigger in the Products (and Products_copy) table so it is automatically
		    fired by INSERT and UPDATE to ensure they use only price values within the
			range. If they don't, the INSERT or UPDATE will be "rolled back" (i.e., reset.)

Each approach has its consideration and advantage/disadvantage. For learning purpose
of Chapter 15, we choose the 3rd approach, meaning you are required to create an 
AFTER trigger called 'tgr_priceValidation' to implement the manager's new price rule
in Products_copy table. 

Any operation that violates this rule should be aborted by this trigger and receive 
an error 51234 with a message below

	"No product is allowed to have a unit price out of the range between $0.50 and 
	 $500.00." 
	 
(See lecture in "Chapter 15_part (5) AFTER Triggers-1" for a very similar example.)

Note that any action query, i.e., INSERT, DELETE, and UPDATE, can possibly affect more 
than one row of data. For example, if you are inserting 12 new products, each has a 
valid or invalid or null value of unit price. SQL Server trigger is capable of examing 
all 12 prices because it uses the internal "INSERTED" table as you already learned from
the OUTPUT clause, which is introduced in the lectures of Chapter 7. To know what is 
the price before update, we use DELETED table, and to get the price after insert or
update, we use INSERTED table. Invalid values found in INSERTED table should invoke
the ROLLBACK operation to "UNDO" or reset the entire INSERT or UPDATE operation that 
fires the trigger.

Several test cases are provided below for your use to test the trigger. If your trigger 
is implemented correctly, each test case should result the passed or failed output as 
indicated in each case. 

Normally, you are responsible to write these test cases, but they are given here to help 
you test if your trigger is correctly implemented. Also, you must also learn how to 
prepare and write test cases if you are required to make one in a project or a test.
*/

CREATE TRIGGER tgr_priceValidation
	ON Products_copy 
	AFTER UPDATE, INSERT
AS
	IF EXISTS(SELECT *
			FROM INSERTED
			WHERE UnitPrice < 0.50 OR UnitPrice > 500.00)
		THROW 51234, 'No product is allowed to have a unit price out of the range between $0.50 and 
	 $500.00.', 1
--
--insert your code of answer here (about 5 to 10 lines)
--
go



--Test Case 1: INSERT and passed

insert into Products_copy ([ProductID], [ProductName], [UnitPrice], [Discontinued])
  values (301, 'Product 301', NULL, 1),
         (302, 'Product 302', 199.5, 1);

--Test Case 2: INSERT but failed

insert into Products_copy ([ProductID], [ProductName], [UnitPrice], [Discontinued])
  values (303, 'Product 301', 22, 1),
         (304, 'Product 302', 0.25, 1);

--Test Case 3: UPDATEs and passed

update Products_copy
	set [UnitPrice] = NULL
	where [ProductID] <= 3;

update Products_copy
	set [UnitPrice] = 0.5
	where [ProductID] <= 3;

--Test Case 4: UPDATEs but failed

update Products_copy
	set [UnitPrice] = [UnitPrice] - 30
	where [ProductID] <= 15;

update Products_copy
	set [UnitPrice] = -2.99
	where [ProductID] <= 10;



/* Q2. (20 points)
Before solving this problem, execute the IF and SELECT-INTO statements given on top of Q1 
to re-build the Products_copy. Then, either drop the above trigger or ues a DISABLE TRIGGER
statement to disable it so the new trigger below can execute alone without being interfered
and be easily tested.

In this problem, you are required to create an INSTEAD OF trigger called 'tgr_priceValidation_2' 
in Products_copy to perform exactly the same function as tgr_priceValidation does in Q1. 

You can use the same test cases provided in Q1 to test this new trigger.

Solving this problem allows you to learn that many (not all) business rules or constraints 
can be implemented by either type of triggers. However, the idea and logic behind these 
two types of triggers are very different, you need to carefully design them in order to
achieve the desired effects. For example, you can use ROLLBACK statement in an AFTER trigger
to abort the operation that fires the trigger but you don't need ROLLBACK in an INSTEAD OF 
trigger because, when an INSTEAD OF trigger is fired, the firing operation is already 
aborted by the trigger. 

Further, if nothing found necessary to be aborted or rollback, an AFTER trigger may perform
no repairing INSERT, UPDATE, or DELETE. However, when an INSTEAD OF trigger is fired, it must 
execute its own INSERT, UPDATE, or DELETE operations to replace the corresponding but already
aborted operations. 

The INSTEAD OF trigger you are going to implement in Q2 allows you to practice one of such 
cases, meaning, when it finds the triggering INSERT or UPDATE contains an out of range price 
value, it only needs to throw the error, but, very importantly, if the price is valid, it must 
execute its own INSERT or UPDATE to complete the operation because the INSERT or UPDATE that
fires the trigger has already aborted automatically by the INSTEAD OF trigger.

Note that, because tgr_priceValidation_2 of Q2 and tgr_priceValidation of Q1 perform exactly
the same function. In a real production database, only one needs to be included or activated.
*/

create trigger tgr_priceValidation_2
	ON Products_copy 
INSTEAD OF UPDATE, INSERT
AS

	IF EXISTS (SELECT * FROM DELETED)
		UPDATE Products_copy
		SET ProductID  = i.ProductID,
			ProductName = i.ProductName,
			SupplierID = i.SupplierID,
			CategoryID = i.CategoryID,
			QuantityPerUnit = i.QuantityPerUnit,
			UnitPrice = i.UnitPrice,
			UnitsInStock = i.UnitsInStock,
			UnitsOnOrder = i.UnitsOnOrder,
			ReorderLevel = i.ReorderLevel,
			Discontinued = i.Discontinued
		FROM INSERTED i JOIN Products_Copy p
			ON i.ProductID = p.ProductID
		WHERE i.UnitPrice IS NULL OR i.UnitPrice BETWEEN 0.50 AND 500.00
		print 'No product is allowed to have a unit price out of the range between $0.50 and 
	 $500.00.'
	
	
	IF EXISTS (SELECT * FROM INSERTED)
		INSERT INTO Products_copy 
		SELECT *
		FROM INSERTED
		WHERE UnitPrice IS NULL OR UnitPrice BETWEEN 0.50 AND 500.00
		print 'No product is allowed to have a unit price out of the range between $0.50 and 
	 $500.00.'
--
--insert your code of answer here (about 30 or so lines)
--
go

--> Use the same test cases of Q1 to test this trigger.

--> Comparing bothe triggers of Q1 and Q2, we found the first trigger is easier
--  to implement with less number of lines of code.



/* Q3. (20 points)
Before solving this problem, execute the IF and SELECT-INTO statements given below to 
build Suppliers_copy from Suppliers. 

Assuming the manager of ClearWater wants to keep the total number of suppliers between
25 and 29. Currently in the original ClearWater database, the Suppliers table has 29 
suppliers. This means up to four suppliers can be deleted from Suppliers_copy without
failing the rule; otherwise, the DELETE should be rejected. On the other hand, unless 
some suppliers are deleted first, inserting new suppliers into Suppliers_copy should 
be rejected because that makes the total beyond 29.

Your job here is to create a trigger tgr_limitTotalSupplier to support the manager's  
new rule. When the rule is violated, print one of the error messages below, depending
on the firing operation.

'Total suppliers cannot beyond 29. Your INSERT is aborted.'
'Total suppliers cannot below 25. Your DELETE is aborted.'

If the rule is followed, then, print one of the two sets of messages below to acknowledge
the operation.

'M suppliers are inserted successfully.'
'N suppliers are found in Suppliers_copy.'
or
'M suppliers are deleted successfully.'
'N suppliers are found in Suppliers_copy.'

where M is the total rows of suppliers inserted or deleted and N is the total number of
suppliers after the operation.
*/
if object_id('Suppliers_copy') is not null
	drop table Suppliers_copy;

select * into Suppliers_copy from Suppliers;
go

--> Analysis:
--  First, the only operation that increases the total suppliers is INSERT, and the only 
--  operation that decreases the total suppliers is DELETE. UPDATE won't change the total 
--  number of suppliers in the table. 

--  Second, an AFTER trigger should be easier for Q3 than an INSTEAD of trigger. Otherwise,
--  you need to include both INSERT and DELETE statements in the trigger to replace the one
--  that fires but already aborted by the trigger.

--  Third, in this trigger, we need to split the code into two parts to examine if the total 
--  of suppliers is greater than 29 and if it is below 25.

--  Fourth, how do we know the firing operation is INSERT or DELETE? This is simple because
--  if it is INSERT, the DELETED table must contains no rows, and, similarly, if it is DELETE, 
--  the INSERTED table must be empty. We can use a simple COUNT(*) against INSERTED or DELETED
--  to tell which operation fires the trigger.

--  Lastly, a good news is, because Suppliers_copy is created by using SELECT-INTO, the 
--  relationship between Suppliers and Products are not copied into Suppliers_copy. 
--  Otherwise, with this relationship, we won't be able to delete a supplier if it is 
--  referenced by any products and, in this case, we won't be able to test the trigger
--  for one important server behavior: when an operation is executed, constraints of columns
--  or tables or relationships will be checked before triggers are fired. If any constraint
--  fails and errors occur, triggers won't be fired and cannot be tested.

create trigger tgr_limitTotalSupplier
	ON Suppliers_copy 
	AFTER DELETE, INSERT
AS
	DECLARE @SupplierCount int, @InsertedCount int, @DeletedCount int
	
	SET @SupplierCount = (SELECT COUNT(*) FROM Suppliers_copy)
	SET @InsertedCount = (SELECT COUNT(*) FROM INSERTED) 
	SET @DeletedCount = (SELECT COUNT(*) FROM DELETED)
	
	IF EXISTS (SELECT * FROM INSERTED) --insert statement 
	BEGIN
		IF @SupplierCount - @DeletedCount >= 29
		BEGIN
			print 'Total suppliers cannot beyond 29. Your INSERT is aborted.'
			ROLLBACK
		END
		ELSE
		BEGIN
			print CAST(@InsertedCount AS varchar) + ' suppliers are inserted successfully.'
			print CAST(@SupplierCount AS varchar) + ' suppliers are found in Suppliers_copy.'
			END
		END
	IF EXISTS (SELECT * FROM DELETED) --delete statement 
	BEGIN
		IF @SupplierCount + @InsertedCount < 25
		BEGIN
			print 'Total suppliers cannot below 25. Your DELETE is aborted.'
			ROLLBACK
		END
			ELSE
			BEGIN
			print CAST(@DeletedCount AS varchar) + ' suppliers are deleted successfully.'
			print CAST(@SupplierCount AS varchar) + ' suppliers are found in Suppliers_copy.'
		END
	END
	
--insert your code of answer here (about 30 or so lines)
--
go



--Test Case 1: DELETE but failed
delete from Suppliers_copy where SupplierID between 1 and 10; -- 29 - 10 = 19, below 25

--Test Case 2: DELETE and passed
delete from Suppliers_copy where SupplierID between 1 and 4; -- 29 - 4 = 25, not below 25

delete from Suppliers_copy where SupplierID = 22; --> failed because only 25 suppliers left

--Test Case 3: INSERT and passed
insert into Suppliers_copy
  select * from Suppliers where SupplierID between 1 and 3;

--Test Case 4: INSERT but failed
insert into Suppliers_copy
  select * from Suppliers where SupplierID between 11 and 22;


---------------END----------------