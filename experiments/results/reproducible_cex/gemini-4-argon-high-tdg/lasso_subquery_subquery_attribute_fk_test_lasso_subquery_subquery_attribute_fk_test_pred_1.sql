-- Schema DDL
CREATE TABLE departments (dept_id INTEGER PRIMARY KEY, name TEXT NOT NULL, building TEXT NOT NULL);

CREATE TABLE employees (emp_id INTEGER PRIMARY KEY, dept_id INTEGER NOT NULL, name TEXT NOT NULL, salary INTEGER NOT NULL, FOREIGN KEY (dept_id) REFERENCES departments (dept_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO departments (dept_id, name, building) VALUES (1, 'Engineering', 'Bldg A');
INSERT INTO departments (dept_id, name, building) VALUES (2, 'Sales', 'Bldg B');
INSERT INTO departments (dept_id, name, building) VALUES (3, 'Marketing', 'Bldg C');
INSERT INTO departments (dept_id, name, building) VALUES (4, 'HR', 'Bldg D');
INSERT INTO employees (emp_id, dept_id, name, salary) VALUES (101, 1, 'Alice', 60000);
INSERT INTO employees (emp_id, dept_id, name, salary) VALUES (102, 2, 'Bob', 50000);
INSERT INTO employees (emp_id, dept_id, name, salary) VALUES (103, 3, 'Charlie', 40000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM departments WHERE dept_id IN (SELECT dept_id FROM employees WHERE salary > 50000);

/*
Gold Result:
('Engineering',)
*/

-- Prediction Query
SELECT name FROM departments WHERE dept_id IN (SELECT emp_id FROM employees WHERE salary > 50000);

/*
Prediction Result:
*/