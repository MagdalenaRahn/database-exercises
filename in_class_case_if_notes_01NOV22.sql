
use employees;
# CASE column_a WHEN condition THEN value_1 ELSE value_2
SELECT
    dept_name,
    CASE dept_name
        WHEN 'Research' THEN 1
        ELSE 0
    END AS is_research
FROM departments;

# CASE WHEN column_a = condition THEN value_1 ELSE value_2
SELECT
    dept_name,
    CASE
        WHEN dept_name IN ('Marketing', 'Sales') THEN 'Money-Makers'
        WHEN dept_name LIKE '%research%' OR dept_name LIKE '%resources%' THEN 'People People'
        ELSE 'Others'
    END AS department_categories
FROM departments;

# column_a = condition
SELECT
    dept_name,
    dept_name = 'Research' AS is_research
FROM departments;

# IF(column_a = condition, value_1, value_2)
SELECT
    dept_name,
    IF(dept_name = 'Research', True, False) AS is_research
FROM departments;


# We can create a pivot table using the COUNT function with CASE statements. 

-- Here, I'm building up my columns and values before I group by departments and use an aggregate function to get a count of values in each column.
SELECT
    dept_name,
    CASE WHEN title = 'Senior Engineer' THEN title ELSE NULL END AS 'Senior Engineer',
    CASE WHEN title = 'Staff' THEN title ELSE NULL END AS 'Staff',
    CASE WHEN title = 'Engineer' THEN title ELSE NULL END AS 'Engineer',
    CASE WHEN title = 'Senior Staff' THEN title ELSE NULL END AS 'Senior Staff',
    CASE WHEN title = 'Assistant Engineer' THEN title ELSE NULL END AS 'Assistant Engineer',
    CASE WHEN title = 'Technique Leader' THEN title ELSE NULL END AS 'Technique Leader',
    CASE WHEN title = 'Manager' THEN title ELSE NULL END AS 'Manager'
FROM departments
JOIN dept_emp USING(dept_no)
JOIN titles USING(emp_no);

