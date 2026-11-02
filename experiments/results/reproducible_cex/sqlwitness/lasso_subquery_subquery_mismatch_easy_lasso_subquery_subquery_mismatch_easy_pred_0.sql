-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO departments (department_id, department_name, manager_id, location) VALUES (1, 'default1', NULL, 'New York'), (0, 'default1', NULL, 'default2');
INSERT INTO employees (employee_id, department_id, job_id, first_name, last_name, email, phone, hire_date, salary, commission_pct, manager_id) VALUES (1, 0, NULL, 'default2', 'default2', 'default1', NULL, '2023-01-01', 1.0, 1.0, NULL), (0, NULL, NULL, 'New York', NULL, 'default2', NULL, '2023-01-02', NULL, 0.0, NULL), (2, 1, NULL, NULL, 'New York', NULL, 'New York', '2023-01-01', 1.0, NULL, 0), (3, NULL, NULL, NULL, 'default1', 'default2', 'default1', '2023-01-02', 1.0, NULL, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name FROM Employees WHERE department_id IN (SELECT department_id FROM Departments WHERE location = 'New York');

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT first_name FROM Employees WHERE department_id IN (SELECT manager_id FROM Departments WHERE location = 'New York');

/*
Prediction Result:
*/