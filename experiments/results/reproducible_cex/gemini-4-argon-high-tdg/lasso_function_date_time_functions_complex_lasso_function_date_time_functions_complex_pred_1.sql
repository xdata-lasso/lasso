-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (10, 'Engineering', 1001, 'New York');
INSERT INTO Jobs (job_id, job_title, min_salary, max_salary) VALUES ('ENG', 'Software Engineer', 60000.0, 150000.0);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (1001, 'Alice', 'Smith', 'alice@example.com', '555-0101', '2022-06-15', 'ENG', 95000.0, 0.1, NULL, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (1002, 'Bob', 'Jones', 'bob@example.com', '555-0102', '2023-12-31', 'ENG', 85000.0, 0.05, 1001, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (1003, 'Charlie', 'Brown', 'charlie@example.com', '555-0103', '2024-01-01', 'ENG', 80000.0, 0.0, 1001, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (1004, 'Diana', 'Prince', 'diana@example.com', '555-0104', '2024-01-02', 'ENG', 82000.0, 0.05, 1001, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (1005, 'Evan', 'Wright', 'evan@example.com', '555-0105', '2024-06-15', 'ENG', 78000.0, 0.05, 1001, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (1006, 'Fiona', 'Gallagher', 'fiona@example.com', '555-0106', '2025-01-01', 'ENG', 75000.0, 0.05, 1001, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (1007, 'George', 'Clark', 'george@example.com', '555-0107', '2026-01-02', 'ENG', 70000.0, 0.05, 1001, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT employee_id FROM Employees WHERE hire_date < DATE('2025-01-01 00:00:00', '-1 year');

/*
Gold Result:
(1001,)
(1002,)
*/

-- Prediction Query
SELECT employee_id FROM Employees WHERE hire_date < TIME('2025-01-01 00:00:00', '-1 year');

/*
Prediction Result:
*/