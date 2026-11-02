-- Schema DDL
CREATE TABLE departments (dept_id INTEGER PRIMARY KEY, name TEXT NOT NULL, building TEXT NOT NULL);

CREATE TABLE employees (emp_id INTEGER PRIMARY KEY, dept_id INTEGER NOT NULL, name TEXT NOT NULL, salary INTEGER NOT NULL, FOREIGN KEY (dept_id) REFERENCES departments (dept_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO departments (dept_id, name, building) VALUES (1, 'Sales', 'Building A');
INSERT INTO employees (emp_id, dept_id, name, salary) VALUES (1, 1, 'Alice', 60000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM departments WHERE dept_id IN (SELECT dept_id FROM employees WHERE salary > 50000);

/*
Gold Result:
('Sales',)
*/

-- Prediction Query
SELECT name FROM departments WHERE building IN (SELECT dept_id FROM employees WHERE salary > 50000);

/*
Prediction Result:
*/