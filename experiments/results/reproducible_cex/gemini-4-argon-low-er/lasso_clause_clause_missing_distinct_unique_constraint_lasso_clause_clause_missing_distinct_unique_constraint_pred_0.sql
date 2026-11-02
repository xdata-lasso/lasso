-- Schema DDL
CREATE TABLE employees (id INTEGER PRIMARY KEY, email TEXT UNIQUE, name TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employees (id, email, name) VALUES (1, 'a@example.com', 'Alice');
INSERT INTO employees (id, email, name) VALUES (2, 'b@example.com', 'Alice');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name FROM employees;

/*
Gold Result:
('Alice',)
*/

-- Prediction Query
SELECT name FROM employees;

/*
Prediction Result:
('Alice',)
('Alice',)
*/