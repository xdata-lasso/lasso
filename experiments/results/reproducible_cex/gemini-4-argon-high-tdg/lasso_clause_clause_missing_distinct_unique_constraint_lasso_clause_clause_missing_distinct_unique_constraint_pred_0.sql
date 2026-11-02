-- Schema DDL
CREATE TABLE employees (id INTEGER PRIMARY KEY, email TEXT UNIQUE, name TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO employees (id, email, name) VALUES (1, 'alice1@example.com', 'Alice');
INSERT INTO employees (id, email, name) VALUES (2, 'bob@example.com', 'Bob');
INSERT INTO employees (id, email, name) VALUES (3, 'alice2@example.com', 'Alice');
INSERT INTO employees (id, email, name) VALUES (4, 'charlie@example.com', 'Charlie');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name FROM employees;

/*
Gold Result:
('Alice',)
('Bob',)
('Charlie',)
*/

-- Prediction Query
SELECT name FROM employees;

/*
Prediction Result:
('Alice',)
('Bob',)
('Alice',)
('Charlie',)
*/