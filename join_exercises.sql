
/* INDICES, JOINS, PKIS AND OTHER KEYS */
use farmers_market;
DESCRIBE customer_purchases;

SELECT * FROM customer_purchases LIMIT 13;

SELECT DISTINCT customer_id FROM customer_purchases;

USE customer;
describe customer;

SELECT DISTINCT customer_id FROM customer;

SELECT * FROM customer;

SELECT * FROM customer_purchases LIMIT 10;

USE product;
describe product;

SELECT * FROM product limit 10;

USE product_category;
describe pro duct_category;

SELECT * FROM product_category;



-- joins and joins and joins --
USE join_example_db;
DESCRIBE join_example_db;
-- what's in here ?

SHOW tables;
-- what's in these tables, specifically ?

SELECT * FROM roles;
-- fields present : id, name

SELECT * FROM users;
-- fields present : id, name, email, role_id

-- our first join : the inner join (default type of join, unless otherwise specified to SQL).


-- Select everything from the Users table 
SELECT * FROM users
-- join the Roles table in 
JOIN roles
-- specify how the match between Users and Roles looks :
ON users.role_id = roles.id;

-- Specific fields in the context of a join ?
-- Tell SQL what to grab, with dot notation (ie, db.users)
-- Format of field calls : table.field (ie, column name)
SELECT email, roles.name /* alternately, SELECT users.email, roles.name (but, in this case, 'email', was a unique column/field name) */
FROM users
JOIN roles
ON users.role_id = roles.id;

-- if we alias tables, we can reference them even in the first line : faketablename.field, faketablename2.field2
SELECT pizza.email, hamsandwich.name
-- note the alias of the table here
FROM users AS pizza
-- and here
JOIN roles AS hamsandwich
-- note that the aaliased table names are ebign used for the key pairing.
ON pizza.role_id = hamsandwich.id;

-- alternately...
SELECT pizza.email, hamsandwich.name
FROM users pizza -- the alias must directly follow the table name in order to drop the 'as'.
JOIN roles hamsandwich
ON pizza.role_id = hamsandwich.id;

SELECT * FROM roles
JOIN users USING(id); /* alternately, ON users.id = roles.id --> 'using' indicates that the two table names are names being addressed. 'id' and 'id' on each table match up because both integers, but we, as operators, are the ones who understand that they are associated as ids, and not simply as matching integers. The cell match (ie, integers, strings, etc) must be exact for the 'using' to work. */

-- LEFT AND RIGHT ?
-- --> TAKE EVERYTHING.
SELECT * 
-- from users (to start)
FROM users
-- join roles
LEFT JOIN roles
ON users.role_id = roles.id;

-- Everything from Users is present, but flipped / reversed ;
-- two rows of info that have Users info, but nothing from Roles.
-- The cells from Roles are filled with null values.
SELECT * 
-- from Roles 
FROM roles
-- join Users
LEFT JOIN users
ON users.role_id = roles.id;

-- as a right join ? Same info as first (Left Join) table, but info is slightly flipped.
SELECT * 
-- from Roles 
FROM roles
-- join Users
RIGHT JOIN users
ON users.role_id = roles.id;

/* -- Inner join : only instances where we have a match on both sides inside of our key pairing.
-- consequence : we can loose information from both tables if there is not a match on either side.
*/

/* 
L or R joins :
-- Left : give all info present in L table, and any matches from the R table.
-- Consequence : maintain every row present in the L table, but may not see everything from the R table. Furthermore, we have info in the L table with no match, we will see 'null' filled into these cells instead of data. 
*/


USE world;
-- tables in here ?
SHOW tables;
 -- city (fields present : id, name, countrycode, district, population), country, countrylanguage
 SELECT * FROM city LIMIT 7 OFFSET 599;
 
 SELECT * FROM country LIMIT 7; 
 /* code (looks like country.Code is a foreign key match with city.CountryCode), name, continent, region, surfacearea, indepuyear, population, lifeexpectancy, gnp, ... */
 
 SELECT * FROM countrylanguage LIMIT 7; 
 /* countrylanguage.countrycode is match with country.code and city.countrycode */
 
 -- let's link these together using an innter join. Take every field.
SELECT * FROM city
JOIN countrylanguage USING(CountryCode)
JOIN country ON country.Code = countrylanguage.CountryCode;

SELECT * FROM city
LEFT JOIN countrylanguage USING(CountryCode)
LEFT JOIN country ON country.Code = countrylanguage.CountryCode;

