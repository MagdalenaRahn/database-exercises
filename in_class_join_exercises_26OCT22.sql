
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
