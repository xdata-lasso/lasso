-- Schema DDL
CREATE TABLE employees (id INTEGER PRIMARY KEY, name TEXT, salary REAL, hire_date DATE, department TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO employees (id, name, salary, hire_date, department) VALUES (1, 'Alice', 50000.0, '2022-01-10', 'Engineering');
INSERT INTO employees (id, name, salary, hire_date, department) VALUES (2, 'Bob', 75000.5, '2021-03-15', 'Engineering');
INSERT INTO employees (id, name, salary, hire_date, department) VALUES (3, 'Charlie', 49999.99, '2023-06-01', 'Engineering');
INSERT INTO employees (id, name, salary, hire_date, department) VALUES (4, 'Diana', 60000.0, '2020-11-20', 'Sales');
INSERT INTO employees (id, name, salary, hire_date, department) VALUES (5, 'Evan', 45000.0, '2019-08-05', 'HR');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM employees WHERE salary >= 50000 AND department = 'Engineering';

/*
Gold Result:
('Alice',)
('Bob',)
*/

-- Prediction Query
SELECT name FROM employees WHERE salary >= 50000 AND department <> 'Engineering';

/*
Prediction Result:
('Diana',)
*/