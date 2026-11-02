-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests exact boundary condition around 2024-01-01 (kills <=, >, >=, =, !=, and off-by-one day/month/year mutants)
INSERT INTO Employees (employee_id, hire_date) VALUES (1, '2023-12-31');
INSERT INTO Employees (employee_id, hire_date) VALUES (2, '2024-01-01');
INSERT INTO Employees (employee_id, hire_date) VALUES (3, '2024-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT employee_id FROM Employees WHERE hire_date < DATE('2025-01-01 00:00:00', '-1 year');

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT employee_id FROM Employees WHERE hire_date < TIME('2025-01-01 00:00:00', '-1 year');

/*
Prediction Result:
*/