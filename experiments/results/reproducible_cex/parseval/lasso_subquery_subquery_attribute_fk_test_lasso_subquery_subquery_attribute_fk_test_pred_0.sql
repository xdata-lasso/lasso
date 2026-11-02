-- Schema DDL
CREATE TABLE departments (dept_id INTEGER PRIMARY KEY, name TEXT NOT NULL, building TEXT NOT NULL);

CREATE TABLE employees (emp_id INTEGER PRIMARY KEY, dept_id INTEGER NOT NULL, name TEXT NOT NULL, salary INTEGER NOT NULL, FOREIGN KEY (dept_id) REFERENCES departments (dept_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: departments --
INSERT INTO "departments" ("dept_id", "name", "building") VALUES (1, 'dep_e6171f', '5k5swwqcgs');

INSERT INTO "departments" ("dept_id", "name", "building") VALUES (-2147483648, 'dep_e6171f', '9n8');

INSERT INTO "departments" ("dept_id", "name", "building") VALUES (2, 'tti', 'bnp');

-- Inserting into table: employees --
INSERT INTO "employees" ("emp_id", "dept_id", "name", "salary") VALUES (-2147483648, 1, '4', 1);

INSERT INTO "employees" ("emp_id", "dept_id", "name", "salary") VALUES (-2147483647, 1, 'gu7v', 1);

INSERT INTO "employees" ("emp_id", "dept_id", "name", "salary") VALUES (-2147483646, 1, 'e4', 1);

INSERT INTO "employees" ("emp_id", "dept_id", "name", "salary") VALUES (-2147483645, 1, 'hria2ypuzhs', 1);

INSERT INTO "employees" ("emp_id", "dept_id", "name", "salary") VALUES (-2147483644, 1, 'rwbbp6luhvd', 1);

INSERT INTO "employees" ("emp_id", "dept_id", "name", "salary") VALUES (3, 2, 'mdpos', 50001);

INSERT INTO "employees" ("emp_id", "dept_id", "name", "salary") VALUES (2, 1, 'e5u', 50001);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM departments WHERE dept_id IN (SELECT dept_id FROM employees WHERE salary > 50000);

/*
Gold Result:
('dep_e6171f',)
('tti',)
*/

-- Prediction Query
SELECT name FROM departments WHERE building IN (SELECT dept_id FROM employees WHERE salary > 50000);

/*
Prediction Result:
*/