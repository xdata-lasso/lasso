-- Schema DDL
CREATE TABLE Department (id INTEGER PRIMARY KEY, dept_code TEXT UNIQUE, dept_name TEXT);

CREATE TABLE Employee (id INTEGER PRIMARY KEY, emp_name TEXT, dept_code TEXT, FOREIGN KEY (dept_code) REFERENCES Department (dept_code));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Department (id, dept_code, dept_name) VALUES (1, 'D1', 'HR');
INSERT INTO Employee (id, emp_name, dept_code) VALUES (1, 'Alice', 'D1');
INSERT INTO Employee (id, emp_name, dept_code) VALUES (2, 'Bob', 'D1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT emp_name FROM Employee ORDER BY id DESC LIMIT 1;

/*
Gold Result:
('Bob',)
*/

-- Prediction Query
SELECT emp_name FROM Employee LIMIT 1;

/*
Prediction Result:
('Alice',)
*/