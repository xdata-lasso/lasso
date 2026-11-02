-- Schema DDL
CREATE TABLE employees (emp_id INTEGER PRIMARY KEY, name TEXT(50) NOT NULL, department TEXT(50), salary REAL(10, 2) CHECK (salary > 0));

CREATE TABLE projects (project_id INTEGER PRIMARY KEY, title TEXT(100) NOT NULL, lead_id INTEGER, FOREIGN KEY (lead_id) REFERENCES employees (emp_id) ON DELETE SET NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: employees --
INSERT INTO "employees" ("emp_id", "name", "department", "salary") VALUES (1, 'emp_7e3d30', 'emp_e8ac9d', 50000.01);

INSERT INTO "employees" ("emp_id", "name", "department", "salary") VALUES (2, 'emp_d2c0f7', 'emp_e8ac9d', 0.01);

INSERT INTO "employees" ("emp_id", "name", "department", "salary") VALUES (3, 'emp_d2c0f7', 'emp_e8ac9d', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT emp_id, name FROM employees WHERE salary > 50000;

/*
Gold Result:
(1, 'emp_7e3d30')
*/

-- Prediction Query
SELECT emp_id, name FROM employees WHERE salary < 50000;

/*
Prediction Result:
(2, 'emp_d2c0f7')
*/