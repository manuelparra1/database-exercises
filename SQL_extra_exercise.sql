USE sakila;


/*

  1. SELECT statements
  
*/

-- a.

SELECT * FROM customer LIMIT 5;

-- b.

SELECT last_name FROM customer;

-- c.
SELECT film_id, title, release_year FROM film;

/*

  2. DISTINCT operator
  
*/

-- Select all distinct (different) last names from the actor table.

SELECT DISTINCT last_name FROM actor;
-- Select all distinct (different) postal codes from the address table.
SELECT DISTINCT postal_code FROM address;
-- Select all distinct (different) ratings from the film table.
SELECT DISTINCT rating FROM film;

/*

  3. WHERE clause
  
*/
-- a. 

SELECT title, description, rating, length
FROM  film
WHERE length >= 180;

-- b.

SELECT payment_id, amount, payment_date
FROM payment
WHERE payment_date >= 2005-05-27;


-- c.
SELECT payment_id, amount, payment_date
FROM payment
WHERE payment_date = 2005-05-27;
SELECT * FROM customer;

-- d.
SELECT *
FROM customer 
WHERE last_name LIKE 'S%' AND first_name LIKE '%N';

-- e.

Select all columns from the customer table for rows 
where the customer is inactive or has a last name beginning with "M".


Select all columns from the category table for rows where the primary key is greater than 4 and the name field begins with either C, S or T.
Select all columns minus the password column from the staff table for rows that contain a password.
Select all columns minus the password column from the staff table for rows that do not contain a password.
