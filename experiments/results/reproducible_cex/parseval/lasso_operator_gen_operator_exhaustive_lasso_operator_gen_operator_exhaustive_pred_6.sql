-- Schema DDL
CREATE TABLE employees (id INTEGER PRIMARY KEY, name TEXT, salary REAL, hire_date DATE, department TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: employees --
INSERT INTO "employees" ("id", "name", "salary", "hire_date", "department") VALUES (-2147483648, 'emp_6a5dda', 50000.0, '2025-06-17', 'Engineering');

INSERT INTO "employees" ("id", "name", "salary", "hire_date", "department") VALUES (2, 'emp_6a5dda', 50000.0, '2021-11-08', 'Engineering');

INSERT INTO "employees" ("id", "name", "salary", "hire_date", "department") VALUES (3, 'emp_6a5dda', 50000.0, '2025-06-13', 'Engineering');

INSERT INTO "employees" ("id", "name", "salary", "hire_date", "department") VALUES (-2147483645, 'emp_6a5dda', 49999.99, '2023-03-15', 'Engineering');

INSERT INTO "employees" ("id", "name", "salary", "hire_date", "department") VALUES (-2147483644, 'emp_6a5dda', 50000.0, '2023-11-15', 'emp_cfcc38');

INSERT INTO "employees" ("id", "name", "salary", "hire_date", "department") VALUES (-2147483643, NULL, 50000.0, '2024-01-05', 'Engineering');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM employees WHERE salary >= 50000 AND department = 'Engineering';

/*
Gold Result:
('emp_6a5dda',)
(None,)
('emp_6a5dda',)
('emp_6a5dda',)
*/

-- Prediction Query
SELECT name FROM employees WHERE salary >= 50000 AND department <> 'Engineering';

/*
Prediction Result:
('emp_6a5dda',)
*/