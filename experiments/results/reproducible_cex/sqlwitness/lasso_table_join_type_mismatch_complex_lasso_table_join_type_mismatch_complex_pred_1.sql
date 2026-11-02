-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT, FOREIGN KEY (manager_id) REFERENCES Employees (employee_id));

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('default2', 'default2', NULL, 0.0);
INSERT INTO departments (department_id, manager_id, department_name, location) VALUES (1, NULL, 'default1', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT d.department_name, e.first_name FROM Departments AS d LEFT JOIN Employees AS e ON d.manager_id = e.employee_id;

/*
Gold Result:
('default1', None)
*/

-- Prediction Query
SELECT d.department_name, e.first_name FROM Departments AS d CROSS JOIN Employees AS e ON d.manager_id = e.employee_id;

/*
Prediction Result:
*/