-- Schema DDL
CREATE TABLE employees (id INTEGER PRIMARY KEY, email TEXT UNIQUE, name TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "employees" ("id", "email", "name") VALUES (7, '5', '8');
INSERT INTO "employees" ("id", "email", "name") VALUES (6, '4', '8');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name FROM employees;

/*
Gold Result:
('8',)
*/

-- Prediction Query
SELECT name FROM employees;

/*
Prediction Result:
('8',)
('8',)
*/