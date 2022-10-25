USE employees;

/* 2. Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table? 
FIRST AND LAST NAME IN FIRST ROW WERE 'IRENA' 'REUTENAUER'. FIRST AND LAST NAME OF THE LAST PERSON IN THE TABLE WERE 'VIDYA' 'SIMMEN'.
*/
SELECT * FROM employees
WHERE first_name IN('Irena', 'vidya', 'maya')
	ORDER BY first_name;

/*  3. Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name and then last name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?
FIRST AND LAST NAME IN FIRST ROW WERE 'IRENA' 'ACTON'. FIRST AND LAST NAME OF THE LAST PERSON IN THE TABLE WERE 'VIDYA' 'ZWEIZIG'.
*/
SELECT * FROM employees
WHERE first_name IN('Irena', 'Vidya', 'Maya')
	ORDER BY first_name ASC, last_name ASC;

/*  4. Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by last name and then first name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?
FIRST AND LAST NAME IN FIRST ROW WERE 'IRENA' 'ACTON'. FIRST AND LAST NAME OF THE LAST PERSON IN THE TABLE WERE 'MAYA' 'ZYDA'.
*/
SELECT * FROM employees
WHERE first_name IN('Irena', 'Vidya', 'Maya')
	ORDER BY last_name ASC, first_name ASC;

/*  5. Write a query to to find all employees whose last name starts and ends with 'E'. Sort the results by their employee number. Enter a comment with the number of employees returned, the first employee number and their first and last name, and the last employee number with their first and last name.
THERE ARE 899 EMPLOYEES WHOSE LAST NAME STARTS AND ENDS WITH 'E'. 
FIRST EMPLOYEE NO AND FIRST & LAST NAME = 10021, RAMZI ERDE ; LAST EMPLOYEE NO AND FIRST & LAST NAME = 499648, TADAHIRO ERDE.
*/
SELECT * FROM employees
WHERE last_name LIKE 'e%' AND last_name LIKE '%e'
	ORDER BY emp_no;

-- or this way :

SELECT * FROM employees
WHERE last_name LIKE 'e%e'
	ORDER BY emp_no;


/*  6. Write a query to to find all employees whose last name starts and ends with 'E'. Sort the results by their hire date, so that the newest employees are listed first. Enter a comment with the number of employees returned, the name of the newest employee, and the name of the oldest employee. 
THERE ARE 899 EMPLOYEES WHOSE LAST NAME STARTS AND ENDS WITH 'E'. 
NEWEST EMPLOYEE = TEIJI ELDRIDGE ; OLDEST EMPLOYEE = SERGEI ERDE.
*/
SELECT * FROM employees
WHERE last_name LIKE 'e%' AND last_name LIKE '%e'
	ORDER BY hire_date DESC;


/*  7. Find all employees hired in the 90s and born on Christmas. Sort the results so that the oldest employee who was hired last is the first result. Enter a comment with the number of employees returned, the name of the oldest employee who was hired last, and the name of the youngest employee who was hired first. 
THERE WERE 362 EMPLOYEES HIRED IN THE 1990s AND WHO WERE BORN ON CHRISTMAS. 
THE OLDEST EMPLOYEE WHO WAS HIRED LAST WAS Khun Bernini.
THE YOUNGEST EMPLOYEE WHO WAS HIRED FIRST WAS Douadi Pettis.
*/
SELECT * FROM employees
WHERE (hire_date BETWEEN '1990-01-01' AND '1999-12-31')
	AND (birth_date LIKE '%%%%-12-25')
		ORDER BY birth_date ASC, hire_date DESC;

