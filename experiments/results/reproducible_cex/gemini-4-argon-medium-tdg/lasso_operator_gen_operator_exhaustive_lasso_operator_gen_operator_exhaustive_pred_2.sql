-- Schema DDL
CREATE TABLE employees (id INTEGER PRIMARY KEY, name TEXT, salary REAL, hire_date DATE, department TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO employees (id, name, salary, hire_date, department) VALUES (1, 'Alice', 50000.0, '2020-01-15', 'Engineering');
INSERT INTO employees (id, name, salary, hire_date, department) VALUES (2, 'Bob', 49999.99, '2019-03-22', 'Engineering');
INSERT INTO employees (id, name, salary, hire_date, department) VALUES (3, 'Charlie', 50000.01, '2021-07-11', 'Engineering');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM employees WHERE salary >= 50000 AND department = 'Engineering';

/*
Gold Result:
('Alice',)
('Charlie',)
*/

-- Prediction Query
SELECT name FROM employees WHERE salary <= 50000 AND department = 'Engineering';

/*
Prediction Result:
('Alice',)
('Bob',)
*/