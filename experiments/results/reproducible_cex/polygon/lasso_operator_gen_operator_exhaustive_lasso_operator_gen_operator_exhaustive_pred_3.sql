-- Schema DDL
CREATE TABLE employees (id INTEGER PRIMARY KEY, name TEXT, salary REAL, hire_date DATE, department TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "employees" ("id", "name", "salary", "hire_date", "department") VALUES (6, 'Engineering7', 50001, NULL, 'Engineering');
INSERT INTO "employees" ("id", "name", "salary", "hire_date", "department") VALUES (5, 'Engineering50001', 50001, '1136-11-25', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM employees WHERE salary >= 50000 AND department = 'Engineering';

/*
Gold Result:
('Engineering7',)
*/

-- Prediction Query
SELECT name FROM employees WHERE salary = 50000 AND department = 'Engineering';

/*
Prediction Result:
*/