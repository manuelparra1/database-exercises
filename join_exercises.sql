SHOW DATABASES;
USE `join_example_db`;
SELECT DATABASE();
/*
	 Inner Join
*/
SELECT
	* 
FROM roles AS A
JOIN users AS B
	ON B.role_id = A.id
LIMIT 10;


/*
	 Left Join
*/
SELECT
	* 
FROM roles AS A
LEFT JOIN users AS B
	ON B.role_id = A.id
LIMIT 10;

/*
	 Right Join
*/
SELECT
	* 
FROM roles AS A
RIGHT JOIN users AS B
	ON B.role_id = A.id
LIMIT 10;

/*
	TEST
*/

SELECT 
	*
FROM
	users
LIMIT 10;

/*
	 How many users in each role?
*/
SELECT 
  r.name AS 'Departments',
  COUNT(*) AS 'Total Users'
FROM 
  roles AS r
  LEFT JOIN users AS u ON u.role_id = r.id
GROUP BY r.name;

/*
	 Employees Database Exercises
	 =============================
*/

SHOW DATABASES;
USE `employees`;
SELECT DATABASE();

/*
	 2. Department Name and current Manager
*/

SELECT 
  d.dept_name AS 'Department Name', 
  CONCAT(e.first_name, ' ', e.last_name) AS 'Full Name' 
FROM 
  employees AS e 
  JOIN dept_manager AS dm ON dm.emp_no = e.emp_no 
  JOIN departments AS d ON d.dept_no = m.dept_no 
WHERE 
  m.to_date LIKE '9999%' 
ORDER BY 
  d.dept_name ASC;

# JOIN dept_manager AS dm on e.emp_no = dm.emp_no AND to_date > CURDATE()
# JOIN departments AS d USING(dept_no)
# USING() DROPS DUPLICATE COLUMNS

/*
	 3. Department Names + Female Managers
*/

SELECT 
  d.dept_name AS 'Department Name', 
  CONCAT(e.first_name, ' ', e.last_name) AS 'Full Name', 
  e.gender AS 'Gender' 
FROM 
  employees AS e 
  JOIN dept_manager AS dm ON dm.emp_no = e.emp_no 
  JOIN departments AS d ON d.dept_no = dm.dept_no 
WHERE 
  dm.to_date LIKE '9999%' 
  AND e.gender = 'F' 
ORDER BY 
  d.dept_name ASC;
#  DIFFERENT EXAMPLE ON JOIN + AND
#  -------------------------------
#  JOIN dept_manager AS dm ON dm.emp_no = e.emp_no 
#  AND to Date > CURDATE() 
#  AND gender = 'F'

/*
	 4. Current Customer Service Employees
*/

SELECT
  t.title AS 'Title', 
  count(t.title) AS 'Count' 
FROM 
  titles AS t 
  JOIN dept_emp AS de ON de.emp_no = t.emp_no 
  JOIN departments AS d ON d.dept_no = de.dept_no 
WHERE 
  (
    t.to_date LIKE '9999%' 
    AND de.to_date LIKE '9999%' 
    AND d.dept_name = 'Customer Service'
  ) 
GROUP BY 
  t.title 
ORDER BY 
  t.title;

/*
	 5. Current salary of all current managers
*/
SELECT 
  d.dept_name AS 'Department Name', 
  CONCAT(e.first_name, ' ', e.last_name) AS 'Name', 
  s.salary AS 'Salary'
FROM 
  departments AS d
  JOIN dept_emp AS de USING(dept_no)
  JOIN employees AS e ON e.`emp_no` = de.`emp_no`
  JOIN salaries AS s ON s.emp_no = e.emp_no
  JOIN titles AS t ON t.emp_no = s.emp_no
WHERE
	t.title = 'Manager' AND t.to_date LIKE '9999%' AND s.to_date > CURDATE()
ORDER BY
	d.dept_name;

/*
	 6. Current Employees in each department
*/
SELECT
	de.dept_no AS dept_no,
	d.dept_name AS dept_name,
	count(*) AS 'num_employees'
FROM
	departments as d
	JOIN dept_emp AS de ON de.dept_no = d.dept_no
WHERE
	de.to_date LIKE '9999%'
GROUP BY
	d.dept_name
ORDER BY
	d.dept_no ASC;
	
/*
	 7. MAX Average Salary each Deparment
*/
# Come back later and figure out how to use MAX()

SELECT
	d.dept_name AS dept_name,
	AVG(s.salary) AS average_salary
