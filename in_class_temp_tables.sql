/* TEMPORARY TABLES */
/* TEMPORARY TABLES */
/* TEMPORARY TABLES */
/* TEMPORARY TABLES */
/* TEMPORARY TABLES */
31 OCTOBER 2022, WEEK 3 */

USE noether_2020;
SHOW tables; -- empty !

DROP TABLE IF EXISTS Temp_My_Nos; -- if the table doesn't exist, it won't drop the table, but if the table does exist, it will drop any and all tables with the table named.

CREATE TEMPORARY TABLE Temp_My_Nos (
	n INT UNSIGNED /* this means that it can only be positive numbers */ NOT NULL,
	/* EACH COLUMN AND ITS INSTRUCTIONS ARE SEPARATED BY COMMAS */
	`name` VARCHAR(10) NOT NULL
	); /* SEQUEL ACE DOES NOT SHOW TEMP TANLES IN 'TABLE' BOX */
	
SELECT * FROM Temp_My_Nos; -- this makes the column names appear.
/* if I run the ctt after running the 'select', it gives an error message, because the temp table already exists. So, add this line ebfore creating temp table : DROP TABLE IF EXISTS temp_table_name */

-- insert data into Temp_My_Nos :
INSERT INTO Temp_My_Nos(n, name) -- this line will add additional data each time it's run, because no PKI.
VALUES (1, 'п'),(2, 'ш'), (3, 'с'), (4, 'д');
SELECT * FROM Temp_My_Nos;

-- delete from Temp_My_Nos :
DELETE FROM Temp_My_Nos WHERE n > 2;
SELECT * FROM Temp_My_Nos;

-- transform our existing data WITHOUT a conditional statement :
UPDATE Temp_My_Nos SET n = n +1;
SELECT * FROM Temp_My_Nos;

-- transform our existing data WITH a conditional statement :
UPDATE Temp_My_Nos SET n = n + 10
WHERE name = 'п';
SELECT * FROM Temp_My_Nos;



--
--
--

USE employees;
SELECT emp_no, dept_no, first_name, last_name, salary, title 
-- the 'select' statement is the info that will be stored in the temp table
FROM employees AS e
JOIN dept_emp AS de USING(emp_no)
JOIN salaries AS s USING(emp_no)
JOIN departments AS dp USING(dept_no)
JOIN titles AS t USING(emp_no)
WHERE de.to_date > NOW()
	AND s.to_date > NOW()
	AND t.to_date > NOW()
	and dept_name = 'Customer Service';
	
/* save output into a temp table in my personal database of our design, to explore data within. 
create temporary table [name] AS [query] */
CREATE TEMPORARY TABLE noether_2020.salary_info /* my personaldatabase.temptable */ 
AS (
	SELECT emp_no, dept_no, first_name, last_name, salary, title
	FROM employees AS e
	JOIN dept_emp AS de USING(emp_no)
	JOIN salaries AS s USING(emp_no)
	JOIN departments AS dp USING(dept_no)
	JOIN titles AS t USING(emp_no)
		WHERE de.to_date > NOW()
			AND s.to_date > NOW()
			AND t.to_date > NOW()
			AND dept_name = 'Customer Service'
); /* the above command was to create a temp table ; we didn't request what the table contained. Thus, see the following 
line of code to obtain code : */

SELECT * FROM noether_2020.salary_info;

/* What is the avg salary for current emploeyes in customer service ? 
THE TEMP TABLE ALLOWS FOR SIMPLFIED QUERIES : */
SELECT ROUND(AVG(salary), 2) FROM noether_2020.salary_info;

/* add new columns to temp table : changes table structure */
ALTER TABLE noether_2020.salary_info ADD avg_salary FLOAT;
ALTER TABLE noether_2020.salary_info ADD std_salary FLOAT;
ALTER TABLE noether_2020.salary_info ADD greater_than_avg_salary FLOAT;

SELECT * FROM noether_2020.salary_info;

/* update new columns with new info ; SET value NULL to a new value ; the below is a change-cmmand, not an output-command */
UPDATE noether_2020.salary_info SET avg_salary = 67000;

SELECT * FROM noether_2020.salary_info;

UPDATE noether_2020.salary_info SET std_salary = 16000;
UPDATE noether_2020.salary_info SET greater_than_avg_salary  = salary > avg_salary;

SELECT * FROM noether_2020.salary_info;

/* whatever code produces output can create a new temp table : 
CREATE TEMPORARY TABLE server.temptablename 
AS (previous temp table)
WHERE ... ;
*/


-- CHECKING OUTPIUT OF A QUERY THAT JOINS MY TEMP TABLE TO A PERMANENT TABLE.
SELECT * FROM noether_2020.salary_info AS si
JOIN employees AS e USING(emp_no);

DROP TABLE IF EXISTS noether_2020.salary_emp_info;
-- SAVING THE RESULTS OF THE QBOVE QUERY INTO A NEW TEMP TABLE
CREATE TEMPORARY TABLE noether_2020.salary_emp_info AS (
		SELECT emp_no, 
		dept_no, 
		si.first_name, 
		si.last_name, 
		salary, 
		title, 
		avg_salary, 
		birth_date, 
		gender, 
		hire_date 
FROM noether_2020.salary_info AS si
JOIN employees AS e USING(emp_no));

SELECT * FROM noether_2020.salary_info;


