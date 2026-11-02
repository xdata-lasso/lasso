-- Schema DDL
CREATE TABLE employees (id INTEGER PRIMARY KEY, name TEXT, salary REAL, hire_date DATE, department TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "employees" ("id", "name", "salary", "hire_date", "department") VALUES (1005, 'Leslie Johnson', 50001, '1973-04-04', 'Engineering');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM employees WHERE salary >= 50000 AND department = 'Engineering';

/*
Gold Result:
('Leslie Johnson',)
*/

-- Prediction Query
SELECT name FROM employees WHERE salary = 50000 AND department = 'Engineering';

/*
Prediction Result:
*/