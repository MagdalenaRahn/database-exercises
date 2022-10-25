USE employees;



/* 2. Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya' using IN. Enter a comment with the number of records returned. 
THERE ARE 709 EMPLOYEES. 
*/
SELECT * FROM employees
WHERE first_name IN('Irena', 'Vidya', 'Maya');


/* 3. Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', as in Q2, but use OR instead of IN. Enter a comment with the number of records returned. Does it match number of rows from Q2? 
YES, THIS MATCHES THE NUMBER FROM Q2, AS Q3 ALSO RETURNED 709 RESULTS. 
*/
SELECT * FROM employees
WHERE first_name = 'Irena' OR first_name = 'Vidya' OR first_name = 'Maya';


/* 4. Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', using OR, and who is male. Enter a comment with the number of records returned. 
RETURNS 441 RESULTS ; 'FIRST_NAME' CLAUSE MUST BE IN PARENTHESES, OTHERWISE THE RESULTS ALSO INCLUDE FEMALES. 
*/
SELECT * FROM employees
WHERE (first_name = 'Irena' OR first_name = 'Vidya' OR first_name = 'Maya')
 	AND gender = 'M';


/* 5. Find all current or previous employees whose last name starts with 'E'. Enter a comment with the number of employees whose last name starts with E. 
THERE ARE 7330 SUCH EMPLOYEES. 
*/
SELECT * FROM employees
WHERE last_name LIKE 'E%';


/* 6. Find all current or previous employees whose last name starts or ends with 'E'. Enter a comment with the number of employees whose last name starts or ends with E. How many employees have a last name that ends with E, but does not start with E? 
THERE ARE 30 723 EMPLOYEES WHOSE LAST NAME EITHER STARTS OR ENDS WITH 'E'. 
THERE ARE 23 393 EMPLOYEES WHOSE LAST NAME ENDS WITH 'E', BUT DOES NOT START WITH 'E'.
*/
SELECT * FROM employees
WHERE last_name LIKE 'E%' OR last_name LIKE '%E';

SELECT * FROM employees
WHERE last_name NOT LIKE 'E%' and last_name LIKE '%E';

/* 7. Find all current or previous employees whose last name starts and ends with 'E'. Enter a comment with the number of employees whose last name starts and ends with E. How many employees' last names end with E, regardless of whether they start with E? 
THERE ARE 899 EMPLOYEES WHOSE LAST NAME BOTH STARTS AND ENDS WITH 'E'.
THERE ARE 24 292 EMPLOYEES WHOSE LAST NAME ENDS WITH 'E', REGARDLESS OF THE LETTER WITH WHICH IT STARTS.
*/
SELECT * FROM employees
WHERE last_name LIKE 'E%' AND last_name LIKE '%E';

SELECT * FROM employees
WHERE last_name LIKE '%E';


/* 8. Find all current or previous employees hired in the 90s. Enter a comment with the number of employees returned. 
THERE WERE 135 214 EMPLOYEES HIRED IN THE 1990s.
*/
SELECT * FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31';


/* 9. Find all current or previous employees born on Christmas. Enter a comment with the number of employees returned. 
THERE WERE 818 EMPLOYEES BORN ON CHRISTMAS.
*/
SELECT * FROM employees
WHERE birth_date LIKE '%%%%-12-31';


/* 10. Find all current or previous employees hired in the 90s and born on Christmas. Enter a comment with the number of employees returned. 
THERE WERE 818 EMPLOYEES BORN ON CHRISTMAS AND HIRED IN THE 1990s. 
*/
SELECT * FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31'
	AND birth_date LIKE '%%%%-12-31';


/* 11. Find all current or previous employees with a 'q' in their last name. Enter a comment with the number of records returned.
THERE WERE 1873 EMPLOYEES WITH 'Q' IN THEIR LAST NAME.
*/
SELECT * FROM employees
WHERE last_name LIKE '%Q%';

/* 12. Find all current or previous employees with a 'q' in their last name but not 'qu'. How many employees are found? 
THERE WERE 1873 EMPLOYEES WITH 'Q' BUT NOT 'QU' IN THEIR LAST NAME.
*/
SELECT * FROM employees
WHERE last_name LIKE '%Q%' AND last_name NOT LIKE '%qu%';