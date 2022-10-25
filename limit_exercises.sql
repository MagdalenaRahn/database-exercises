USE employees;
SELECT DISTINCT title FROM titles;

/* 2. List the first 10 distinct last name sorted in descending order. 
Zykh
Zyda
Zwicker
Zweizig
Zumaque
Zultner
Zucker
Zuberek
Zschoche
Zongker
*/
SELECT DISTINCT last_name FROM employees
ORDER BY last_name DESC;

/* 3. Find all previous or current employees hired in the 90s and born on Christmas. Find the first 5 employees hired in the 90's by sorting by hire date and limiting your results to the first 5 records. 
Write a comment in your code that lists the five names of the employees returned :
Anselm Cappello, Utz Mandell, Bouchung Schreiter, Baocai Kushner, Petter Stroustrup.
*/ 
SELECT * FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31'
	AND birth_date LIKE '%%%%-12-25'
		ORDER BY hire_date
		LIMIT 5;
		
		
/* 4. Update the query to find the tenth page of results. What is the relationship between OFFSET (number of results to skip), LIMIT (number of results per page), and the page number?
THE OFFSET IS THE NUMBER OF ENTRIES TO SKIP BEFORE LISTING THE LIMIT (SELECTION) OF 5 SOUGHT-AFTER ENTRIES.
*/
SELECT * FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31'
	AND birth_date LIKE '%%%%-12-25'
		ORDER BY hire_date
		LIMIT 5 OFFSET 50;