-- ALTNERNATE SYNTAX
SELECT * FROM city
JOIN countrylanguage ON city.CountryCode = countrylanguage.CountryCode 
JOIN country ON country.Code = countrylanguage.CountryCode;
-- 
SELECT * FROM city
JOIN countrylanguage ON city.CountryCode = countrylanguage.CountryCode
JOIN country ON country.Code = countrylanguage.CountryCode
WHERE language = 'Turkish';


/* 2. Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. */

USE join_example_db;
DESCRIBE users; -- id (pri : name id), name (personal name), email, role_id
DESCRIBE roles; -- id (pri : title id), name (job title)

SELECT * FROM roles
JOIN users USING(ID);

SELECT * FROM users
JOIN roles USING(ID);

SELECT * FROM users
JOIN roles on roles.id = users.id;

SELECT * FROM users
LEFT JOIN roles ON users.role_id = roles.name;

SELECT * FROM users
RIGHT JOIN roles ON users.role_id = roles.name;

SELECT * FROM users
RIGHT JOIN roles ON users.name = roles.name;

SELECT * FROM users
LEFT JOIN roles ON users.name = roles.name;

/* 3. Use count and the appropriate join type to get a list of roles along with the number of users that has the role. Hint: You will also need to use group by in the query. 
*/

SELECT users.name, roles.name, COUNT(*) FROM users
JOIN roles
ON roles.id = users.role_id
GROUP BY users.name, roles.name;

/* Employees Database.     
-- senior enginner, staff, engineer, senior staff, assistant engineer, technique leader, manager */
USE employees;
SHOW tables;
DESCRIBE employees; -- emp_no, birth_date, first_name, last_name, gener, hire_date
DESCRIBE dept_emp; -- emp_no (PRI), dept_no (PRI), from_date, to_date
DESCRIBE dept_manager; -- emp_no (PRI), dept_no (PRI), from_date, to_date
DESCRIBE salaries; -- emp_no (PRI), salary, from_date (PRI), to_date
DESCRIBE titles; -- emp_no (PRI), title, from_date, to_date
DESCRIBE departments; -- dept_no (PRI), dept_name

SELECT * FROM employees 
JOIN dept_manager ON dept_manager.dept_no = employees.emp_no
JOIN departments ON dept_manager.dept_no = departments.dept_name
HAVING dept_manager.to_date = '9999-01-01'
ORDER BY last_name; -- this query returns a blank results screen

/* Q2. Write a query that shows each department along with the name of the current manager for that department. */
SELECT CONCAT(e.first_name, ' ', e.last_name) AS full_name, departments.dept_name AS Dept_Name
FROM employees AS e
JOIN dept_manager ON e.emp_no = dept_manager.emp_no
JOIN departments USING(dept_no)
WHERE dept_manager.to_date = '9999-01-01' ; -- this query is correct and responds correctly to Q2. 

-- EXAMPLE FROM CLASS
SELECT * FROM employees AS e
JOIN dept_manager AS dm on e.emp_no = dm.emp_no AND to_date > CURDATE()
JOIN departments AS d USING (dept_no);
-- to be refined to :
SELECT CONCAT(e.first_name, ' ', e.last_name) AS Current_Dept_Manager, d.dept_name AS Dept_Name 
FROM employees AS e
JOIN dept_manager AS dm on e.emp_no = dm.emp_no AND to_date > CURDATE()
JOIN departments AS d USING (dept_no);

-- OR :
SELECT * FROM employees AS e
JOIN dept_manager AS dm ON e.emp_no = dm.emp_no
WHERE to_date > CURDATE();
-- EXAMPLE FROM CLASS


/* Q3. Find the name of all departments currently managed by women. */
SELECT CONCAT(e.first_name, ' ', e.last_name) AS Manager_Name, departments.dept_name AS Dept_Name
FROM employees AS e
JOIN dept_manager ON e.emp_no = dept_manager.emp_no
JOIN departments ON dept_manager.dept_no = departments.dept_no
WHERE gender = 'F' AND dept_manager.to_date = '9999-01-01';

-- class example :
SELECT CONCAT(e.first_name, ' ', e.last_name) AS Current_Dept_Manager, d.dept_name AS Dept_Name, gender FROM employees AS e
JOIN dept_manager AS dm ON e.emp_no = dm.emp_no
	AND to_date > CURDATE()
	AND gender = 'F'
JOIN departments as d USING (dept_no);



/* Q4. Find the current titles of employees currently working in the Customer Service department. */
SELECT titles.title AS Title, COUNT(*)
FROM employees
JOIN titles ON titles.emp_no = employees.emp_no
JOIN dept_emp ON dept_emp.emp_no = employees.emp_no
JOIN departments ON departments.dept_no = dept_emp.dept_no
WHERE dept_emp.to_date = '9999-01-01' 
	AND Dept_Name = "Customer Service" 
	AND titles.to_date = '9999-01-01'
