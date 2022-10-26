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

