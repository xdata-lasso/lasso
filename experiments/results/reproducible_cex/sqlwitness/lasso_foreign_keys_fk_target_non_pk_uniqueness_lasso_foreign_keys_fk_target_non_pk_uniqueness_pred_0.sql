-- Schema DDL
CREATE TABLE Department (id INTEGER PRIMARY KEY, dept_code TEXT UNIQUE, dept_name TEXT);

CREATE TABLE Employee (id INTEGER PRIMARY KEY, emp_name TEXT, dept_code TEXT, FOREIGN KEY (dept_code) REFERENCES Department (dept_code));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO department (id, dept_code, dept_name) VALUES (2, 'default2', 'default1'), (1, 'default1', NULL);
INSERT INTO employee (id, dept_code, emp_name) VALUES (2, 'default2', 'default2'), (1, 'default1', 'default1'), (0, NULL, NULL), (3, NULL, 'default2'), (4, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT emp_name FROM Employee ORDER BY id DESC LIMIT 1;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT emp_name FROM Employee LIMIT 1;

/*
Prediction Result:
(None,)
*/