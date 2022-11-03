SHOW DATABASES;
USE employees;
SELECT DATABASE();

/*
	1. Write a query that returns all employees, their department number, 
		their start date, their end date, and a new column 'is_current_employee'
		that is a 1 if the employee is still with the company and 0 if not.
		
		300,124
		vs
		331,603
		
		REMOVE DUPLICATES
		MAX(de.to_date)
*/

SELECT		first_name, last_name, de.dept_no, de.from_date, de.to_date,
			-- to_date > now()
			CASE
				WHEN de.to_date LIKE '9999%' THEN True
			ELSE
			False
			END AS 'is_current_employee'				
FROM		employees
JOIN		dept_emp AS de USING(emp_no)
ORDER BY	first_name, last_name;

/*
	2. Write a query that returns all employee names (previous and current), 
		and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' 
		depending on the first letter of their last name.
*/

SELECT		emp_no, first_name, last_name,
			CASE 
				WHEN LEFT(first_name,1) BETWEEN 'A' AND 'H'	THEN 'A-H'
				WHEN LEFT(first_name,1) BETWEEN 'I' AND 'Q'	THEN 'I-Q'
				WHEN LEFT(first_name,1) BETWEEN 'R' AND 'Z'	THEN 'R-Z'
			END AS 'alpha_group'
FROM 		employees
JOIN 		dept_emp AS de USING(emp_no)
ORDER BY first_name, last_name
LIMIT 50;

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
		END AS 'Decades', 
		count(*) AS 'Total'
FROM employees
GROUP BY decades
;


/*
	4. What is the current average salary for each of the following department groups: 
		R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?
*/
SELECT	CASE
			WHEN dept_name IN ('Sales', 'Marketing') THEN 'Sales & Marketing'
			WHEN dept_name IN ('Research', 'Development') THEN 'R&D'
			WHEN dept_name IN ('Production', 'Quality Management') THEN 'Prod & QM'
			WHEN dept_name IN ('Finance','Human Resources') THEN 'Finance & HR'
			WHEN dept_name IN ('Customer Service') THEN 'Customer Service'
			ELSE dept_name
		END as dept_group,
		AVG(salary)
FROM 	dept_emp as de
	JOIN 	departments as d USING(dept_no)
	JOIN 	salaries as s USING(emp_no)
WHERE de.to_date>NOW()
		AND s.to_date>NOW()
GROUP BY	dept_group
;