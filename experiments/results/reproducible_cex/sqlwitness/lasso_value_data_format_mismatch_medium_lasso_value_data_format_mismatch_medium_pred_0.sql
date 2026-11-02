-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('default2', '2020-12-31', NULL, NULL), ('12/31/2020', 'default2', NULL, 1.0), ('default1', 'default2', NULL, 0.0);
INSERT INTO employees (employee_id, department_id, job_id, first_name, last_name, email, phone, hire_date, salary, commission_pct, manager_id) VALUES (1, NULL, 'default2', '12/31/2020', 'default2', '2020-12-31', NULL, '2021-01-01', 0.0, NULL, NULL), (0, NULL, 'default1', '2020-12-31', '12/31/2020', NULL, 'default1', '2020-12-31', NULL, 0.0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name FROM Employees WHERE hire_date > '2020-12-31';

/*
Gold Result:
('12/31/2020',)
*/

-- Prediction Query
SELECT first_name FROM Employees WHERE hire_date > '12/31/2020';

/*
Prediction Result:
('2020-12-31',)
('12/31/2020',)
*/