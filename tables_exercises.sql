USE employees;
SELECT database();
SHOW CREATE DATABASE employees;
SHOW CREATE TABLE employees;

/* 5. This table has employee birthdate, first and last name, gender, employee number and hire date.
6. Which table(s) do you think contain a numeric- column? The employee number would contain numeric column types. The gender could possibly be a numeric-type column, depending on how the question was posed and answered.
7. Which table(s) do you think contain a string type column? The employee first and last name would be a string-type column. The gender could possibly be a string-type column, depending on how the question was posed and answered.
8. Which table(s) do you think contain a date type column? The birthdate and hire date would contain a date-type column.
9. What is the relationship between the employees and the departments tables? The employee number from the 'employees' table is a column in the 'dept_emp' and the 'dept_manager' tables. Both the 'dept_emp' and the 'dept_manager' tables have a 'dept_no' column. */
SHOW CREATE TABLE dept_emp;
SHOW CREATE TABLE dept_manager;
/* line 12 shows the SQL that crated the 'dept_manager' table. It is copied here :
CREATE TABLE `dept_manager` (
  `emp_no` int NOT NULL,
  `dept_no` char(4) NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  PRIMARY KEY (`emp_no`,`dept_no`),
  KEY `dept_no` (`dept_no`),
  CONSTRAINT `dept_manager_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `dept_manager_ibfk_2` FOREIGN KEY (`dept_no`) REFERENCES `departments` (`dept_no`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=latin1
*/

