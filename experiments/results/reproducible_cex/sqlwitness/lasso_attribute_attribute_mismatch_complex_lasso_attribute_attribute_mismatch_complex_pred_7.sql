-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('default2', 'default2', 1.0, 1.0), ('default1', NULL, 1.0, NULL), ('unique_2', NULL, 0.0, 49999.0), ('unique_3', NULL, 1.0, 50001.0), ('unique_4', 'default2', 50001.0, 0.0), ('unique_5', NULL, 1.0, 50000.0), ('unique_6', 'default2', 49999.0, 49999.0);
INSERT INTO departments (department_id, department_name, manager_id, location) VALUES (50001, 'default1', 50000, NULL), (0, 'default1', 50000, NULL), (1, NULL, 49999, NULL), (49999, NULL, 0, 'default2'), (50000, NULL, 49999, 'default2'), (2, 'default2', 0, 'default1'), (3, 'default1', 0, NULL), (4, 'default1', NULL, 'default2'), (5, 'default1', 50001, NULL), (6, 'default2', 50001, 'default1');
INSERT INTO employees (employee_id, department_id, job_id, first_name, last_name, email, phone, hire_date, salary, commission_pct, manager_id) VALUES (1, 5, 'unique_4', NULL, 'default1', NULL, NULL, NULL, 0.0, 1.0, 50000), (0, 4, 'unique_5', 'default2', 'default2', 'default1', 'default1', NULL, 0.0, 0.0, 49999), (49999, 3, 'unique_3', 'default1', NULL, 'default1', NULL, NULL, 50001.0, NULL, 50001), (50000, 0, 'default1', 'default2', 'default1', 'default1', 'default2', '2023-01-01', 50000.0, 49999.0, 0), (50001, 1, 'unique_2', 'default2', NULL, 'default1', 'default1', '2023-01-02', NULL, 50000.0, 50001), (2, 2, 'default2', 'default1', 'default2', 'default2', NULL, '2023-01-01', 50000.0, 49999.0, 50001), (3, 5, 'unique_4', 'default1', 'default2', 'default2', NULL, '2023-01-01', 0.0, 49999.0, 49999), (4, 5, 'unique_4', 'default2', NULL, 'default2', 'default1', NULL, 0.0, 1.0, 1), (5, 50000, 'unique_5', 'default1', NULL, 'default2', 'default2', '2023-01-01', NULL, NULL, 1), (6, 0, 'unique_6', NULL, NULL, 'default2', 'default2', '2023-01-02', 50001.0, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.first_name, e.last_name, d.department_name FROM Employees AS e JOIN Departments AS d ON e.department_id = d.department_id WHERE e.salary > 50000;

/*
Gold Result:
(None, None, 'default1')
('default1', None, 'default1')
*/

-- Prediction Query
SELECT job_id, e.last_name, d.department_name FROM Employees AS e JOIN Departments AS d ON e.department_id = d.department_id WHERE e.salary > 50000;

/*
Prediction Result:
('unique_6', None, 'default1')
('unique_3', None, 'default1')
*/