-- Next, I add my GROUP BY clause and COUNT function to get a count of all employees who have historically ever held a title by department. (I'm not filtering for current employees or current titles.)
SELECT
    dept_name,
    COUNT(CASE WHEN title = 'Senior Engineer' THEN title ELSE NULL END) AS 'Senior Engineer',
    COUNT(CASE WHEN title = 'Staff' THEN title ELSE NULL END) AS 'Staff',
    COUNT(CASE WHEN title = 'Engineer' THEN title ELSE NULL END) AS 'Engineer',
    COUNT(CASE WHEN title = 'Senior Staff' THEN title ELSE NULL END) AS 'Senior Staff',
    COUNT(CASE WHEN title = 'Assistant Engineer' THEN title ELSE NULL END) AS 'Assistant Engineer',
    COUNT(CASE WHEN title = 'Technique Leader' THEN title ELSE NULL END) AS 'Technique Leader',
    COUNT(CASE WHEN title = 'Manager' THEN title ELSE NULL END) AS 'Manager'
FROM departments
JOIN dept_emp USING(dept_no)
JOIN titles USING(emp_no)
GROUP BY dept_name
ORDER BY dept_name;


-- In this query, I filter in my JOINs for current employees who currently hold each title.
SELECT
    dept_name,
    COUNT(CASE WHEN title = 'Senior Engineer' THEN title ELSE NULL END) AS 'Senior Engineer',
    COUNT(CASE WHEN title = 'Staff' THEN title ELSE NULL END) AS 'Staff',
    COUNT(CASE WHEN title = 'Engineer' THEN title ELSE NULL END) AS 'Engineer',
    COUNT(CASE WHEN title = 'Senior Staff' THEN title ELSE NULL END) AS 'Senior Staff',
    COUNT(CASE WHEN title = 'Assistant Engineer' THEN title ELSE NULL END) AS 'Assistant Engineer',
    COUNT(CASE WHEN title = 'Technique Leader' THEN title ELSE NULL END) AS 'Technique Leader',
    COUNT(CASE WHEN title = 'Manager' THEN title ELSE NULL END) AS 'Manager'
FROM departments
JOIN dept_emp
    ON departments.dept_no = dept_emp.dept_no AND dept_emp.to_date > CURDATE()
JOIN titles
    ON dept_emp.emp_no = titles.emp_no AND titles.to_date > CURDATE()
GROUP BY dept_name
ORDER BY dept_name;




#### IF and CASE STATEMENTS LESSON ####

-- LET'S LOOK AT ALL CHICKEN ORDERS IN CHIPOTLE DATABASE.
SHOW databases;
USE chipotle;
SHOW tables; 
SELECT * FROM orders; -- id, order_id, quantity, item_name, choice_description, item_price

# all the chcken orders
SELECT DISTINCT item_name FROM orders
WHERE item_name LIKE '%chicken%';

# 'IF' function : generally best for T/F
# IF(condition, value if true, value if false)

SELECT item_name, if (item_name = 'Chicken Bowl', 'yes', 'no')
AS IS_CHICKEN_BOWL -- 1 searched-for item, 2 first T, 3 second F
FROM orders;

# using yes / no.
SELECT item_name, if (item_name LIKE '%chicken%', 'yes', 'no') 
AS HAS_CHICKEN
FROM orders
ORDER BY item_name asc;

# using T / F.
SELECT item_name, if (item_name LIKE '%chicken%', 'True', 'False') 
AS HAS_CHICKEN
FROM orders
ORDER BY item_name asc;

# using boolean values.
SELECT item_name, if (item_name LIKE '%chicken%', True, False) 
-- removing the '' makes the value Boolean, ie, 1, 0, and gives more flexibility to search terms.
AS HAS_CHICKEN
FROM orders
ORDER BY item_name asc;

# we don't have to write out entire t / f contidions
SELECT DISTINCT item_name, item_name LIKE '%chicken%' 
AS has_chicken
FROM orders;

# use as a subquery
SELECT SUM(has_chicken) AS total_chicken_items 
FROM 
	(SELECT DISTINCT item_name, item_name LIKE '%chicken%' 
	AS has_chicken
	FROM orders) 
AS A;


# CASE STATEMENTS.

# AS MANY RESPONSES AS WE WANT 

-- THE CONDITION ARE CHECKING ONE COLUMN (ie, if search 'red dog', it will only return 'red' or 'dog', depending on which is reached first).
-- THE CONDITIONS ARE CHECKING FOR EQUALITY.
-- CAN CHECK MORE THAN T / F.

/* 
case column
	when condition_a then value_a # AS MANY CONDITIONS CAN BE ENTERED AS ONE WANTS
	when condition_b then value_b
	else value_c
end as new_column_name
*/

# LET'S FIND THE BOWLS
SELECT * FROM orders;

SELECT DISTINCT item_name FROM orders;

SELECT DISTINCT item_name, 
/* case statement in select statement */
	CASE item_name
/*  = (equals)  */
		WHEN 'Chicken Bowl' THEN 'yes_chicken'
	END
FROM orders;

SELECT item_name, 
	CASE item_name
		WHEN 'Chicken Bowl' THEN 'yes_chicken'
	END AS 'is_bowl' 
/* adding an alias  */
FROM orders;


SELECT item_name, 
	CASE item_name
		WHEN 'Chicken Bowl' THEN 'yes_chicken'
		WHEN 'Steak Bowl' then 'yes_steak'
		WHEN '%bowl%' then 'yes_other'
-- THIS WAY OF CASE STATEMENTS ONLY CHECKS FOR EQUALITY, SO 'LIKE' OR '%' STATEMENTS ERROR OUT. CASE STATEMENTS MUST MATCH ENTRIES EXACTLY.
		ELSE 'other'
	END AS 'is_bowl' 
FROM orders;


SELECT item_name, 
	CASE item_name
		WHEN 'Chicken Bowl' THEN 'yes_chicken'
		WHEN 'Steak Bowl' then 'yes_steak'
		ELSE CONCAT ('this_is_not_a_bowl', REPLACE(LOWER(item_name),' ', ' '))
	END AS 'is_bowl' 
FROM orders;


## more case statements, more flexibilities
## can use 'like' statements
## multiple column checks
## can use different operators
## generally preferred


SELECT
    CASE column_a
        WHEN condition_a THEN value_1
        WHEN condition_b THEN value_2
        ELSE value_3
    END AS new_column_name
FROM table_a;

SELECT * FROM orders;


SELECT item_name,
	CASE 
		when item_name like '%bowl%' then 'is_bowl'
	end
from orders;

## going furhter
SELECT item_name,
	CASE 
		when item_name like '%bowl%' then 'is_bowl'
		else 'not_a_nowl'
	end as 'where_are_the_bowls'
from orders;


## no column name here after 'case', awlloing to look at two dif column names below
SELECT order_id, item_name,
	CASE 
		when item_name like '%bowl%' then 'is_bowl'
		when order_id = 1 then 'first_order'
		when item_name = 'Izze' then 'found_izze'
		else 'not_a_nowl'
	end as 'where_are_the_bowls'
from orders;

## different order of operations
SELECT order_id, item_name,
	CASE 
		when order_id = 1 then 'first_order'
		when item_name like '%bowl%' then 'is_bowl'
		when item_name = 'Izze' then 'found_izze'
		else 'not_a_nowl'
	end as 'where_are_the_bowls'
from orders;


## let's group quantities of items ordered ('quantity') by how many times ordered.
select quantity, count(*)
from orders
group by quantity
order by quantity;

## how many times a person ordered one specific item.
SELECT distinct quantity,
	case	
		when quantity >= 4 then 'big_orders'
		when quantity >= 2 then 'medium_orders'
		else 'single_orders'
	end as 'order_size'
from orders
order by quantity;


## using subquery to find number of each type of irder. (The categories for how many times a specific number of items were ordered.)
SELECT order_size_by_item, count(*) as count_of_size
from
	(SELECT distinct quantity,
		case	
			when quantity >= 4 then 'big_orders'
			when quantity >= 2 then 'medium_orders'
			else 'single_orders'
		end as 'order_size_by_item'
	from orders) 
AS o
-- subquery must have alias.
group by order_size_by_item;


## PIVOT TABLE ##

# let's find all of the chicken orders
select * from orders
where item_name like '%chicken%';

select distinct item_name from orders
where item_name like '%chicken%';

# look at chicken orders and quantity
select quantity, item_name from orders
where item_name like '%chicken%';

# building all of the columns
select quantity, item_name,
	case 
		when item_name = 'Chicken Bowl' then item_name
		else null
	end as 'Chicken Bowl' 
 from orders
where item_name like '%chicken%';


select quantity, item_name,
	case when item_name = 'Chicken Bowl' then item_name end as 'Chicken Bowl',	
	case when item_name = 'Chicken Crispy Tacos' then item_name end as 'Chicken Crispy Tacos',
	case when item_name = 'Chicken Burrito' then item_name else null end as 'Chicken Burrito',
	case when item_name = 'Chicken Salad Bowl' then item_name end as 'Chicken Salad Bowl'
 from orders
where item_name like '%chicken%';
-- the 'else null' statemetns are optional; the results are the same


# add group by and count

select quantity,
	count(case when item_name = 'Chicken Bowl' then item_name end) as 'Chicken Bowl',	
	count(case when item_name = 'Chicken Crispy Tacos' then item_name end) as 'Chicken Crispy Tacos',
	count(case when item_name = 'Chicken Burrito' then item_name  end) as ' Chicken Burrito',
	count(case when item_name = 'Chicken Salad Bowl' then item_name end) as 'Chicken Salad Bowl'
 from orders
where item_name like '%chicken%' # this line can be removed to get total quantities of everything.
group by quantity
order by quantity;


# something else
select item_name, count(*)
from orders
where item_name like '%chicken%'
group by item_name;