GROUP BY Title
ORDER BY Title;

-- class example :
SELECT title, COUNT(*) FROM dept_emp AS de
JOIN titles AS t ON de.emp_no = t.emp_no
	AND t.to_date > CURDATE()
	AND de.to_date > CURDATE()
JOIN departments AS d on d.dept_no = de.dept_no
	AND dept_name = "Customer Service"
GROUP BY title;



/* 5. Find the current salary of all current managers. */
SELECT CONCAT(e.first_name, ' ', e.last_name) AS Manager_Name, salary
FROM employees AS e
JOIN dept_manager ON dept_manager.emp_no = e.emp_no
JOIN salaries ON salaries.emp_no = dept_manager.emp_no
WHERE dept_manager.to_date = '9999-01-01' AND salaries.to_date = '9999-01-01'
GROUP BY Manager_Name, Salary
ORDER BY Manager_Name;


SELECT d.dept_name, CONCAT(e.first_name, ' ', e.last_name) AS Manager_Name, s.salary
FROM employees AS e
JOIN salaries AS s ON e.emp_no = s.emp_no
	AND s.to_date > CURDATE()
JOIN dept_manager AS dm ON e.emp_no = dm.emp_no
	AND dm.to_date > CURDATE()
JOIN departments AS d USING(dept_no)
ORDER BY salary;

/* 6. Find the number of current employees in each department (and provide dept name and dept no). */
SELECT departments.dept_name, dept_emp.emp_no, dept_emp.to_date, dept_emp.dept_no 
FROM dept_emp
JOIN employees 
	ON employees.emp_no = dept_emp.emp_no
JOIN dept_manager 
	ON dept_manager.emp_no = employees.emp_no
JOIN departments 
	ON dept_manager.dept_no = departments.dept_no
group by departments.dept_name; /* this is my unfinished attempt */

-- in-class example :
SELECT d.dept_no, d.dept_name, COUNT(*)
FROM dept_emp AS de
JOIN departments AS d ON de.dept_no = d.dept_no
	AND de.to_date > CURDATE()
GROUP BY dept_no, dept_name;


/* 7. Which department has the highest average salary? Hint: Use current not historic information. */
SELECT d.dept_name, ROUND(AVG(salary), 2) AS average_salary
FROM dept_emp AS de
JOIN salaries AS s ON de.emp_no = s.emp_no
	AND de.to_date > CURDATE()
	AND s.to_date > CURDATE()
JOIN departments AS d ON de.dept_no = d.dept_no
GROUP BY d.dept_name
ORDER BY average_salary DESC
LIMIT 1;

/* 8. HIGHEST-PAID EMPLOYEE IN MARKETING DEPT */

SELECT e.first_name, e.last_name, s.salary, d.dept_name
FROM employees AS e
JOIN dept_emp AS de ON e.emp_no = de.emp_no
	and de.to_date > CURDATE()
join departments AS d on de.dept_no = d.dept_no
	and d.dept_name = 'Marketing'
join salaries as s on e.emp_no = s.emp_no
	and s.to_date > CURDATE()
ORDER BY s.salary desc
limit 1;

-- or :
SELECT e.first_name, e.last_name, s.salary AS 'Salary', d.dept_name AS 'Department Name'
FROM salaries AS s
JOIN employees AS e 
	ON e.emp_no = s.emp_no
JOIN dept_emp AS de 
	ON de.emp_no = e.emp_no
JOIN departments AS d 
	ON d.dept_no = de.dept_no
WHERE s.to_date LIKE '9999%' 
	AND d.dept_name = 'Marketing' 
	AND de.to_date LIKE '9999%'
	AND d.dept_name = 'Marketing'
ORDER BY 
	s.salary DESC
LIMIT 1;

/* 9. Which current department manager has the highest salary? */
SELECT e.first_name, e.last_name, s.salary, d.dept_name
FROM employees AS e
JOIN dept_manager AS dm ON e.emp_no = dm.emp_no
and dm.to_date > CURDATE()
join salaries as s on e.emp_no = s.emp_no
and dm.to_date > curdate()
join departments as d using(dept_no)
order by s.salary desc
limit 1;


/* 10. Determine the average salary for each department. Use all salary information and round your results. */
SELECT d.dept_name , round(avg(s.salary), 0) as avg_dept_salary
from departments AS d
join dept_emp as de on d.dept_no = de.dept_no
join salaries as s on de.emp_no = s.emp_no
group by d.dept_name
order by avg_dept_salary desc;
