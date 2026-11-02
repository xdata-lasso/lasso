-- Schema DDL
CREATE TABLE departments (dept_id INTEGER PRIMARY KEY, dept_name TEXT NOT NULL, location TEXT, manager_name TEXT);

CREATE TABLE employees (emp_id INTEGER PRIMARY KEY, emp_name TEXT, dept_id INTEGER, role TEXT, FOREIGN KEY (dept_id) REFERENCES departments (dept_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "departments" ("dept_id", "dept_name", "location", "manager_name") VALUES (19, 'NYC16', 'NYC', 'NYC17');
INSERT INTO "departments" ("dept_id", "dept_name", "location", "manager_name") VALUES (28, 'NYC26', 'NYC', 'NYC27');
INSERT INTO "employees" ("emp_id", "dept_id", "emp_name", "role") VALUES (30, 28, 'NYC29', 'NYC21');
INSERT INTO "employees" ("emp_id", "dept_id", "emp_name", "role") VALUES (18, 19, 'NYC20', 'NYC21');
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
(2,)
*/