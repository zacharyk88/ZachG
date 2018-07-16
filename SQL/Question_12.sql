/*
Solve Query 12.1 ~ 12.4 below to answer Question 12 of EXAM 1. (25 points in total)

When finished, save your SQL statements in this file and submit it to Question 12 of 
EXAM 1 to complete the extended part of this exam.

All four queries use the same 'exam1' database as the original Question 10. If you
don't have it or if you like to re-build it, execute the script given below before 
the question and refresh your Databases folder to see 'exam1' database which contains
Student and ProjAssignment tables. 

In 'exam1' database, a project could have multiple students assigned to work and a 
student can participate zero, one, or many projects.
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


/* Common question for Query 12.1 ~ 12.3:

Find students who either are never assigned to a project or have a GPA of 3.5 or lower.
The output must include five columns in the following order:

	1. TotalStudents: the total number of students who meet the above conditions
	2. AverageGPA: the average of the satisfied students
	3. HighestGPA: the highest GPA of the satisfied students
	4. LowestGPA: the lowest GPA of the satisfied students
	5. GPA_difference: the difference of the highest and lowest GPA of the satisfied students
*/

/* Query 12.1 (5 points with NO partial credits, i.e., you receive either 5 or 0 points.)

Write one SELECT statement to solve the above question. This statement must use a table join 
with no subqueries and no set operators. Except the value of 3.5, no other hard coded data 
values are allowed in the statement.

HINT 1: the output contains one row with five columns.
HINT 2: Chapter 3, 4, 5
*/


SELECT COUNT (DISTINCT Student.StuID) AS TotalStudents, 
	AVG(DISTINCT GPA) AS AverageGPA, 
	MAX(DISTINCT GPA) AS HighestGPA, 
	MIN(DISTINCT GPA) AS LowestGPA,
	MAX(DISTINCT GPA) - MIN(DISTINCT GPA) AS GPA_difference
FROM Student LEFT JOIN ProjAssignment
	ON Student.StuID = ProjAssignment.StuID
WHERE ProjAssignment.StuID IS NULL 
	OR Student.GPA <= 3.5;


/* Query 12.2 (5 points with NO partial credits, i.e., you receive either 5 or 0 points.)

Write one SELECT statement to solve the question given on top of Query 12.1. This statement 
must must use a subquery with no joins and no set operators. Except the value of 3.5, no other 
hard coded data values are allowed in the statement.

HINT 1: the output contains one row with five columns.
HINT 2: Chapter 3, 5, 6
*/

SELECT COUNT (DISTINCT Student.StuID) AS TotalStudents, 
	AVG(DISTINCT GPA) AS AverageGPA, 
	MAX(DISTINCT GPA) AS HighestGPA, 
	MIN(DISTINCT GPA) AS LowestGPA,
	MAX(DISTINCT GPA) - MIN(DISTINCT GPA) AS GPA_difference
FROM Student
WHERE StuID NOT IN 
	(SELECT ProjAssignment.StuID
	FROM ProjAssignment JOIN Student
	ON Student.StuID = ProjAssignment.StuID)
	OR Student.GPA <= 3.5;




/* Query 12.3 (5 points with NO partial credits, i.e., you receive either 5 or 0 points.)

Write one SELECT statement to solve the question given on top of Query 12.1. This statement 
must use a set operator and may use table joins or subqueries or both. Except the value of 
3.5, no other hard coded data values are allowed in the statement.

HINT 1: the output contains one row with five columns.
HINT 2: Chapter 3, 4, 5, 6
*/



SELECT COUNT (Student.StuID) AS TotalStudents, 
	AVG(GPA) AS AverageGPA, 
	MAX(GPA) AS HighestGPA, 
	MIN(GPA) AS LowestGPA,
	MAX(GPA) - MIN( GPA) AS GPA_difference
FROM Student LEFT JOIN ProjAssignment
	ON Student.StuID = ProjAssignment.StuID
WHERE ProjAssignment.StuID IS NULL

UNION

SELECT COUNT (Student.StuID) AS TotalStudents, 
	AVG(GPA) AS AverageGPA, 
	MAX(GPA) AS HighestGPA, 
	MIN(GPA) AS LowestGPA,
	MAX(GPA) - MIN(GPA) AS GPA_difference
FROM Student
WHERE GPA <= 3.5



/* Query 12.4 (10 points)
Among students who meet the same conditions as given on top of Query 12.1, who has the second 
smallest StuID value? Write one SELECT statement to display this student's StuID and GPA.

HINT 1: In a set of integers {5, 807, -3, 42}, the smallest is -3 and the second smallest is 5.
HINT 2: OFFSET (a hint only, it's not necessary to use it since there are other ways can be used)
HINT 3: the output contains one row with two columns
*/


SELECT DISTINCT Student.StuID, Student.GPA
FROM Student LEFT JOIN ProjAssignment
	ON Student.StuID = ProjAssignment.StuID
WHERE ProjAssignment.StuID IS NULL 
	OR Student.GPA <= 3.5
ORDER BY StuID
	OFFSET 1 ROWS
	FETCH NEXT 1 ROWS ONLY;


--------------------------------END (for extra credits of EXAM 1)-----------------------------

