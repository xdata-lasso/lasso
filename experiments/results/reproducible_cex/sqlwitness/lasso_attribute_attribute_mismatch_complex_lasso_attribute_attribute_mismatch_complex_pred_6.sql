-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('default1', NULL, 50001.0, 49999.0), ('default2', 'default2', 49999.0, 1.0), ('unique_2', 'default2', NULL, NULL), ('unique_3', 'default1', 50001.0, 1.0), ('unique_4', 'default2', 49999.0, 50001.0), ('unique_5', NULL, 50001.0, 1.0), ('unique_6', 'default2', 49999.0, 50000.0), ('unique_7', NULL, 50001.0, 49999.0);
INSERT INTO departments (department_id, department_name, manager_id, location) VALUES (49999, 'default1', 50001, 'default2'), (50001, 'default1', 50000, 'default1'), (0, 'default2', 50000, 'default1');
INSERT INTO employees (employee_id, department_id, job_id, first_name, last_name, email, phone, hire_date, salary, commission_pct, manager_id) VALUES (50001, NULL, NULL, 'default2', 'default1', NULL, NULL, '2023-01-01', NULL, 50001.0, NULL), (1, NULL, 'unique_4', NULL, 'default1', 'default1', NULL, '2023-01-01', 0.0, 50000.0, 1), (50000, 49999, 'unique_2', 'default2', 'default2', NULL, NULL, '2023-01-01', 1.0, 50000.0, 1), (49999, 49999, 'default2', 'default1', 'default1', NULL, 'default2', '2023-01-01', 50001.0, 50000.0, 49999), (0, NULL, 'default1', NULL, 'default2', NULL, 'default1', '2023-01-02', 50001.0, NULL, 0), (2, 0, 'default1', 'default1', 'default2', NULL, NULL, '2023-01-01', 49999.0, 1.0, 50000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.first_name, e.last_name, d.department_name FROM Employees AS e JOIN Departments AS d ON e.department_id = d.department_id WHERE e.salary > 50000;

/*
Gold Result:
('default1', 'default1', 'default1')
*/

-- Prediction Query
SELECT hire_date, e.last_name, d.department_name FROM Employees AS e JOIN Departments AS d ON e.department_id = d.department_id WHERE e.salary > 50000;

/*
Prediction Result:
('2023-01-01', 'default1', 'default1')
*/