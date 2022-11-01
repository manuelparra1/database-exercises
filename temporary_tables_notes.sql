USE noether_2034;

DROP TABLE IF EXISTS my_numbers;

CREATE TEMPORARY TABLE my_numbers(
-- Name of 1st column is "n"
	n INT UNSIGNED NOT NULL,
	name VARCHAR(10) NOT NULL
);

SELECT * FROM my_numbers;

-- Insert data into my_numbers
INSERT INTO my_numbers(n, name)
VALUES(1,'a'), (2,'b'), (3, 'c'), (4,'d'),(5,'e');
SELECT * FROM my_numbers;

-- Delete from my_numbers
DELETE FROM my_numbers WHERE n>4;

SELECT * FROM my_numbers;

-- Transform our exiting data

UPDATE my_numbers SET n=n+1;
SELECT * FROM my_numbers;

-- Transform our existing data with a condition
UPDATE my_numbers SET n = n+10
WHERE name ='a';
SELECT * FROM my_numbers;

USE employees;
SELECT DATABASE();
SHOW TABLES;

-- Exploring table data from other database

SELECT emp_no, dept_no, first_name, last_name, salary, title
FROM employees AS E
	JOIN dept_emp AS de USING(emp_no)
	JOIN salaries AS s USING(emp_no)
	JOIN departments as d USING(dept_no)
	JOIN titles AS t using(emp_no)
WHERE de.to_date > NOW()
	AND s.to_date>NOW()
	AND t.to_date>NOW()
	AND dept_name = 'Customer Service';

/* ---------------------------------------
	 CREATE TEMPORARY TABLE FROM OTHER TABLE
	 ---------------------------------------
*/

CREATE TEMPORARY TABLE noether_2034.salary_info AS
	(
  SELECT 
    emp_no, dept_no, first_name, last_name, salary, title 
  FROM 
    employees AS E 
    JOIN dept_emp AS de USING(emp_no) 
    JOIN salaries AS s USING(emp_no) 
    JOIN departments as d USING(dept_no) 
    JOIN titles AS t using(emp_no) 
  WHERE 
    de.to_date > NOW() 
    AND s.to_date > NOW() 
    AND t.to_date > NOW() 
    AND dept_name = 'Customer Service'
	);

#. ----------------------------------------

SELECT * FROM noether_2034.salary_info;

-- What is the avearage salary for cuarrent employees in Customer Service
SELECT AVG(salary)
FROM noether_2034.salary_info;

-- ADD new columns to my temporary table
ALTER TABLE noether_2034.salary_info ADD avg_salary float;
ALTER TABLE noether_2034.salary_info ADD std_salary float;
ALTER TABLE noether_2034.salary_info ADD greater_than_avg int;
SELECT * FROM noether_2034.salary_info;

-- Update new columns
UPDATE noether_2034.salary_info SET avg_salary=67000;
SELECT * FROM noether_2034.salary_info;

UPDATE noether_2034.salary_info SET std_salary=16000;
UPDATE noether_2034.salary_info SET greater_than_avg=salary>avg_salary;

SELECT * FROM noether_2034.salary_info;

