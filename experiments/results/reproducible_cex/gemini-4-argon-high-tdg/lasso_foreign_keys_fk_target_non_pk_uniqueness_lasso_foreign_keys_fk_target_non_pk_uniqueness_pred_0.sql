-- Schema DDL
CREATE TABLE Department (id INTEGER PRIMARY KEY, dept_code TEXT UNIQUE, dept_name TEXT);

CREATE TABLE Employee (id INTEGER PRIMARY KEY, emp_name TEXT, dept_code TEXT, FOREIGN KEY (dept_code) REFERENCES Department (dept_code));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Department (id, dept_code, dept_name) VALUES (100, 'D1', 'HR');
INSERT INTO Department (id, dept_code, dept_name) VALUES (200, 'D2', 'Engineering');
INSERT INTO Department (id, dept_code, dept_name) VALUES (300, 'D3', 'Sales');
INSERT INTO Employee (id, emp_name, dept_code) VALUES (5, 'Charlie', 'D3');
INSERT INTO Employee (id, emp_name, dept_code) VALUES (10, 'Bob', 'D2');
INSERT INTO Employee (id, emp_name, dept_code) VALUES (2, 'Alice', 'D1');
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