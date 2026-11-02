-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests duplicate outputs (to kill DISTINCT mutants), WHERE clause filtering mutants, and negative/zero values.
INSERT INTO Employees (employee_id, first_name, last_name, salary) VALUES (1, 'Evan', 'Wright', 150000.0);
INSERT INTO Employees (employee_id, first_name, last_name, salary) VALUES (2, 'Fiona', 'Gallagher', 200000.0);
INSERT INTO Employees (employee_id, first_name, last_name, salary) VALUES (3, 'George', 'Clark', 50000.0);
INSERT INTO Employees (employee_id, first_name, last_name, salary) VALUES (4, 'Hannah', 'Abbott', 0.0);
INSERT INTO Employees (employee_id, first_name, last_name, salary) VALUES (5, 'Ian', 'Malcolm', -5000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CASE WHEN salary > 100000 THEN 'High' ELSE 'Low' END FROM Employees;

/*
Gold Result:
('High',)
('High',)
('Low',)
('Low',)
('Low',)
*/

-- Prediction Query
SELECT CASE WHEN salary < 100000 THEN 'High' ELSE 'Low' END FROM Employees;

/*
Prediction Result:
('Low',)
('Low',)
('High',)
('High',)
('High',)
*/