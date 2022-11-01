USE employees;
#USE noether_2034.employees_with_department;

DROP TEMPORARY TABLE IF EXISTS noether_2034.employees_with_department;

CREATE TEMPORARY TABLE noether_2034.employees_with_department AS (
	SELECT first_name, last_name, dept_name
	FROM employees
	JOIN dept_emp USING(emp_no)
	JOIN departments USING(dept_no)
);
SELECT * FROM noether_2034.employees_with_department LIMIT 10;

-- ADD COLUMN
DESCRIBE noether_2034.employees_with_department;
ALTER TABLE noether_2034.employees_with_department ADD full_name VARCHAR(30);
SELECT * FROM noether_2034.employees_with_department LIMIT 10;
-- UPDATE COLUMN VALUES
UPDATE noether_2034.employees_with_department SET full_name = CONCAT(first_name,' ',last_name);
SELECT * FROM noether_2034.employees_with_department LIMIT 5;
-- UPDATE COLUMN VALUES
ALTER TABLE noether_2034.employees_with_department DROP first_name;
ALTER TABLE noether_2034.employees_with_department DROP last_name;
-- OR
# TABLE noether_2034.employees_with_department DROP first_name, DROP last_name;

/*
	2. Create a temporary table based on the payment table from the sakila database.
	
	Write the SQL necessary to transform the amount column such that it is stored as an 
	integer representing the number of cents of the payment. For 	example, 1.99 should become 199.
*/
USE sakila;
SELECT * FROM payment LIMIT 5;

CREATE TEMPORARY TABLE noether_2034.temp_payment AS (
SELECT amount FROM payment);

SELECT * FROM noether_2034.temp_payment LIMIT 10;
-- CAST DOES NOT DO INT. INT = UNSIGNED
SELECT CAST(amount*100 AS UNSIGNED) AS CENTS
FROM noether_2034.temp_payment;

/*
	3. Find out how the current average pay in each department compares to the overall 
	current pay for everyone at the company. In order to make the 	comparison easier, you should use the Z-score for salaries. In terms of salary, 
	what is the best department right now to work for? The worst?
*/
USE employees;
SELECT 
	salary,
	(salary-(SELECT AVG(salary)) FROM salaries)
	/
	(SELECT stddev(salary) FROM salaries) AS zscore
FROM salaries;
