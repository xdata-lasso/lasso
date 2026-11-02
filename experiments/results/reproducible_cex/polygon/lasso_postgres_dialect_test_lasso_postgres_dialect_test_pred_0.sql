-- Schema DDL
CREATE TABLE employees (emp_id INTEGER PRIMARY KEY, name TEXT(50) NOT NULL, department TEXT(50), salary REAL(10, 2) CHECK (salary > 0));

CREATE TABLE projects (project_id INTEGER PRIMARY KEY, title TEXT(100) NOT NULL, lead_id INTEGER, FOREIGN KEY (lead_id) REFERENCES employees (emp_id) ON DELETE SET NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "employees" ("emp_id", "name", "department", "salary") VALUES (6, '9', '5', 1);
INSERT INTO "employees" ("emp_id", "name", "department", "salary") VALUES (5, '10', '5', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT emp_id, name FROM employees WHERE salary > 50000;

/*
Gold Result:
*/

-- Prediction Query
SELECT emp_id, name FROM employees;

/*
Prediction Result:
(5, '10')
(6, '9')
*/