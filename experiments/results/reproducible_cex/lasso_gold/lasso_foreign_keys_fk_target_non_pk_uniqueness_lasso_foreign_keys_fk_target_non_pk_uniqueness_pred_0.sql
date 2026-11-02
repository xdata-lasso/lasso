-- Schema DDL
CREATE TABLE Department (id INTEGER PRIMARY KEY, dept_code TEXT UNIQUE, dept_name TEXT);

CREATE TABLE Employee (id INTEGER PRIMARY KEY, emp_name TEXT, dept_code TEXT, FOREIGN KEY (dept_code) REFERENCES Department (dept_code));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "department" ("id", "dept_code", "dept_name") VALUES (1001, 'purpose', 'Daniel Doyle');
INSERT INTO "department" ("id", "dept_code", "dept_name") VALUES (1002, 'brother', 'Stephanie Miller');
INSERT INTO "department" ("id", "dept_code", "dept_name") VALUES (1003, 'ago', 'Allen Robinson');
INSERT INTO "department" ("id", "dept_code", "dept_name") VALUES (1004, 'site', 'Alyssa Gonzalez');
INSERT INTO "employee" ("id", "emp_name", "dept_code") VALUES (1005, 'Kimberly Robinson', 'purpose');
INSERT INTO "employee" ("id", "emp_name", "dept_code") VALUES (1006, 'Rhonda Smith', 'purpose');
INSERT INTO "employee" ("id", "emp_name", "dept_code") VALUES (1007, 'Melissa Peterson', 'purpose');
INSERT INTO "employee" ("id", "emp_name", "dept_code") VALUES (1008, 'Tyler Rogers', 'purpose');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT emp_name FROM Employee ORDER BY id DESC LIMIT 1;

/*
Gold Result:
('Tyler Rogers',)
*/

-- Prediction Query
SELECT emp_name FROM Employee LIMIT 1;

/*
Prediction Result:
('Kimberly Robinson',)
*/