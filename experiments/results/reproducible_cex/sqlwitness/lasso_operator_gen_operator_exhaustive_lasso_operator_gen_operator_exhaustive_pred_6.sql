-- Schema DDL
CREATE TABLE employees (id INTEGER PRIMARY KEY, name TEXT, salary REAL, hire_date DATE, department TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employees (id, name, salary, hire_date, department) VALUES (0, 'Engineering', 50000.0, '2023-01-01', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM employees WHERE salary >= 50000 AND department = 'Engineering';

/*
Gold Result:
*/

-- Prediction Query
SELECT name FROM employees WHERE salary >= 50000 AND department <> 'Engineering';

/*
Prediction Result:
('Engineering',)
*/