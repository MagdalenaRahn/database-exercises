/* 2. In your script, use DISTINCT to find the unique titles in the titles table. How many unique titles have there ever been? Answer that in a comment in your SQL file. 
THERE ARE 7 UNIQUE TITLES. 
*/
USE employees;
describe employees;

SELECT DISTINCT title FROM titles;

/* 3. Write a query to to find a list of all unique last names of all employees that start and end with 'E' using GROUP BY.
*/
SELECT last_name FROM employees
WHERE last_name LIKE 'E%E'
GROUP BY last_name;


/* 4. Write a query to to find all unique combinations of first and last names of all employees whose last names start and end with 'E'.
*/
SELECT first_name, last_name FROM employees
WHERE last_name LIKE 'E%E'
GROUP BY first_name, last_name
ORDER BY first_name;


/* 5. Write a query to find the unique last names with a 'q' but not 'qu'. Include those names in a comment in your sql code :
Chleq, Lindqvist, Qiwen
*/
SELECT last_name FROM employees
WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%'
GROUP BY last_name;

/* 6. Add a COUNT() to your results (the query above) to find the number of employees with the same last name :
Chleq (189), Lindqvist (190), Qiwen (168)
*/
SELECT last_name, COUNT(*) FROM employees
WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%'
GROUP BY last_name;

/* 7. Find all all employees with first names 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names.
*/

SELECT first_name, gender, COUNT(*) FROM employees
WHERE first_name IN('Irena', 'Vidya', 'Maya')
GROUP BY first_name, gender
ORDER BY first_name ASC;

/* 8. Using your query that generates a username for all of the employees, generate a count employees for each unique username. Are there any duplicate usernames? BONUS: How many duplicate usernames are there?
There are 6 duplicate usernames.
*/
SELECT first_name, last_name, birth_date, count(*),
	LOWER(CONCAT(SUBSTR(first_name,1,1), SUBSTR(last_name, 1,4), '_', SUBSTR(birth_date, 6,2), SUBSTR(birth_date, 3,2))) 
	AS username 
FROM employees
GROUP BY first_name, last_name, birth_date
ORDER BY COUNT(*) DESC;


SELECT CONCAT(LOWER(SUBSTR(first_name, 1, 1)), LOWER(SUBSTR(last_name, 1, 4)), "_", SUBSTR(birth_date, 6, 2), SUBSTR(birth_date, 3, 2)) 
	AS user_id, 
	COUNT(*) AS amount
FROM employees
GROUP BY user_id 
HAVING amount > 1;


SELECT LOWER(CONCAT(SUBSTR(first_name, 1, 1), SUBSTR(last_name, 1, 4), '_', SUBSTR(birth_date, 6, 2), SUBSTR(birth_date, 3, 2))) 
	AS username, 
	COUNT(*) AS amount
FROM employees
GROUP BY username
HAVING amount > 1
ORDER BY amount DESC;


/* 9. Bonus: More practice with aggregate functions:
a. Determine the historic average salary for each employee. When you hear, read, or think "for each" with regard to SQL, you'll probably be grouping by that exact column. 
*/
use salaries;
describe salaries;

SELECT DISTINCT emp_no, salary, AVG (salary) FROM salaries
GROUP BY emp_no, salary;

/* 9b. Using the dept_emp table, count how many current employees work in each department. The query result should show 9 rows, one for each department and the employee count. 
*/
use employees;
use dept_emp;
describe dept_emp;

SELECT dept_no, COUNT(dept_no) AS Departements
FROM dept_emp
GROUP BY dept_no 
ORDER BY Departements;
-- ...

/* 9d, 9e. Determine how many different salaries each employee has had. This includes both historic and current. 
*/

use salaries;
describe salaries;

SELECT emp_no, MIN(salary), MAX(salary)
FROM salaries
GROUP BY emp_no, salary
ORDER BY emp_no;