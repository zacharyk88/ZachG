USE Bookstore;

SELECT ISBN, Title, Subject_Code
FROM Book
WHERE Subject_Code IN
	(SELECT Subject_Code
    FROM Book
    WHERE Title = 'The Art of Walt Disney')
ORDER BY Title ASC;


SELECT ISBN, Title, Subject_Code
FROM Book JOIN Subject
ON Book.Subject_Code = Subject.SubjectCode
WHERE Subject_Code IN
	(SELECT Subject_Code
    FROM Book
    WHERE Title = 'The Art of Walt Disney')
ORDER BY Title ASC;


UPDATE Book
SET Shelf_Location = 'KD-2222'
WHERE Subject_Code IN 
	(SELECT Subject_Code 
	FROM Book
	GROUP BY Subject_Code
	ORDER BY COUNT(Subject_Code)
	LIMIT 0,2);

/* apparently mySQL doesn't allow the usage of TOP or Offset or Query 3 would work this way like it does in MS SQL Server:
UPDATE Book
SET Shelf_Location = 'KD-2222'
WHERE Subject_Code IN 
	(SELECT TOP 1  WITH TIES Subject_Code
	FROM Book
	GROUP BY Subject_Code
	ORDER BY COUNT(Subject_Code)); */ 