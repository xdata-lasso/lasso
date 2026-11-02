-- Schema DDL
CREATE TABLE departments (dept_id INTEGER PRIMARY KEY, name TEXT NOT NULL, building TEXT NOT NULL);

CREATE TABLE employees (emp_id INTEGER PRIMARY KEY, dept_id INTEGER NOT NULL, name TEXT NOT NULL, salary INTEGER NOT NULL, FOREIGN KEY (dept_id) REFERENCES departments (dept_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO departments (dept_id, name, building) VALUES (0, 'default1', 'default1');
INSERT INTO employees (emp_id, dept_id, name, salary) VALUES (50001, 0, 'default1', 50001);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM departments WHERE dept_id IN (SELECT dept_id FROM employees WHERE salary > 50000);

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT name FROM departments WHERE dept_id IN (SELECT emp_id FROM employees WHERE salary > 50000);

/*
Prediction Result:
*/