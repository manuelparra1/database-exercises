USE employees;
SELECT * FROM titles LIMIT 5;

# 2. 
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
SELECT * FROM employees LIMIT 10;

#SELECT last_name, gender, COUNT(last_name) FROM employees WHERE last_name IN ('Irena', 'Vidya', 'Maya') GROUP BY last_name;

SELECT first_name, gender FROM employees WHERE first_name IN ('Irena', 'Vidya', 'Maya'); #GROUP BY first_name;

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

) AS 'count'
FROM employees
GROUP BY username;
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

) AS 'count'
FROM employees
GROUP BY username
HAVING count > 1;
# 13,251 Results

/*
	8c.
	count duplicate usernames for username column
*/
# 13,251 Results

#	9a. avg() salary each employee
SELECT emp_no, AVG(salary) AS 'Salary Average' FROM salaries GROUP BY emp_no;
#	9b. count current employees in each department
SELECT * FROM dept_emp GROUP BY dept_no;
