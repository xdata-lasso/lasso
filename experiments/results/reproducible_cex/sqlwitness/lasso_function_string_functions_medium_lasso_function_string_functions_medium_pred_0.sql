-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('default1', 'default2', 0.0, 0.0), ('default2', 'default2', 3.0, 4.0), ('unique_2', NULL, 5.0, 4.0), ('unique_3', 'default1', 1.0, NULL);
INSERT INTO employees (employee_id, department_id, job_id, first_name, last_name, email, phone, hire_date, salary, commission_pct, manager_id) VALUES (1, NULL, 'default2', NULL, 'default1', NULL, 'default2', '2023-01-01', 5.0, NULL, 3), (2, NULL, 'default1', 'default1', NULL, NULL, 'default2', '2023-01-02', 1.0, 3.0, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUBSTRING(phone, 1, 3) FROM Employees;

/*
Gold Result:
('def',)
('def',)
*/

-- Prediction Query
SELECT SUBSTRING(phone, 1, 4) FROM Employees;

/*
Prediction Result:
('defa',)
('defa',)
*/