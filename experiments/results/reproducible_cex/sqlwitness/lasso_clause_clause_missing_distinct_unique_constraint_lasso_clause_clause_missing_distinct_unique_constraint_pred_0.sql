-- Schema DDL
CREATE TABLE employees (id INTEGER PRIMARY KEY, email TEXT UNIQUE, name TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employees (id, email, name) VALUES (1, 'default1', 'default1'), (0, 'default2', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name FROM employees;

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT name FROM employees;

/*
Prediction Result:
('default1',)
('default1',)
*/