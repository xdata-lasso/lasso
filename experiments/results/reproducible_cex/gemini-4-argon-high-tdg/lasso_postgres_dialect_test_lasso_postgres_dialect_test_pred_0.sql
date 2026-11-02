-- Schema DDL
CREATE TABLE employees (emp_id INTEGER PRIMARY KEY, name TEXT(50) NOT NULL, department TEXT(50), salary REAL(10, 2) CHECK (salary > 0));

CREATE TABLE projects (project_id INTEGER PRIMARY KEY, title TEXT(100) NOT NULL, lead_id INTEGER, FOREIGN KEY (lead_id) REFERENCES employees (emp_id) ON DELETE SET NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO employees (emp_id, name, department, salary) VALUES (1, 'Alice', 'Engineering', 50000.00);
INSERT INTO employees (emp_id, name, department, salary) VALUES (2, 'Bob', 'Sales', 50000.01);
INSERT INTO employees (emp_id, name, department, salary) VALUES (3, 'Charlie', 'Marketing', 49999.99);
INSERT INTO employees (emp_id, name, department, salary) VALUES (4, 'Diana', 'HR', 50001.00);
INSERT INTO employees (emp_id, name, department, salary) VALUES (5, 'Evan', 'Finance', 49999.00);
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
SELECT emp_id, name FROM employees;

/*
Prediction Result:
(1, 'Alice')
(2, 'Bob')
(3, 'Charlie')
(4, 'Diana')
(5, 'Evan')
*/