SHOW DATABASES;
-- 2.
USE albums_db;

-- 3. Explore structure or table albums

DESCRIBE albums;

/*

id	int unsigned	NO	PRI	NULL	auto_increment
artist	varchar(240)	YES		NULL	
name	varchar(240)	NO		NULL	
release_date	int	YES		NULL	
sales	float	YES		NULL	
genre	varchar(240)	YES		NULL	

*/

SELECT COUNT(artist) FROM albums;
SELECT DISTINCT COUNT(artist) FROM albums;

-- Primary Key is ' id ' in albums table

SELECT release_date FROM albums ORDER BY release_date ASC LIMIT 1;
-- Oldest Release = 1967

SELECT release_date FROM albums ORDER BY release_date DESC LIMIT 1;
-- Newest Release = 2011

-- 4a
SELECT name FROM albums WHERE artist='Pink Floyd';

-- 4b
SELECT release_date FROM albums WHERE name="Sgt. Pepper\'s Lonely Hearts Club Band";

-- 4c
SELECT genre FROM albums WHERE name = 'Nevermind';

-- 4d
SELECT name from albums WHERE release_date BETWEEN 1990 and 1999;

-- 4e
SELECT name, sales AS 'sales in millions' FROM albums WHERE sales < 20.0;

-- 4f
SELECT NAME, genre FROM albums WHERE genre LIKE '%rock%';

