SHOW DATABASES;
USE employees;
SELECT DATABASE();

/*
	1. Write a query that returns all employees, their department number, 
		their start date, their end date, and a new column 'is_current_employee'
		that is a 1 if the employee is still with the company and 0 if not.
*/

SELECT first_name, last_name, dept_no, from_date, to_date, de.to_date LIKE '9999%' AS 'still_with_company'
FROM employees
JOIN dept_emp AS de USING(emp_no)
LIMIT 5;

/*
	2. Write a query that returns all employee names (previous and current), 
		and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' 
		depending on the first letter of their last name.
*/

SELECT	first_name, last_name,
		CASE 
			WHEN first_name BETWEEN 'A' AND 'H'	THEN 'A-H'
			WHEN first_name BETWEEN 'I' AND 'Q'	THEN 'I-Q'
			WHEN first_name BETWEEN 'R' AND 'Z'	THEN 'R-Z'
		END AS 'alpha_group'
FROM employees
JOIN dept_emp AS de USING(emp_no)
LIMIT 5;

/*
	3. How many employees (current or previous) were born in each decade

*/

-- TESTING 
SELECT MIN(birth_date) FROM employees;
SELECT MAX(birth_date) FROM employees;

-- SOLUTION
SELECT	
		CASE 
			WHEN birth_date BETWEEN '1950-01-01' AND '1959-12-31'	THEN '50\'s'
			WHEN birth_date BETWEEN '1960-01-01' AND '1969-12-31'	THEN '60\'s'
		END AS 'decades', 
		count(*)
FROM employees
GROUP BY decades
;


/*
	4. What is the current average salary for each of the following department groups: 
		R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?
*/
SELECT dept_name, AVG(salary)
FROM employees
JOIN dept_emp as de USING(emp_no)
JOIN departments as d USING(dept_no)
JOIN salaries as s USING(emp_no)
GROUP BY dept_name
;
