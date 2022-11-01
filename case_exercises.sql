use employees;
select * from departments
limit 30;
describe employees; 
describe departments; -- dept_no, dept_name
describe dept_emp; -- emp_no, dept_no, from_date, to_date
/* 1.    Write a query that returns all employees, their department number, their start date, their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not. */

## class solution
select first_name, last_name, dept_no, from_date, to_date, to_date > now() as 'is_current_employee'
 from employees
join dept_emp using(emp_no);
## class solution

## this is mine ; it works the same as above.
select emp_no, dept_no, from_date, to_date,
	if(to_date > NOW(), true, false)
	as is_current_emplolyee
from dept_emp
order by to_date;
# or : to_date like '9999-01-01',


/* 2.    Write a query that returns all employee names (previous and current), and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name. */

select first_name, last_name from employees;


## these two are mine ; they return the same results ##
select first_name, last_name,
	case
		when last_name <= 'H' then 'A_to_H'
		when last_name <= 'Q' then 'I_to_Q'
		when last_name <= 'Z' then 'R_to_Z'
	end as alpha_group
from employees
order by last_name;


select first_name, last_name,
	case
		when left(upper(last_name), 1) between 'a' and 'h' then 'A_to_H'
		when left(upper(last_name), 1) between 'i' and 'q' then 'I_to_Q'
		when left(upper(last_name), 1) between 'r' and 'z' then 'R_to_Z'
	end as alpha_group
from employees
order by last_name;


## class example ##
select first_name, last_name, -- left(last_name, 1), substr(last_name, 1,1), 
	case
		when left(last_name, 1) <= 'h' then 'a-h' -- or : when last_name <= 'H' then 'A-H'
		when left(last_name, 1) <= 'q' then 'i-q'
		else 'r-z'
	end as 'alpha_group'
from employees
limit 1000;




/* 3.    How many employees (current or previous) were born in each decade? */

select birth_date
from employees
order by birth_date asc;

select birth_date,
	case
		when birth_date like '195%-%%-%%' then '1950s'
		when birth_date like '196%-%%-%%' then '1960s'
	end as 'decades'
from employees
order by birth_date;
## this works, but simply categorises each bd into its decade.


select birth_date,
	count(case when birth_date like '195%' then birth_date end) as '1950s',
	count(case when birth_date like '196%' then birth_date end) as '1960s'
from employees
group by birth_date
order by birth_date;
## this works, but groups by actual birth date count, not by total number in a decade

select birth_date, count(*) as 'decade_count'
from (	select birth_date,
			count(case when birth_date like '195%' then birth_date end) as '1950s',
			count(case when birth_date like '196%' then birth_date end) as '1960s'
		from employees
		group by birth_date
		order by birth_date)
as o
group by birth_date;
## this works, but it returns a boolean T/F for each individual birth date being in its decade.


select birth_date, count(*) as 'decade_count'
from (	select birth_date,
			sum(case when birth_date like '195%' then birth_date end) as '1950s',
			sum(case when birth_date like '196%' then birth_date end) as '1960s'
		from employees
		group by birth_date
		order by birth_date
		)
as o
group by birth_date;
# RETURNS SAME AS ABOVE : BOOLEAN T / F
# SUM(COUNT(CASE...)) RETURNS AN INVALID USE OF GROUP FUNCTION ERROR. SO DOES COUNT(SUM(CASE...)).



-- this is SS's correct answer. Only one variable, so don't need to have a subquery.
select count(*),
case
	when birth_date like '195%' then '1950s'
	when birth_date like '196%' then '1960s'
	end as 'decade_born'
from employees
group by decade_born;
-- this is SS's correct answer.



select birth_date, count(*)
from employees
where birth_date like '195%'
group by birth_date;



## class example :
## how many employees born in each decade ?
select min(birth_date), max(birth_date) from employees;

