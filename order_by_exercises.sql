SHOW DATABASES;
USE employees;
SELECT DATABASE();
# 2. 
SELECT first_name, last_name FROM employees WHERE first_name IN ('Irene','Vidya','Maya') ORDER BY first_name;
# Irene Radhakrishnan
# Vidya Simmen
# 3. 
SELECT first_name, last_name FROM employees WHERE first_name IN ('Irene','Vidya','Maya') ORDER BY first_name, last_name;
# Irene Aingworth
# Vidya Zweizig
# 4.
SELECT first_name, last_name FROM employees WHERE first_name IN ('Irene','Vidya','Maya') ORDER BY last_name, first_name;
# Irene Aingworth
# Maya Zyda
# 5.
SELECT emp_no, first_name, last_name FROM employees WHERE last_name LIKE 'e%' AND last_name LIKE '%e' ORDER BY emp_no;
# 10021 Ramzi Erde
# 499994 Tadahiro Erde
# 6. 
SELECT first_name, last_name, hire_date FROM employees ORDER BY hire_date DESC;
# Bikash Covnot 2000-01-28 Newest
# Tonny Butterworth 1985-01-01 Oldest
SELECT * FROM employees LIMIT 1;
# 7.
SELECT first_name, last_name, birth_date, hire_date FROM employees WHERE (birth_date LIKE '%-12-25') AND (hire_date LIKE '199%') ORDER BY hire_date DESC, birth_date ASC;
SELECT COUNT(first_name) FROM employees WHERE (birth_date LIKE '%-12-25') AND (hire_date LIKE '199%') ORDER BY hire_date DESC, birth_date ASC;

# 362 Records found with employees birthday on christmas and hired in the 90's
# Khun Bernini oldest hired last
# Alselm Cappello youngest hired 1st
