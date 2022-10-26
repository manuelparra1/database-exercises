USE employees;
SELECT * FROM titles LIMIT 5;

# 2. unique titles in the titles table
SELECT DISTINCT title FROM titles;
# (7) unique titles found in table

# 3. 
SELECT last_name FROM employees WHERE last_name LIKE 'e%e' GROUP BY last_name;

# 4.
SELECT DISTINCT CONCAT(first_name, ' ', last_name) FROM employees WHERE last_name LIKE 'e%e';

# 5.
SELECT DISTINCT last_name FROM employees WHERE (last_name LIKE 'q%' AND last_name NOT LIKE 'qu%');
# Names with 'q' and not 'qu'

# 6.
SELECT last_name, COUNT(last_name) FROM employees GROUP BY last_name ORDER BY last_name;

# 7.
SELECT first_name AS 'First Name', gender AS 'Gender', count(*) AS 'Total' FROM employees WHERE first_name IN ('Irena', 'Vidya', 'Maya') GROUP BY first_name, gender ORDER BY first_name, gender;

/*

8a. username for all of the employees

*/
SELECT
CONCAT(
	LOWER(SUBSTR(first_name,1,1)),
	LOWER(SUBSTR(last_name,1,4)), '_',
	DATE_FORMAT(birth_date,'%m'),
	DATE_FORMAT(birth_date,'%y')

)AS 'username',
COUNT(
	CONCAT(
		LOWER(SUBSTR(first_name,1,1)),
		LOWER(SUBSTR(last_name,1,4)), '_',
		DATE_FORMAT(birth_date,'%m'),
		DATE_FORMAT(birth_date,'%y')
)
)AS 'count'
FROM employees
GROUP BY username
ORDER BY count DESC;
# 285,872 Unique usernames

/*
	8b.
	count duplicate usernames for username column
*/
SELECT
CONCAT(
	LOWER(SUBSTR(first_name,1,1)),
	LOWER(SUBSTR(last_name,1,4)), '_',
	DATE_FORMAT(birth_date,'%m'),
	DATE_FORMAT(birth_date,'%y')
)AS 'username',
COUNT(
	CONCAT(
		LOWER(SUBSTR(first_name,1,1)),
		LOWER(SUBSTR(last_name,1,4)), '_',
		DATE_FORMAT(birth_date,'%m'),
		DATE_FORMAT(birth_date,'%y')
)
)AS 'count'
FROM employees
GROUP BY username
HAVING count > 1
ORDER BY count DESC;
# 13,251 Results

/*
	8c.
	count duplicate usernames for username column
*/
# 13,251 Results

#	9a. avg() salary each employee
SELECT 
  emp_no, 
  AVG(salary) AS 'Salary Average' 
FROM 
  salaries 
GROUP BY 
  emp_no;
#	9b. Total count of all current employees in each department
SELECT 
  dept_no, 
  count(emp_no) AS 'Total Employees' 
FROM 
  dept_emp 
GROUP BY 
  dept_no;
# 9c. different salaries for each employee
SELECT emp_no, COUNT(salary) AS 'Total Different Salaries' FROM salaries GROUP BY emp_no;

# 9d. max salary for each employee
SELECT emp_no, MAX(salary) AS 'Highest Salary' FROM salaries GROUP BY emp_no;

# 9e. min salary for each employee
SELECT emp_no, MIN(salary) AS 'Lowest Salary' FROM salaries GROUP BY emp_no;

# 9f. standard deviation for each employee salary
SELECT emp_no, STDDEV(salary) AS 'STDEV Salary' FROM salaries GROUP BY emp_no;

# 9e.
SELECT * FROM salaries LIMIT 20;
SELECT emp_no, MAX(salary) AS 'Max Salary > 150k' FROM salaries GROUP BY emp_no HAVING MAX(salary) > 150000;

# 9f. Average salary for each employee from 80k to 90k
SELECT emp_no, AVG(salary) AS 'Salary Average' FROM salaries GROUP BY emp_no HAVING (AVG(salary) >= 80000 AND AVG(salary)<= 90000);
