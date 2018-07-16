'TOTAL OBTAINED = 42/44 POINTS'

/*		
	Assignment for Chapter 17 (44 points)

	Write one or two statements to answer each question from Q1 to Q10 below. 

	4 points each question except Q8, which requires an addition description for extra 4 points 
	to answer a 'Yes/No' and 'Why' question.
*/


/* Q1.
As an administrator of your SQL Server, write a DDL statement to create a new SQL Server login
called 'shark' with a password 'Mid-Atlantic'. Do not enforce the Windows password policies on
this login.
*/

CREATE LOGIN shark
	WITH PASSWORD = 'Mid-Atlantic', check_policy = OFF;

'--------> CORRECT'

/* Q2.
Do a little research to find what GRANT statement needs to execute if we allow the above 'shark' 
login to create another login called 'bluewhale' with a password 'All-oceans'.
*/

GRANT ALTER ANY LOGIN to shark;

'--------> CORRECT'


EXECUTE AS LOGIN = 'shark';

CREATE LOGIN bluewhale
	WITH PASSWORD = 'All-oceans', check_policy = OFF;


/* Q3.
Assuming a user is already connected to a SQL Server using a login named 'Anna', what 
statement does this user need to execute in order to switch the execution context from 
'user1' to another, say, 'Jack', in order to run scripts or statements based on 'Jack'?
What statement is needed to switch the execution context back to 'Anna'?
*/

--To switch the execution context from login 'Anna' to another login 'Jack':

EXECUTE AS LOGIN = 'Jack';


--To switch the execution context from 'Jack' back to 'Anna':

REVERT

'--------> CORRECT'

/* Q4.
Assuming the login 'Anna' was already created in your server but it has no permissions
yet to use the Clearwater database. What statement will you execute to make 'Anna' be
a user named 'assistant' of Clearwater in your server?

*Do not forget to set first the database context to Clearwater by a USE statement. If
 you forget, this new user 'assistant' will be added to the current database you are in.
*/

USE ClearWater

CREATE USER assistant for login Anna;

'--------> CORRECT'


/* Q5.
Assuming the login 'Anna' is the user 'assistant' of the Clearwater database in your server,
write one GRANT statement to perform two tasks: (1) allow this user to create new tables in 
Clearwater, and (2) allow this user to grant the same permission (i.e., creating new tables 
in Clearwater) to other users.
*/
USE ClearWater

GRANT CREATE TABLE to assistant WITH GRANT OPTION;

'--------> CORRECT'


/* Q6.
Assuming the login 'Anna' is the user 'assistant' of the Clearwater database in your server,
write a statement to make this user a member of 'db_datareader' database role of ClearWater. 
*/
USE Clearwater 

ALTER ROLE db_datareader ADD MEMBER assistant;

'--------> CORRECT'


/* Q7.
Assuming the login 'Anna' is the user 'assistant' of the Clearwater database in your server,
write a statement to allow this user to update UnitPrice and UnitsInStock values of Products 
table. 
*/
USE ClearWater

GRANT UPDATE (UnitPrice, UnitsInStock) on Products to assistant;

'--------> CORRECT'



/* Q8. (8 points)
Assuming the login 'Anna' is the user 'assistant' of the Clearwater database in your server,
write a REVOKE statement to disallow this user to read the Address and Phone values of Suppliers. 

After the above REVOKE statement is executed, is user 'assistant' still able to read the Address 
and Phone values of Suppliers? Why?

If REVOKE statement does not work for this purpose, what statement should be used?  Hint: p.562-3
*/

--(2 points) the REVOKE statement: 
USE ClearWater

REVOKE SELECT (Address, Phone) on Suppliers to assistant;

'--------> CORRECT'


--(4 points) Can 'assistant' still read Address and Phone of Suppliers after the REVOKE is done? Why?

/* yes assistant can stil lread the Adress and Phone of Suppliers after the REVOKE because 
they are still in a role that has the permission to view those columns of the Suppliers table.
A DENY statement to deny that role the ability to see the Address or Phone of the Suppliers would fix this */

'--------> CORRECT'

--(2 points) What statement other than REVOKE is needed?
USE ClearWater

DENY SELECT (Address, Phone) on Suppliers to assistant;

'--------> CORRECT'


/* Q9.
Assuming you are currently working on a query editing page or session of Clearwater database 
in your SQL Server using your own login, what statement do you need to execute in order to 
switch the execution context from yours to the 'assistant' user, that is, pretending you are
the 'assistant' user of Clearwater? What statement is needed to switch the execution context 
back to your own?
*/

--To switch the execution context from yours to the 'assistant' user:
EXECUTE AS USER = 'assistant' 


--To switch the execution context from the 'assistant' user back to your own:
REVERT

'--------> CORRECT'


/* Q10.
In Q5, you have granted the 'assistant' user a permission of CREATE TABLE in the Clearwater 
database and also allowed this user to grant the same permission to other users of this
database. A big concern and risk of doing so is the 'assistant' user and everyone who was
granted this permission can keep granting to more and more other users, which may become out
of your expectation eventually. 

To stop and prevent the 'assistant' user and all who were granted such permission from granting
to even more other users, what statement will you execute?
*/
USE ClearWater 

REVOKE CREATE TABLE to assistant CASCADE;

'--------> (-2) Must be REVOKE GRANT OPTION for CREATE TABLE instead of REVOKE CREATE TABLE.'


-----------------END-----------------


