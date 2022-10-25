/* Find the smallest and largest current salary from the salaries table.

Use your knowledge of built in SQL functions to generate a username for all of the employees. A username should be all lowercase, and consist of the first character of the employees first name, the first 4 characters of the employees last name, an underscore, the month the employee was born, and the last two digits of the year that they were born. Below is an example of what the first 10 rows will look like: 

USE saas_llc;
SELECT city, street_name, state, zip, 
CONCAT('0', ZIP) AS full_zip,
LOWER (street_name) AS street,
REPLACE (state, 'A', 'assachusetts') AS full_state -- note that the replace-function is case-sensitive
FROM customer_details
ORDER BY street_name; */

/* Write a query to to find all employees whose last name starts and ends with 'E'. Use concat() to combine their first and last name together as a single column named full_name. */

USE employees;

SELECT first_name, last_name FROM employees
WHERE last_name LIKE 'E%E';

SELECT CONCAT(first_name, ' ', last_name) AS full_name FROM employees
WHERE last_name LIKE 'E%E';


/* Convert the names produced in your last query to all uppercase. */
SELECT lower(CONCAT(first_name, ' ', last_name)) AS full_name FROM employees
WHERE last_name LIKE 'E%E' ;


/* Find all employees hired in the 90s and born on Christmas. Use datediff() function to find how many days they have been working at the company (Hint: You will also need to use NOW() or CURDATE()) */
SELECT datediff(curdate(), birth_date) from employees
	WHERE hire_date LIKE '199%' AND birth_date LIKE '%-12-25';
	
