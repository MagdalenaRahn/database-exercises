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


SELECT * FROM employees
WHERE LEFT(last_name, 1) = 'E';
-- this takes the first character from the left in the surname.

SELECT * FROM employees
WHERE LEFT(last_name, 1) = 'e' AND RIGHT(last_name, 1) = 'e';


-- following is CONCAT exercises
USE albums_db;
select * from albums limit 50;

select concat (artist, ' - ', `name`) AS artist_album
from albums;

select artist as stage_name, `name`, concat(artist, ' - ', `name`) AS artist_album
from albums;

-- following is SUBSTRING / SUBSTR
SELECT SUBSTR('adam krull', 3, 9) AS your_instructor_Adam ;

SELECT artist,
	SUBSTR(artist, 2, 5) AS artist_brf,
	SUBSTR(`name`, 1, 5) AS name_brf
FROM albums;


-- this takes the first 5 letters of the artist's name and connects them to the first 5 letters of the album name :
SELECT artist,
	CONCAT(SUBSTR(artist, 1, 5), SUBSTR(`name`, 1, 5)) AS artist_album_id
FROM albums;
-- this is also an exmple of nesting functions


SELECT SUBSTR('Magdalena', 1,1), SUBSTR('RAHN', 1,1) AS initials;
SELECT CONCAT(SUBSTR('Magdalena', 1,1), SUBSTR('RAHN', 1,1)) AS initials;


USE zillow;
SELECT * FROM properties_2016 LIMIT 100;

SELECT DISTINCT SUBSTR(regionidzip, 1,2) AS zip_first2digits FROM properties_2016 LIMIT 100;

SELECT * FROM `properties_2016` WHERE substr(regionidzip, 1,2) = 39;


USE albums_db;

SELECT artist,
	CONCAT(SUBSTR(artist, 1, 5), SUBSTR(`name`, 1, 5)) AS artist_album_id
FROM albums;

-- CONVERT ALL INDICATED TEXT TO LOWERCASE / UPPERCASE
SELECT artist,
	LOWER(CONCAT(SUBSTR(artist, 1, 5), SUBSTR(`name`, 1, 5))) AS artist_album_id
FROM albums;

SELECT UPPER('magdalena');


USE saas_llc;
SELECT * from customer_details limit 100;

SELECT UPPER(state) AS state FROM customer_details;

SELECT DISTINCT UPPER(state) AS state FROM customer_details;

SELECT REPLACE ('Magdalena', 'gdalena', 'dge');

USE saas_llc;
SELECT city, street_name, state, zip, 
CONCAT('0', ZIP) AS full_zip,
LOWER (street_name) AS street,
REPLACE (state, 'A', 'assachusetts') AS full_state -- note that the replace-function is case-sensitive
FROM customer_details
ORDER BY street_name;
 
 
-- date / time functions

select NOW();
SELECT curdate();


-- this subtracts the yearbuilt from the current date, to get the current age of the house.
-- order by is done after the functions, so it accespts using alias for its commands (see below)

USE zillow;
select * from properties_2016 limit 100;
select year(curdate()) - yearbuilt AS age
from properties_2016
where yearbuilt is not null
order by age
limit 100;


use employees;
select birth_date, datediff(now(), birth_date) / 365
as age from employees;


select unix_timestamp(); 
-- number of seconds since midnight 01 Jan 1970
select concat ('my niece Beatrix is ', unix_timestamp() - unix_timestamp(2012-05-10)), ' seconds old.';


use zillow;
select 
	min(calculatedfinishedsquarefeet) AS min_sq_ft, 
	max(calculatedfinishedsquarefeet) AS max_sq_ft, 
	round(avg(calculatedfinishedsquarefeet), 2) AS rounded_avg_sq_ft,
	std(calculatedfinishedsquarefeet) AS std_dev_sq_ft
from properties_2016 limit 100;


USE saas_llc;
SELECT cast(CONCAT('0', zip) AS char) AS full_zip
FROM customer_details
ORDER BY full_zip;
-- casting converts one type to another, for example, integer to string

select cast(01242 as unsigned);
select cast(11010909 as date);

