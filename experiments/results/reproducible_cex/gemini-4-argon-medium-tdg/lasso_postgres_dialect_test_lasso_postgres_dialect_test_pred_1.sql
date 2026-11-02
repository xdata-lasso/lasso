-- Schema DDL
CREATE TABLE employees (emp_id INTEGER PRIMARY KEY, name TEXT(50) NOT NULL, department TEXT(50), salary REAL(10, 2) CHECK (salary > 0));

CREATE TABLE projects (project_id INTEGER PRIMARY KEY, title TEXT(100) NOT NULL, lead_id INTEGER, FOREIGN KEY (lead_id) REFERENCES employees (emp_id) ON DELETE SET NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Boundary value analysis on salary (exact boundary, just below, just above, and standard values)
INSERT INTO employees (emp_id, name, department, salary) VALUES (1, 'Alice', 'Engineering', 50000.00);
INSERT INTO employees (emp_id, name, department, salary) VALUES (2, 'Bob', 'Engineering', 50000.01);
INSERT INTO employees (emp_id, name, department, salary) VALUES (3, 'Charlie', 'Sales', 49999.99);
INSERT INTO employees (emp_id, name, department, salary) VALUES (4, 'Diana', 'HR', 75000.00);
INSERT INTO employees (emp_id, name, department, salary) VALUES (5, 'Evan', 'Marketing', 30000.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT emp_id, name FROM employees WHERE salary > 50000;

/*
Gold Result:
(2, 'Bob')
(4, 'Diana')
*/

-- Prediction Query
SELECT emp_id, name FROM employees WHERE salary < 50000;

/*
Prediction Result:
(3, 'Charlie')
(5, 'Evan')
*/