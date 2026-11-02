-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests exact boundary condition (salary = 100000), floating-point precision boundaries, and NULL handling.
INSERT INTO Employees (employee_id, first_name, last_name, salary) VALUES (1, 'Alice', 'Smith', 100000.0);
INSERT INTO Employees (employee_id, first_name, last_name, salary) VALUES (2, 'Bob', 'Jones', 100000.01);
INSERT INTO Employees (employee_id, first_name, last_name, salary) VALUES (3, 'Charlie', 'Brown', 99999.99);
INSERT INTO Employees (employee_id, first_name, last_name, salary) VALUES (4, 'Diana', 'Prince', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CASE WHEN salary > 100000 THEN 'High' ELSE 'Low' END FROM Employees;

/*
Gold Result:
('Low',)
('High',)
('Low',)
('Low',)
*/

-- Prediction Query
SELECT CASE WHEN salary > 100000 THEN 'Low' ELSE 'High' END FROM Employees;

/*
Prediction Result:
('High',)
('Low',)
('High',)
('High',)
*/