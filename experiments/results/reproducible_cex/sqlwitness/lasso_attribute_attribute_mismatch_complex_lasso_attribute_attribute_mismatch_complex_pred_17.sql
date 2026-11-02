-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('default1', NULL, 0.0, 50001.0), ('default2', 'default1', 50001.0, 50000.0);
INSERT INTO departments (department_id, department_name, manager_id, location) VALUES (1, 'default2', 49999, 'default1'), (50001, 'default1', 1, NULL), (0, NULL, 50001, 'default1'), (50000, NULL, 49999, 'default1'), (49999, 'default1', 0, 'default2'), (2, NULL, 0, 'default2'), (3, 'default1', 0, 'default2'), (4, NULL, NULL, 'default1');
INSERT INTO employees (employee_id, department_id, job_id, first_name, last_name, email, phone, hire_date, salary, commission_pct, manager_id) VALUES (49999, 50001, 'default1', NULL, NULL, 'default1', 'default2', '2023-01-02', 50001.0, 50001.0, 50001), (1, 49999, 'default2', 'default2', NULL, 'default2', 'default1', '2023-01-02', 50001.0, 50001.0, 50000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.first_name, e.last_name, d.department_name FROM Employees AS e JOIN Departments AS d ON e.department_id = d.department_id WHERE e.salary > 50000;

/*
Gold Result:
('default2', None, 'default1')
(None, None, 'default1')
*/

-- Prediction Query
SELECT e.first_name, commission_pct, d.department_name FROM Employees AS e JOIN Departments AS d ON e.department_id = d.department_id WHERE e.salary > 50000;

/*
Prediction Result:
('default2', 50001.0, 'default1')
(None, 50001.0, 'default1')
*/