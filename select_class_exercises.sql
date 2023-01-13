USE albums_db;
USE fruits_db;
SELECT id,
		name,
			quantity
FROM fruits;
SELECT name,
		quantity
FROM fruits;
SELECT *
FROM fruits;
SELECT *, quantity >= 3
FROM fruits;

SELECT DISTINCT name, quantity
FROM fruits;

USE employees;

SELECT * 
FROM titles;

SELECT DISTINCT title
FROM titles;

SELECT *
FROM titles
WHERE (title = 'senior engineer' OR title = 'staff')
AND from_date BETWEEN '1991-01-01' AND '2000-01-01';
/* this is an inclusive date-listing (ie,  it includes the from_dates) */


SELECT title = 'Senior Engineer',
	title
FROM titles;

SELECT 2 = 2, 1 = 2;

SELECT 2 + 3;

SELECT title,
		title = 'Senior Engineer' AS 'boolean'
-- the 'AS' is an alias namer, and can also make restricted words as titles.
FROM titles;

SELECT *,
	title = 'Senior Engineer' AS 'Is_Senior',
		title = 'Staff' AS 'Is_Staff'
FROM titles
WHERE emp_no < 10100
AND to_date = '9999-01-01';
