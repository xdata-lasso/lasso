-- Schema DDL
CREATE TABLE Department (id INTEGER PRIMARY KEY, dept_code TEXT UNIQUE, dept_name TEXT);

CREATE TABLE Employee (id INTEGER PRIMARY KEY, emp_name TEXT, dept_code TEXT, FOREIGN KEY (dept_code) REFERENCES Department (dept_code));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering (DESC vs ASC, no LIMIT), column confusion (emp_name vs dept_name vs dept_code), and reverse correlation between id and alphabetical emp_name / dept_code.
INSERT INTO Department (id, dept_code, dept_name) VALUES (1, 'D_Z', 'Sales');
INSERT INTO Department (id, dept_code, dept_name) VALUES (2, 'D_M', 'Engineering');
INSERT INTO Department (id, dept_code, dept_name) VALUES (3, 'D_A', 'HR');
INSERT INTO Employee (id, emp_name, dept_code) VALUES (10, 'Zack', 'D_Z');
INSERT INTO Employee (id, emp_name, dept_code) VALUES (30, 'Alice', 'D_A');
INSERT INTO Employee (id, emp_name, dept_code) VALUES (20, 'Bob', 'D_M');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT emp_name FROM Employee ORDER BY id DESC LIMIT 1;

/*
Gold Result:
('Alice',)
*/

-- Prediction Query
SELECT emp_name FROM Employee LIMIT 1;

/*
Prediction Result:
('Zack',)
*/