FROM
	salaries AS s
JOIN
	dept_emp as de ON de.emp_no = s.emp_no
JOIN
	departments as d ON d.dept_no = de.dept_no
WHERE
	s.to_date LIKE '9999%' AND de.to_date LIKE '9999%'
GROUP BY
	d.dept_name
ORDER BY
	average_salary DESC
LIMIT
	1;

/*
	 8. Highest paid employee in Marketing  D U S T   V E R S I O N
*/
#   VERY IMPORTANT N O T  TO  ASSIGN VARIABLES TO THEMSELVES
#
SELECT
	e.first_name AS first_name,
	e.last_name AS last_name,
	s.salary AS 'Salary',
	d.dept_name AS 'Department Name'
FROM
	salaries AS s
JOIN
	employees AS e ON e.emp_no = s.emp_no
JOIN
	dept_emp AS de ON de.emp_no = e.emp_no
JOIN
	departments AS d ON d.dept_no = de.dept_no
WHERE 
  s.to_date LIKE '9999%' 
  AND d.dept_name = 'Marketing' 
  AND de.to_date LIKE '9999%' 
  AND d.dept_name = 'Marketing' 
ORDER BY 
  s.salary DESC
LIMIT 1;

# TEST QUERIES
SELECT * FROM dept_emp WHERE emp_no = 43624; #d007
SELECT * FROM dept_emp WHERE emp_no = 415619;

SELECT * FROM employees WHERE last_name='Pesch' AND first_name='Tokuyasu';
SELECT * FROM employees WHERE last_name='Warwick' AND emp_no = 466852;
#43624
#415619

/*
	 8. Highest paid employee in Marketing   S H A W N   V E R S I O N
*/
#   RESEARCH LATER FOR JOININGTABLES ORDER, AND "NATURAL" FILTERING
#   Initial FROM table sshould have the most information
SELECT
	e.first_name, e.last_name
FROM
	employees AS e
JOIN
	salaries AS s ON s.emp_no = e.emp_no
JOIN
	dept_emp AS de ON de.emp_no = s.emp_no
JOIN
	departments AS d ON d.dept_no = de.dept_no
WHERE
	s.to_date LIKE '9999%' AND d.dept_name = 'Marketing' AND de.to_date LIKE '9999%'
ORDER BY
	s.salary DESC
LIMIT
	1;


/*
	 9. Current department manager has the highest salary
*/

SELECT
	e.first_name AS first_name,
	e.last_name AS last_name,
	s.salary AS salary,
	d.dept_name AS dept_name
FROM
	employees AS e
JOIN
	salaries as s ON s.emp_no = e.emp_no
JOIN
	dept_emp as de ON de.emp_no = s.emp_no
JOIN
	departments as d ON d.dept_no = de.dept_no
JOIN
	titles as t ON t.emp_no = e.emp_no
WHERE
	t.title = 'Manager' AND t.to_date LIKE '9999%' AND s.to_date LIKE '9999%'
ORDER BY
	s.salary DESC
LIMIT 1;
/*
	 10. Average Salary in each department
*/
SELECT
	d.dept_name AS dept_name,
	ROUND(AVG(s.salary)) AS average_salary
FROM
	salaries AS s
JOIN
	employees as e ON e.emp_no = s.emp_no
JOIN
	dept_emp as de ON de.emp_no = s.emp_no
JOIN
	departments as d ON d.dept_no = de.dept_no
GROUP BY
	d.dept_name
ORDER BY
	average_salary DESC;
/*
	 11. Current Employees, Department Name, Current Manager
*/
SELECT * FROM salaries LIMIT 25;
SELECT
	CONCAT(e.first_name,' ',e.last_name) AS 'Employee Name',
	d.dept_name AS 'Department Name',
	CONCAT(e.first_name,' ',e.last_name) AS 'Manager Name'
FROM
	employees as e
JOIN 
	
JOIN
	departments as d ON d.dept_no
GROUP BY
manager name
;

/*
	 12. Highest Paid Employee Each Department
*/
SELECT
	#CONCAT(e.first_name,' ',e.last_name) AS 'Employee Name',
	d.dept_name AS 'Department Name',
	MAX(s.salary) AS 'Highest Salary'
FROM
	salaries as s
JOIN
	employees as e ON e.emp_no = s.emp_no
JOIN
	dept_emp as de ON de.emp_no = e.emp_no
JOIN
	departments as d ON d.dept_no = de.dept_no
GROUP BY
	d.dept_name;
