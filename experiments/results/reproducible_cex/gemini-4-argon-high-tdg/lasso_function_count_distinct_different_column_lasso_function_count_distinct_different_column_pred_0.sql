-- Schema DDL
CREATE TABLE departments (dept_id INTEGER PRIMARY KEY, dept_name TEXT NOT NULL, location TEXT, manager_name TEXT);

CREATE TABLE employees (emp_id INTEGER PRIMARY KEY, emp_name TEXT, dept_id INTEGER, role TEXT, FOREIGN KEY (dept_id) REFERENCES departments (dept_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO departments (dept_id, dept_name, location, manager_name) VALUES (10, 'Sales', 'NYC', 'Alice');
INSERT INTO departments (dept_id, dept_name, location, manager_name) VALUES (20, 'HR', 'LA', 'Bob');
INSERT INTO employees (emp_id, emp_name, dept_id, role) VALUES (1, 'John', 10, 'Analyst');
INSERT INTO employees (emp_id, emp_name, dept_id, role) VALUES (2, 'Jane', 10, 'Analyst');
INSERT INTO employees (emp_id, emp_name, dept_id, role) VALUES (3, 'Jim', 10, 'Clerk');
INSERT INTO employees (emp_id, emp_name, dept_id, role) VALUES (4, 'Jake', 20, 'Director');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T2.role) FROM departments AS T1 INNER JOIN employees AS T2 ON T1.dept_id = T2.dept_id WHERE T1.location = 'NYC';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT T2.emp_id) FROM departments AS T1 INNER JOIN employees AS T2 ON T1.dept_id = T2.dept_id WHERE T1.location = 'NYC';

/*
Prediction Result:
(3,)
*/