## create a subquery
select birth_date ,
	case
		when birth_date >= '1960-01-01' then '60s'
		when birth_date >= '1950-01-01' then '50s'
	end as 'birth_decade'
from employees
limit 1000;

## full answer
select birth_decade, count(*) as num_births
from
	(select birth_date,
	case
		when birth_date >= '1960-01-01' then '60s'
		when birth_date >= '1950-01-01' then '50s'
	end as 'birth_decade'
from employees ) as e
group by birth_decade
limit 1000;


/* 4.    What is the current average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service? */
describe departments; -- dept_no, dept_name
describe dept_emp; -- emp_no, dept_no, from_date, to_date
describe salaries; -- emp_no, salary, to_date


select dept_emp.emp_no, dept_emp.dept_no, salaries.salary, departments.dept_name, salaries.to_date from dept_emp
join salaries USING(emp_no)
join departments using(dept_no)
limit 15;


select salary, dp.dept_no, dp.dept_name
from salaries
join dept_emp as de using(emp_no)
join departments as dp using(dept_no)
group by salary, dp.dept_no, dp.dept_name
limit 10;


SELECT AVG(salary) as 'Depts_Avg_Salary'
FROM (
	select dept_emp.emp_no, dept_emp.dept_no, salaries.salary, departments.dept_name, 	salaries.to_date from dept_emp
	join salaries USING(emp_no)
	join departments using(dept_no)
) 
as o;
## this gives the average salary of all departments.


select dept_name,
	case
		when dept_name = 'Research' then dept_name
		when dept_name = 'Development' then dept_name
		when dept_name = 'Production' then dept_name
		when dept_name = 'Quality Management' then dept_name
		when dept_name = 'Sales' then dept_name
		when dept_name = 'Human Resources' then dept_name
		when dept_name = 'Finance' then dept_name
		when dept_name = 'Customer Servuce' then dept_name
	end as 'dept_salary_avg'
from departments
join dept_emp using(dept_no)
join salaries using(emp_no);
# this outputs a filled dept_name column and a null-filled dept_salary_avg colun


SELECT AVG(salary)
FROM (
	select dept_name,
	case
		when dept_name = 'Research' then dept_name
		when dept_name = 'Development' then dept_name
		when dept_name = 'Production' then dept_name
		when dept_name = 'Quality Management' then dept_name
		when dept_name = 'Sales' then dept_name
		when dept_name = 'Human Resources' then dept_name
		when dept_name = 'Finance' then dept_name
		when dept_name = 'Customer Servuce' then dept_name
	end as 'dept_salary_avg'
	from departments
	join dept_emp using(dept_no)
	join salaries using(emp_no)
	)
as o;
# unknown column 'salary' in 'field list'. I need to get the salary into the subquery.


## class example ##

## step one
select * ,
	case 
		when dept_name in ('Research', 'Development') then 'R & D'
		when dept_name in ('Marketing', 'Sales') then 'Sales'
		when dept_name in ('Production', 'Quality Management') then 'Prod & QM'
		when dept_name in ('Finance', 'Human Resources') then 'Finance & HR'
		else 'Customer Service'
	end as 'Grouped_Depts'
from departments
	join dept_emp as de using(dept_no)
	join salaries as s using(emp_no)
where de.to_date > NOW()
	and s.to_date > NOW()
limit 1000;

## step two
select 
	case 
		when dept_name in ('Research', 'Development') then 'R & D'
		when dept_name in ('Marketing', 'Sales') then 'Sales'
		when dept_name in ('Production', 'Quality Management') then 'Prod & QM'
		when dept_name in ('Finance', 'Human Resources') then 'Finance & HR'
		else 'Customer Service'
	end as 'Grouped_Depts', round(avg(salary),2) as 'mean_salary'
from departments
	join dept_emp as de using(dept_no)
	join salaries as s using(emp_no)
where de.to_date > NOW()
	and s.to_date > NOW()
group by Grouped_Depts;
