USE albums_db;

SELECT count(*) from albums;

SELECT count(DISTINCT artist) FROM albums;

SELECT DISTINCT artist FROM albums;

SELECT MIN(release_date) FROM albums;

SELECT name, release_date FROM albums
ORDER BY release_date ASC;

SELECT name, release_date FROM albums
WHERE name LIKE '%Sgt%';

SELECT name, release_date FROM albums WHERE release_date >= 1990 AND release_date <= 1999;

SELECT genre, artist, name FROM albums
WHERE genre != 'Rock'
ORDER BY name ASC;



USE employees;

SELECT * FROM `employees`
WHERE hire_date > '1990-01-01';

SELECT * FROM `employees`
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31';

SELECT * FROM `employees`
WHERE hire_date LIKE '199%';
 -- to find those hired in the 1990s
 
SELECT * FROM `employees`
WHERE hire_date LIKE '%-10-%'; 

SELECT count(*) FROM employees;
SELECT count(DISTINCT last_name) from employees;

SELECT * FROM `employees`
WHERE hire_date NOT LIKE '%-10-%';

-- first name starts with s
SELECT * FROM `employees`
WHERE first_name LIKE 's%';

SELECT * FROM `employees`
WHERE first_name LIKE 's%s';

SELECT * FROM employees
WHERE first_name LIKE 'S%' AND last_name LIKE 'S%';

SELECT * FROM employees
WHERE first_name LIKE 'S%' OR last_name LIKE 'S%';

-- FIND ALL THOSE WHOSE LAST NAME IS EITHER FOOTE OR SIDOU
SELECT * FROM employees
WHERE last_name = 'Foote' OR last_name = 'Sidou';

SELECT * FROM employees
WHERE last_name IN('Foote','Sidou');

SELECT * FROM employees
WHERE hire_date IS NOT NULL;

-- find employees who were hired in the 1990s and last_name starts with s or first name starts with with s.
SELECT * FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31'
	AND (first_name LIKE 'S%' OR last_name LIKE 'S%');


-- order by : employees hired in the 1990s, ordered by ascending hire date
SELECT * FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31'
	ORDER BY hire_date DESC;
	
SELECT * FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1991-12-31'
	ORDER BY hire_date ASC, gender DESC;


-- ADDING LIMITS TO OUTPUT, which reduces work required in connecting to db
SELECT * FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1991-12-31'
	ORDER BY hire_date ASC, gender DESC
		limit 100;


SELECT * FROM employees
WHERE birth_date LIKE '195%'
	ORDER BY hire_date ASC, first_name ASC
		LIMIT 5;
		
		
-- skips the first three on the specified list. (Example : To offset pages : if 10 displayed on a page, and we want to find the 4th page, then offset by 30.)	
SELECT * FROM employees
WHERE birth_date LIKE '195%'
	ORDER BY hire_date ASC, first_name ASC
		LIMIT 5 OFFSET 3;
