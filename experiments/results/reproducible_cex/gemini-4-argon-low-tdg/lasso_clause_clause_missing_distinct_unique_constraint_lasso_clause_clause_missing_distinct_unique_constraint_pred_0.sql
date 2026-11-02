-- Schema DDL
CREATE TABLE employees (id INTEGER PRIMARY KEY, email TEXT UNIQUE, name TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic duplicate elimination, wrong column projection (email/id), and extra column inclusion
INSERT INTO employees (id, email, name) VALUES (1, 'alice1@example.com', 'Alice');
INSERT INTO employees (id, email, name) VALUES (2, 'alice2@example.com', 'Alice');
INSERT INTO employees (id, email, name) VALUES (3, 'bob@example.com', 'Bob');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name FROM employees;

/*
Gold Result:
('Alice',)
('Bob',)
*/

-- Prediction Query
SELECT name FROM employees;

/*
Prediction Result:
('Alice',)
('Alice',)
('Bob',)
*/