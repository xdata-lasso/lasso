-- Schema DDL
CREATE TABLE employees (id INTEGER PRIMARY KEY, name TEXT, salary REAL, hire_date DATE, department TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "employees" ("id", "name", "salary", "hire_date", "department") VALUES (6, NULL, 50000, '1000-01-09', 'Engineering');
INSERT INTO "employees" ("id", "name", "salary", "hire_date", "department") VALUES (5, NULL, 50001, '1000-01-10', 'Engineering');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM employees WHERE salary >= 50000 AND department = 'Engineering';

/*
Gold Result:
(None,)
(None,)
*/

-- Prediction Query
SELECT name FROM employees WHERE salary > 50000 AND department = 'Engineering';

/*
Prediction Result:
(None,)
*/