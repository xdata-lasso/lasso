-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('default1', 'default1', 2.05, 2.05), ('default2', 'default2', 0.050000000000000044, NULL), ('unique_2', NULL, 0.050000000000000044, 0.0);
INSERT INTO departments (department_id, department_name, manager_id, location) VALUES (1, 'default2', 0, 'default2');
INSERT INTO employees (employee_id, department_id, job_id, first_name, last_name, email, phone, hire_date, salary, commission_pct, manager_id) VALUES (1, 1, 'default1', NULL, 'default1', 'default1', 'default2', NULL, 0.050000000000000044, 0.0, 0), (0, NULL, 'default1', 'default1', 'default2', NULL, 'default1', NULL, 0.050000000000000044, 1.0, NULL), (2, NULL, 'default2', 'default2', 'default2', NULL, 'default2', NULL, 1.0, NULL, 1), (3, NULL, 'default1', NULL, 'default1', 'default2', 'default2', NULL, 0.0, 0.0, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CEIL(salary * 1.05) FROM Employees;

/*
Gold Result:
(1.0,)
(1.0,)
(2.0,)
(0.0,)
*/

-- Prediction Query
SELECT ROUND(salary * 1.05) FROM Employees;

/*
Prediction Result:
(0.0,)
(0.0,)
(1.0,)
(0.0,)
*/