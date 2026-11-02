-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('default1', NULL, 50001.0, 50000.0), ('default2', 'default1', 49999.0, NULL);
INSERT INTO departments (department_id, department_name, manager_id, location) VALUES (1, 'default1', 50000, NULL), (50000, 'default2', 50000, 'default1'), (49999, 'default1', 50000, NULL);
INSERT INTO employees (employee_id, department_id, job_id, first_name, last_name, email, phone, hire_date, salary, commission_pct, manager_id) VALUES (50000, NULL, NULL, 'default1', 'default2', 'default2', 'default1', '2023-01-01', NULL, NULL, 1), (49999, 50000, 'default2', NULL, 'default1', 'default2', 'default1', '2023-01-02', 50001.0, 50001.0, NULL), (0, 49999, 'default1', 'default2', 'default2', 'default1', NULL, '2023-01-02', 0.0, 49999.0, 49999), (50001, NULL, 'default1', 'default2', NULL, 'default1', 'default1', '2023-01-01', 50001.0, NULL, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.first_name, e.last_name, d.department_name FROM Employees AS e JOIN Departments AS d ON e.department_id = d.department_id WHERE e.salary > 50000;

/*
Gold Result:
(None, 'default1', 'default2')
*/

-- Prediction Query
SELECT phone, e.last_name, d.department_name FROM Employees AS e JOIN Departments AS d ON e.department_id = d.department_id WHERE e.salary > 50000;

/*
Prediction Result:
('default1', 'default1', 'default2')
*/