-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('-1 year', 'default1', NULL, 0.0), ('2025-01-01 00:00:00', NULL, 0.0, 1.0), ('default2', 'default2', 1.0, NULL), ('default1', '-1 year', 1.0, NULL);
INSERT INTO departments (department_id, department_name, manager_id, location) VALUES (1, '-1 year', NULL, '2025-01-01 00:00:00'), (0, 'default2', 1, NULL), (2, 'default2', 1, '-1 year'), (3, 'default2', NULL, 'default2');
INSERT INTO employees (employee_id, department_id, job_id, first_name, last_name, email, phone, hire_date, salary, commission_pct, manager_id) VALUES (0, 3, '2025-01-01 00:00:00', '-1 year', 'default1', '2025-01-01 00:00:00', 'default2', NULL, 0.0, NULL, NULL), (1, 1, 'default1', NULL, NULL, NULL, '-1 year', NULL, 0.0, NULL, NULL), (2, 3, NULL, NULL, '2025-01-01 00:00:00', NULL, 'default1', '2023-01-01', 0.0, 0.0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT employee_id FROM Employees WHERE hire_date < DATE('2025-01-01 00:00:00', '-1 year');

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT employee_id FROM Employees WHERE hire_date < TIME('2025-01-01 00:00:00', '-1 year');

/*
Prediction Result:
*/