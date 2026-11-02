-- Schema DDL
CREATE TABLE employees (emp_id INTEGER PRIMARY KEY, name TEXT(50) NOT NULL, department TEXT(50), salary REAL(10, 2) CHECK (salary > 0));

CREATE TABLE projects (project_id INTEGER PRIMARY KEY, title TEXT(100) NOT NULL, lead_id INTEGER, FOREIGN KEY (lead_id) REFERENCES employees (emp_id) ON DELETE SET NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employees (emp_id, name, department, salary) VALUES (1, 'Alice', 'Engineering', 60000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT emp_id, name FROM employees WHERE salary > 50000;

/*
Gold Result:
(1, 'Alice')
*/

-- Prediction Query
SELECT emp_id, name FROM employees WHERE salary < 50000;

/*
Prediction Result:
*/