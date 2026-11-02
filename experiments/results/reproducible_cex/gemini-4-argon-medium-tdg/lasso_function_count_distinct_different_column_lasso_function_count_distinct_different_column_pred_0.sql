-- Schema DDL
CREATE TABLE departments (dept_id INTEGER PRIMARY KEY, dept_name TEXT NOT NULL, location TEXT, manager_name TEXT);

CREATE TABLE employees (emp_id INTEGER PRIMARY KEY, emp_name TEXT, dept_id INTEGER, role TEXT, FOREIGN KEY (dept_id) REFERENCES departments (dept_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO departments (dept_id, dept_name, location, manager_name) VALUES (1, 'Engineering', 'NYC', 'Alice');
INSERT INTO departments (dept_id, dept_name, location, manager_name) VALUES (2, 'Sales', 'NYC', 'Bob');
INSERT INTO departments (dept_id, dept_name, location, manager_name) VALUES (3, 'HR', 'LA', 'Charlie');
INSERT INTO departments (dept_id, dept_name, location, manager_name) VALUES (4, 'Finance', NULL, 'David');
INSERT INTO employees (emp_id, emp_name, dept_id, role) VALUES (1, 'Emp1', 1, 'Developer');
INSERT INTO employees (emp_id, emp_name, dept_id, role) VALUES (2, 'Emp2', 1, 'Developer');
INSERT INTO employees (emp_id, emp_name, dept_id, role) VALUES (3, 'Emp3', 2, 'Developer');
INSERT INTO employees (emp_id, emp_name, dept_id, role) VALUES (4, 'Emp4', 2, 'Manager');
INSERT INTO employees (emp_id, emp_name, dept_id, role) VALUES (5, 'Emp5', 2, NULL);
INSERT INTO employees (emp_id, emp_name, dept_id, role) VALUES (6, 'Emp6', 3, 'Recruiter');
INSERT INTO employees (emp_id, emp_name, dept_id, role) VALUES (7, 'Emp7', 4, 'Accountant');
INSERT INTO employees (emp_id, emp_name, dept_id, role) VALUES (8, 'Emp8', NULL, 'Analyst');
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
(5,)
*/