-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('default1', NULL, 0.0, 1.0), ('default2', 'default1', NULL, 0.0), ('unique_2', 'default2', NULL, 0.0);
INSERT INTO departments (department_id, department_name, manager_id, location) VALUES (1, NULL, NULL, NULL), (0, 'default2', 0, NULL), (2, 'default2', 1, 'default1');
INSERT INTO employees (employee_id, department_id, job_id, first_name, last_name, email, phone, hire_date, salary, commission_pct, manager_id) VALUES (1, 2, 'default2', NULL, 'default2', 'default2', 'default1', '2023-01-01', 0.0, 0.0, NULL), (0, NULL, 'default1', 'default2', NULL, 'default1', 'default1', '2023-01-01', 1.0, 0.0, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT employee_id, ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY salary DESC) FROM Employees;

/*
Gold Result:
(0, 1)
(1, 1)
*/

-- Prediction Query
SELECT employee_id, ROW_NUMBER() OVER (ORDER BY salary DESC) FROM Employees;

/*
Prediction Result:
(0, 1)
(1, 2)
*/