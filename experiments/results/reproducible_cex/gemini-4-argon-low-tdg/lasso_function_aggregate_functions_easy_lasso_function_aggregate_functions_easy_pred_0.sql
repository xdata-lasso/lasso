-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests behavior when Employees is empty, while other tables are populated.
-- Kills mutants querying wrong tables (Departments, Jobs) or returning NULL/1 instead of 0 on empty tables.
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (10, 'Administration', 100, 'New York');
INSERT INTO Jobs (job_id, job_title, min_salary, max_salary) VALUES ('J1', 'President', 20000.0, 40000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(employee_id) FROM Employees;

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT SUM(employee_id) FROM Employees;

/*
Prediction Result:
(None,)
*/