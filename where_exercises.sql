SHOW DATABASES;
USE employees;
SELECT DATABASE();
-- 2. 
SELECT first_name, last_name FROM employees WHERE first_name IN ('Irene','Vidya','Maya');
SELECT COUNT(first_name) FROM employees WHERE first_name IN ('Irene','Vidya','Maya');
-- 731 records found
-- 3. 
SELECT first_name, last_name FROM employees WHERE first_name ='Irene' OR first_name = 'Vidya' OR first_name = 'Maya';
SELECT COUNT(first_name) FROM employees WHERE first_name ='Irene' OR first_name = 'Vidya' OR first_name = 'Maya';
-- 731 records found
-- 4.
SELECT first_name, last_name FROM employees WHERE (first_name ='Irene' OR first_name = 'Vidya' OR first_name = 'Maya') AND gender='M';
SELECT COUNT(first_name) FROM employees WHERE (first_name ='Irene' OR first_name = 'Vidya' OR first_name = 'Maya') AND gender='M';
-- 455 Records found matching names and gender M
-- 5.
SELECT last_name FROM employees WHERE last_name LIKE 'e%';
SELECT COUNT(last_name) FROM employees WHERE last_name LIKE 'e%';
-- 7330 records found with last_name starting with 'e'
-- 6.
SELECT last_name FROM employees WHERE last_name LIKE 'e%' OR last_name LIKE '%e';
SELECT COUNT(last_name) FROM employees WHERE last_name LIKE '%e' AND last_name NOT LIKE 'e%';
-- 23393 records found with last_name ONLY ending with 'e'
-- 7. 
SELECT last_name FROM employees WHERE last_name LIKE 'e%' AND last_name LIKE '%e';
SELECT COUNT(last_name) FROM employees WHERE last_name LIKE '%e';
-- 24292 records found with last_name ending with with 'e'
-- 8. 
SELECT last_name, hire_date FROM employees WHERE hire_date LIKE '199%';
SELECT COUNT(hire_date) FROM employees WHERE hire_date LIKE '199%';
-- 135214 records found of employees hired in the 90's
-- 9.
SELECT last_name, birth_date FROM employees WHERE birth_date LIKE '%-12-25';
SELECT COUNT(birth_date) FROM employees WHERE birth_date LIKE '%-12-25';
-- 842 record found with birthdate on christmas
-- 10.
SELECT last_name, birth_date, hire_date FROM employees WHERE (birth_date LIKE '%-12-25') AND (hire_date LIKE '199%');
SELECT COUNT(last_name) FROM employees WHERE (birth_date LIKE '%-12-25') AND (hire_date LIKE '199%');
-- 362 records found with employes hired in 90's with birthday on christmas
-- 11.
SELECT last_name FROM employees WHERE last_name LIKE '%q%';
SELECT COUNT(last_name) FROM employees WHERE last_name LIKE '%q%';
-- 1873 records found with q in last_name
-- 12.
SELECT last_name FROM employees WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%';
SELECT COUNT(last_name) FROM employees WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%';
-- 547 records found with q in last_name but not 'qu'