/* 
1. Using the example from the lesson, create a temporary table called employees_with_departments that contains first_name, last_name, and dept_name for employees currently with that department. Be absolutely sure to create this table on your own database. If you see "Access denied for user ...", it means that the query was attempting to write a new table to a database that you can only read.

   a. Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns
   b. Update the table so that full name column contains the correct data
   c. Remove the first_name and last_name columns from the table.
   d. What is another way you could have ended up with this same table?
*/


SHOW tables; 
use employees;


DROP TEMPORARY TABLE IF EXISTS noether_2020.employees_with_departments;

CREATE TEMPORARY TABLE noether_2020.employees_with_departments (
	first_name VARCHAR(13) NOT NULL,
	last_name VARCHAR(13) NOT NULL,
	dept_name VARCHAR(13) NOT NULL
	);

-- this is correct, apparently.
CREATE TEMPORARY TABLE noether_2020.employees_with_departments 
	AS (
	SELECT first_name, last_name, dept_name 
	FROM employees 
	join dept_emp USING(emp_no) 
	JOIN departments USING (dept_no)
	);

USE noether_2020;


SELECT * FROM employees_with_departments;

/* a. */
ALTER TABLE noether_2020.employees_with_departments ADD full_name VARCHAR(31);
-- or :
DESCRIBE employees_with_departments;

update employees_with_departments SET full_name = CONCAT(first_name, ' ', last_name);

/* b. */
SELECT * FROM noether_2020.employees_with_departments;
/* c. */
ALTER TABLE noether_2020.employees_with_departments DROP COLUMN first_name;
ALTER TABLE noether_2020.employees_with_departments DROP COLUMN last_name;
/* d. 
I could have done this : */
CREATE TEMPORARY TABLE employees_with_departments (
	full_name VARCHAR(26) NOT NULL,
	dept_name VARCHAR(13) NOT NULL
	);


/* 
2. Create a temporary table based on the payment table from the sakila database.
Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of 
cents of the payment. For example, 1.99 should become 199. 
*/

USE sakila;
show tables;  -- actor, actor_info, address, category, city, country, customer, customer_list, film, film_actor, film_category, film_list, film_text, inventory, language...
describe payment; -- payment_id (smallint unsigned), customer_id (smallint unsigned), amount (decimal(5,2))...

DROP TABLE IF EXISTS noether_2020.sakilapayment;

CREATE TEMPORARY TABLE noether_2020.sakilapayment
	(payment_id INT(5) NOT NULL,
	customer_id INT(5) NOT NULL,
	amount decimal(5,2));

-- this is correct, apparently.
CREATE TEMPORARY TABLE noether_2020.sakilapayment 
AS 
	(SELECT payment_id, customer_id, amounT, payment_date 
	FROM payment
	);

SELECT * FROM noether_2020.sakilapayment;

SELECT payment_id, amount * 100
FROM noether_2020.sakilapayment;

ALTER TABLE noether_2020.sakilapayment ADD pennies INT(5) NOT NULL;

SELECT *
FROM noether_2020.sakilapayment;

update noether_2020.sakilapayment set pennies = amount * 100;

SELECT * 
FROM noether_2020.sakilapayment;

ALTER TABLE noether_2020.sakilapayment DROP COLUMN amount;

-- or this way :
CREATE TEMPORARY TABLE noether_2020.sakilapayment 
AS 
	(SELECT payment_id, customer_id, amounT, payment_date 
	FROM payment
	);

SELECT CAST(amount * 100 AS UNSIGNED) AS cents
FROM noether_2020.sakilapayment;



--- this below is mine :
ALTER TABLE noether_2020.sakilapayment MODIFY amount INT(5) NOT NULL; 
-- THE 'ALTER COLUMN' CMD DOESN'T WORK HERE, BUT THE 'MODIFY' DOES.

SELECT * FROM noether_2020.sakilapayment;



/* 
3. Find out how the current average pay in each department compares to the overall current pay for everyone at the 
company. In order to make the comparison easier, you should use the Z-score for salaries. In terms of salary, what 
is the best department right now to work for? The worst?
*/

USE EMPLOYEES;
SHOW tables;
describe employees;
describe dept_emp;
describe departments;
describe salaries; -- emp_no, salary, from_date, to_date

/* CREATE TEMPORARY TABLE noether_2020.empsal
	(emp_no INT NOT NULL, 
	salary INT NOT NULL, 
	from_date INT NOT NULL, 
	to_date INT NOT NULL); */

DROP TABLE IF EXISTS noether_2020.empsal;


SELECT * FROM employees AS e
JOIN dept_emp AS de USING(emp_no)
JOIN departments AS ds USING(dept_no)
JOIN salaries AS s USING(emp_no)
WHERE s.to_date > CURDATE()
	AND de.to_date > CURDATE();


CREATE TEMPORARY TABLE noether_2020.empsal
AS (SELECT e.emp_no, e.first_name, e.last_name, s.salary, ds.dept_name 
	FROM employees AS e
JOIN dept_emp AS de USING(emp_no)
JOIN departments AS ds USING(dept_no)
JOIN salaries AS s USING(emp_no)
WHERE s.to_date > CURDATE()
	AND de.to_date > CURDATE());

SELECT ROUND(AVG(salary), 2) FROM noether_2020.empsal; -- this works

SELECT emp_no, first_name, last_name, salary, dept_name
	FROM noether_2020.empsal;
ROUND(AVG(salary), 2); -- this is not working

-- z-score equasion :
SELECT salary,
    (salary - (SELECT AVG(salary) FROM salaries))
    /
    (SELECT stddev(salary) FROM salaries) AS zscore
FROM salaries;




-- class discussion :
use employees;
# AGGREGATE INFORMATION :
CREATE TEMPORARY TABLE noether_2020.empsal AS (
	SELECT AVG(salary) AS avg_salary, STDDEV_POP(salary) AS std_salary
	FROM employees.salaries
	WHERE to_date > NOW()
	);

# CHECK
SELECT * FROM noether_2020.empsal;

# CREATE COLUMNS FOR TABLE
CREATE TEMPORARY TABLE noether_2020.metrics AS (
	SELECT dept_name, AVG(salary) AS dept_avg
	FROM employees.salaries
	JOIN employees.dept_emp USING(emp_no)
	JOIN employees.departments USING(dept_no)
	WHERE employees.dept_emp.to_date > NOW()
	AND employees.salaries.to_date > NOW()
	GROUP BY dept_name
	);

# CHECK
SELECT * FROM noether_2020.metrics;

# CREATE COLUMNS FOR TABLE
ALTER TABLE noether_2020.metrics ADD overall_avg FLOAT(10, 2);
ALTER TABLE noether_2020.metrics ADD overall_std FLOAT(10, 2);
ALTER TABLE noether_2020.metrics ADD dept_zscore FLOAT(10, 2);

# CHECK
SELECT * FROM noether_2020.metrics;

# UPDATE THE TABLE WITH THE AVERAGE
UPDATE noether_2020.metrics SET overall_avg = (SELECT avg_salary FROM noether_2020.empsal);

# CHECK
SELECT * FROM noether_2020.metrics;

# UPDATE THE TABLE WITH THE STANDARD DEVIATION
UPDATE noether_2020.metrics SET overall_std = (SELECT std_salary FROM noether_2020.empsal);

# CHECK
SELECT * FROM noether_2020.metrics;

# UPDATE THE TABLE WITH THE CALCULATED Z-SCORE
UPDATE noether_2020.metrics SET dept_zscore = (dept_avg - overall_avg) / overall_std;

# CHECK
SELECT * FROM noether_2020.metrics;
