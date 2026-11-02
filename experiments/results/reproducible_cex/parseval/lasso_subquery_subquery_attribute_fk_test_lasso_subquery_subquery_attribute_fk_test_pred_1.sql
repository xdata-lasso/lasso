-- Schema DDL
CREATE TABLE departments (dept_id INTEGER PRIMARY KEY, name TEXT NOT NULL, building TEXT NOT NULL);

CREATE TABLE employees (emp_id INTEGER PRIMARY KEY, dept_id INTEGER NOT NULL, name TEXT NOT NULL, salary INTEGER NOT NULL, FOREIGN KEY (dept_id) REFERENCES departments (dept_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: departments --
INSERT INTO "departments" ("dept_id", "name", "building") VALUES (2, 'dep_568b07', '5k5swwqcgs');

INSERT INTO "departments" ("dept_id", "name", "building") VALUES (3, 'dep_568b07', '9n8');

INSERT INTO "departments" ("dept_id", "name", "building") VALUES (1, 'dep_568b07', 'e4');

-- Inserting into table: employees --
INSERT INTO "employees" ("emp_id", "dept_id", "name", "salary") VALUES (-2147483648, 2, '4', 50001);

INSERT INTO "employees" ("emp_id", "dept_id", "name", "salary") VALUES (-2147483647, 3, 'gu7v', 50001);

INSERT INTO "employees" ("emp_id", "dept_id", "name", "salary") VALUES (-2147483646, 1, 'hria2ypuzhs', 50001);

INSERT INTO "employees" ("emp_id", "dept_id", "name", "salary") VALUES (-2147483645, 1, 'rwbbp6luhvd', 50001);

INSERT INTO "employees" ("emp_id", "dept_id", "name", "salary") VALUES (-2147483644, 1, 'tti', 50001);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM departments WHERE dept_id IN (SELECT dept_id FROM employees WHERE salary > 50000);

/*
Gold Result:
('dep_568b07',)
('dep_568b07',)
('dep_568b07',)
*/

-- Prediction Query
SELECT name FROM departments WHERE dept_id IN (SELECT emp_id FROM employees WHERE salary > 50000);

/*
Prediction Result:
*/