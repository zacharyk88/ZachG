/*
Solve Query 10.1 ~ 10.4 below to answer Question 10 of EXAM 1.

When finished, save your SQL statements in this file and submit it to 
Question 10 of EXAM 1 to complete the exam.

All four queries use a database 'exam1', which can be built by executing
the script below. Please highlight (ie., select) the block of lines between
'use master;' and the line before Query 10.1. Then, execute the block of 
lines together and refresh Databases folder to see 'exam1' database with 
Student and ProjAssignment tables. In this database, a project could have 
multiple students assigned to work and a student can participate more than 
one project.
*/
use master;
go
if  DB_ID('exam1') IS NOT NULL
    drop database exam1;
go
create database exam1;
go
use exam1
create table Student
(StuID char(3) primary key,
 GPA decimal(3, 2));
insert into Student 
  values ('s1', 3.66), ('s2', 2.87), ('s3', 2.91), ('s4', 4), ('s5', 3.5); 
create table ProjAssignment
(Pno char(3),
 StuID char(3),
 constraint pk_PA primary key (Pno, StuID),
 constraint fk_1 foreign key (StuID) references Student(StuID));
insert into ProjAssignment 
  values ('p1', 's5'), ('p1', 's2'), ('p1', 's1'), ('p2', 's2'), 
         ('p3', 's1'), ('p4', 's1'), ('p5', 's2'), ('p5', 's5');


/* Query 10.1 (5 points)
Re-write the following SELECT statement by using a non-correlated 
(ie., regular) subquery. No hard coded data values are allowed in 
your statement.

		select StuID
		from Student
		where not exists (select Pno from ProjAssignment 
						  where StuID = Student.StuID);

*/

SELECT StuID
FROM Student
WHERE StuID NOT IN 
	(SELECT ProjAssignment.StuID
	FROM ProjAssignment JOIN Student
	ON Student.StuID = ProjAssignment.StuID);



/* Query 10.2 (5 points)
Re-write the SELECT statement given in Query 10.1 by using a table join. 
No hard coded data values are allowed in your statement.
Hint: left or right outer join
*/

SELECT Student.StuID
FROM Student LEFT JOIN ProjAssignment
ON Student.StuID = ProjAssignment.StuID
WHERE ProjAssignment.StuID IS NULL;


/* Query 10.3 (5 points)
Re-write the SELECT statement given in Query 10.1 by using a set operator.
No hard coded data values are allowed in your statement.
*/

SELECT StuID
FROM Student

EXCEPT

SELECT StuID
FROM ProjAssignment;



/* Query 10.4 (25 points)
What's the average GPA of students who are assigned to a project with 
the most students? Write a SELECT statement to answer it without including
hard coded data values in the statement.
Hint: GROUP BY, ORDER BY, TOP, subquery, join, AVG()
*/

SELECT AVG(GPA) AS AvgGpaForProjectWithMostStudents
FROM 
	(SELECT DISTINCT GPA
	FROM Student JOIN ProjAssignment
	ON Student.StuID = ProjAssignment.StuID
	AND Student.StuID IN
		(SELECT DISTINCT TOP 3 StuID
		FROM ProjAssignment
		GROUP BY pno, StuID
		ORDER BY StuID)) as subtable;
	



----------------------END----------------------