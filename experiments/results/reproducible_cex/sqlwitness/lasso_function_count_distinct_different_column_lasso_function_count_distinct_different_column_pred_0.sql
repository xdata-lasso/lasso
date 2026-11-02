-- Schema DDL
CREATE TABLE departments (dept_id INTEGER PRIMARY KEY, dept_name TEXT NOT NULL, location TEXT, manager_name TEXT);

CREATE TABLE employees (emp_id INTEGER PRIMARY KEY, emp_name TEXT, dept_id INTEGER, role TEXT, FOREIGN KEY (dept_id) REFERENCES departments (dept_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO departments (dept_id, dept_name, location, manager_name) VALUES (0, 'default2', NULL, 'default2'), (1, 'NYC', 'NYC', 'default2');
INSERT INTO employees (emp_id, dept_id, emp_name, role) VALUES (0, 1, NULL, 'default2'), (1, 0, 'default2', 'default1'), (2, NULL, 'default1', 'default1'), (3, 1, 'default1', 'default2'), (4, 1, 'default1', 'default2'), (5, 0, 'default2', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T2.role) FROM departments AS T1 INNER JOIN employees AS T2 ON T1.dept_id = T2.dept_id WHERE T1.location = 'NYC';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT T2.emp_id) FROM departments AS T1 INNER JOIN employees AS T2 ON T1.dept_id = T2.dept_id WHERE T1.location = 'NYC';

/*
Prediction Result:
(3,)
*/