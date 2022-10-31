USE employees;

/*
	1. Current employees with same hire date as emp_no = 101010
*/
# Table with hire_date = employees
# Table with emp_no = employees
# Table with to_date & emp_no = dept_emp

SELECT * FROM employees LIMIT 10;

# SOURCE TABLE
# Demos Christ		1990-10-22
#
# 1990-10-22
SELECT CONCAT(first_name,' ',last_name), hire_date
FROM employees
WHERE emp_no=101010;

# WORKING TABLE
SELECT emp_no, to_date
FROM dept_emp;

SELECT CONCAT(first_name,' ',last_name), hire_date
		FROM employees
		WHERE emp_no=101010;

# SUBQUERY APPROACH
SELECT CONCAT(first_name,' ',last_name), hire_date, to_date
FROM employees as e
JOIN dept_emp as de ON de.emp_no = e.emp_no
WHERE
	hire_date=
		(
			SELECT hire_date
			FROM
			employees
			WHERE
			emp_no=101010
		) AND to_date LIKE '9999%';
# NO JOIN

# 69
select * from employees
WHERE hire_date =
(
	SELECT hire_date
	FROM employees
	WHERE emp_no=101010
) AND (SELECT to_date FROM dept_emp WHERE to_date LIKE '9999%');




SELECT CONCAT(first_name,' ',last_name)
FROM employees
#JOIN dept_emp as de ON de.emp_no = e.emp_no
WHERE
	hire_date=
		(
			SELECT hire_date
			FROM
			employees
			WHERE
			emp_no=101010
		) AND to_date LIKE '9999%';
/*
	2. Find all the titles ever held by all current employees with the first name Aamod.
*/
#
#	(All titles ever held) & (all current employees) & (TO_date on dept_emp) & (first name Aamod = emp_no)
#
#	employees  = emp_no
#	titles  = emp_no, title
#

SELECT * FROM dept_emp LIMIT 20;

# emp_no = Aamod
SELECT
to_date
FROM
dept_emp
WHERE 

emp_no(SELECT emp_no
FROM
	employees
WHERE first_name = 'Aamod');

#  2
# S O L U T I O N

SELECT * FROM employees LIMIT 20;
#LIST EMP_NO = Aamod
SELECT * FROM titles LIMIT 20;
#
SELECT FROM;

#
SELECT title, emp_no
FROM titles
WHERE emp_no IN (SELECT emp_no FROM employees WHERE first_name='Aamod');
#


#subquery employees table with dept_emp USING emp_no
SELECT *
FROM
dept_emp
WHERE emp_no IN (SELECT emp_no FROM employees WHERE first_name='Aamod')
HAVING to_date LIKE '9999%';
#subquery employees table with dept_emp USING emp_no
# M A I N
SELECT title, first_name
FROM(
		SELECT first_name, employees.emp_no
		FROM employees
		JOIN dept_emp AS de ON de.emp_no = employees.emp_no
		WHERE first_name = "Aamod"
			AND de.to_date > CURDATE()
	)AS e
JOIN titles AS t USING(emp_no);

# department name & employee name (JOIN)

SELECT g.birth_date, g.emp_no, g.first_name
from
(
    SELECT *
    FROM employees
    WHERE first_name like 'Geor%'
) as g;

/*
	3. How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.
*/
#  (91,479)
SELECT * FROM dept_emp WHERE to_date NOT LIKE '9999%';
SELECT * FROM employees LIMIT 5; WHERE to_date NOT LIKE '9999%';

#  (85,108)
SELECT DISTINCT *
FROM employees
WHERE
emp_no IN
		(
			SELECT 
				emp_no
			FROM
				dept_emp
			WHERE
				to_date NOT LIKE '9999%'
		);
/*
	4. Find all the current department managers that are female
*/
SELECT * FROM dept_manager LIMIT 20;

SELECT last_name, first_name
FROM employees
WHERE emp_no IN
(
	SELECT emp_no
	FROM dept_manager	
	WHERE
	to_date LIKE '9999%'
) AND gender='F';
# Legleitner	Isamu
# Sigstam		Karsten
# DasSarma	Leon
# Kambil		Hilary

/*
	5. Find all the employees who currently have a higher salary than the companies overall, historical average salary.
*/
SELECT salary FROM salaries WHERE salary>(SELECT AVG(salary) FROM salaries) AND to_date LIKE '9999%';
#
#
#  154,543
#
#
SELECT 
  emp_no, salary 
FROM 
  salaries 
WHERE 
  salary > (
    SELECT 
      AVG(salary) 
    FROM 
      salaries
  ) AND to_date LIKE '9999%';
#
#  WITH NAMES
#
SELECT
	last_name, first_name
FROM
	employees 
WHERE
	emp_no = (
				SELECT
						emp_no
				FROM
					salaries
				WHERE
						salary=(
									SELECT
										MAX(salary)
									FROM
										salaries
								)
					AND
						to_date LIKE '9999%'
					
			);
/*
	6. How many current salaries are within 1 standard deviation of the current highest salary
*/
SELECT
	emp_no, salary
FROM
	salaries
WHERE
	salary >=
			(
			SELECT
				(MAX(salary)-STDDEV(salary))
			FROM
				salaries
			WHERE
				to_date LIKE '9999%'
			)
	AND
		to_date LIKE '9999%'
ORDER BY
	salary DESC;

-- Bonus Question #1
-- Find all the department names that currently have female managers.
-- All employees table:
-- Sub-query deparment managers emp_no from dept_manager table
SELECT * FROM titles LIMIT 5;
SELECT 
  e.first_name, e.last_name, t.title, dept_name, e.gender 
FROM 
  employees as e 
  JOIN titles as t ON t.emp_no = e.emp_no
  JOIN dept_emp as de ON de.emp_no = t.emp_no
  JOIN departments as d ON d.dept_no = de.dept_no
WHERE 
  e.emp_no in (
			SELECT 
				emp_no 
			FROM 
				dept_manager 
			WHERE 
      			to_date LIKE '9999%'
			) 
  AND gender = 'F' 
  AND de.to_date LIKE '9999%' AND t.to_date LIKE '9999%';
  


-- Bonus Question #2
-- All employees table:
-- Sub-query emp_no table using salary column from salaries table
SELECT
	emp_no, first_name, last_name, salary, to_date
FROM
	employees as e 
 	JOIN salaries as s USING(emp_no) 
WHERE 
	salary=(select MAX(salary) FROM salaries WHERE to_date LIKE '9999%') AND to_date Like '9999%';
	
-- Bonus Question #3
-- All employees table:
-- Sub-query emp_no using salary column from salaries table
SELECT
	dept_name
FROM
	dept_emp as de
	JOIN departments as d USING(dept_no)
WHERE 
	emp_no=(
					SELECT
						emp_no
					FROM
						salaries
					WHERE
						salary=(
										SELECT
											max(salary)
										FROM
											salaries
								)
						AND to_date LIKE '9999%'
				)
	AND de.to_date LIKE '9999%';
