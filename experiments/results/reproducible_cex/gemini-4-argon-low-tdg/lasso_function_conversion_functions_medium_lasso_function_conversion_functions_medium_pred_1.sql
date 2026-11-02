-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. CAST(REAL AS TEXT) vs CAST(REAL AS INTEGER) using both whole numbers (50000.0 -> '50000.0') and fractional numbers (60000.75).
-- 2. SELECT DISTINCT vs SELECT ALL (duplicate salary 50000.0).
-- 3. NULL handling in salary and foreign keys (department_id, job_id, manager_id) to catch erroneous INNER JOINs or WHERE IS NOT NULL filters.
-- 4. Boundary value (0.0) and salary out of job min/max bounds.
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (10, 'Sales', 1, 'New York');
INSERT INTO Jobs (job_id, job_title, min_salary, max_salary) VALUES ('J1', 'Sales Rep', 40000.0, 80000.0);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (1, 'Alice', 'Smith', 'alice@example.com', '111-2222', '2020-01-15', 'J1', 50000.0, 0.1, NULL, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (2, 'Bob', 'Jones', 'bob@example.com', '111-3333', '2021-03-20', 'J1', 50000.0, NULL, 1, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (3, 'Charlie', 'Brown', 'charlie@example.com', NULL, '2022-06-10', NULL, 60000.75, 0.0, 1, NULL);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (4, 'Diana', 'Prince', 'diana@example.com', '111-4444', '2023-01-01', 'J1', NULL, 0.2, 1, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (5, 'Evan', 'Wright', 'evan@example.com', '111-5555', '2023-05-05', 'J1', 0.0, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(salary AS TEXT) FROM Employees;

/*
Gold Result:
('50000.0',)
('50000.0',)
('60000.75',)
(None,)
('0.0',)
*/

-- Prediction Query
SELECT CAST(salary AS INTEGER) FROM Employees;

/*
Prediction Result:
(50000,)
(50000,)
(60000,)
(None,)
(0,)
*/