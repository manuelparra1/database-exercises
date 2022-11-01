USE join_example_db;
SELECT * FROM roles;
SELECT * FROM users;

SELECT *
FROM users
JOIN roles AS r
ON users.role_id = roles.id;