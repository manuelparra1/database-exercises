SHOW DATABASES;
USE `employees`;
SELECT DATABASE();

# 2.
SELECT DISTINCT last_name FROM employees ORDER BY last_name DESC LIMIT 10;

# 3. 
SELECT DISTINCT last_name, first_name, hire_date, birth_date FROM employees WHERE hire_date LIKE '199%' AND birth_date LIKE '%-12-25' ORDER BY hire_date LIMIT 5;
/*

Cappello	Alselm	1990-01-01	1962-12-25
Mandell	Utz	1990-01-03	1960-12-25
Schreiter	Bouchung	1990-01-04	1963-12-25
Kushner	Baocai	1990-01-05	1959-12-25
Stroustrup	Petter	1990-01-10	1959-12-25

*/
/* 

4. 
Offset would remove a certain number of "pages" and limit would show a specific amount data of the current page. So if pages are 5 rows and we remove 9 pages to be on the 10th, then we would remove 45 rows.  If we limit the amount returned to 5 then we would show the 10th page. If more than 5 rows are shown then we would be showing 1 page + the amount of the next page. Assuming we format our pages by 5 rows.  Limit amount is equal to the page amount we decide to use.

*/