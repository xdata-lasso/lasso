-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('default1', 'default2', NULL, 0.0), ('default2', 'default1', 0.0, 1.0), ('unique_2', 'default2', 5.0, NULL), ('unique_3', 'default2', 5.0, 6.0), ('unique_4', NULL, 1.0, 6.0), ('unique_5', 'default2', 4.0, 6.0), ('unique_6', NULL, 6.0, NULL), ('unique_7', NULL, NULL, 1.0), ('unique_8', NULL, 4.0, NULL);
INSERT INTO departments (department_id, department_name, manager_id, location) VALUES (50001, 'default2', 4, 'default2'), (6, NULL, 50001, NULL), (50000, 'default1', NULL, NULL), (1, 'default1', NULL, 'default1'), (49999, NULL, 50000, 'default1'), (4, 'default1', 50001, 'default1'), (5, NULL, 5, 'default2'), (0, NULL, 6, 'default2'), (2, 'default1', 50001, NULL), (3, 'default2', 0, NULL), (7, 'default2', 5, NULL), (8, NULL, 50001, 'default2'), (9, 'default1', 1, 'default1'), (10, 'default2', NULL, 'default2'), (11, NULL, 4, 'default1');
INSERT INTO employees (employee_id, department_id, job_id, first_name, last_name, email, phone, hire_date, salary, commission_pct, manager_id) VALUES (0, 7, 'unique_7', 'default1', 'default1', 'default2', NULL, '2023-01-02', 6.0, 1.0, 0), (50001, 2, 'unique_6', 'default1', 'default2', NULL, NULL, NULL, 50001.0, 49999.0, 50000), (4, 3, 'unique_5', 'default2', 'default2', NULL, NULL, '2023-01-02', 50000.0, NULL, 49999), (1, 4, 'unique_8', 'default2', 'default1', 'default2', NULL, '2023-01-01', 50000.0, 0.0, 49999), (6, 6, 'default1', 'default1', 'default1', 'default2', NULL, '2023-01-01', 50000.0, 0.0, 0), (5, 9, 'unique_8', NULL, NULL, 'default1', 'default1', '2023-01-02', 4.0, 50001.0, 50001), (50000, 6, NULL, 'default1', NULL, 'default2', 'default1', NULL, 6.0, 0.0, 49999), (49999, 50000, 'unique_3', 'default1', 'default2', 'default1', 'default1', '2023-01-01', 0.0, 50001.0, 1), (2, 8, 'unique_6', 'default2', 'default1', NULL, NULL, '2023-01-02', 4.0, 5.0, NULL), (3, 5, 'default2', NULL, 'default1', 'default2', 'default2', '2023-01-01', 1.0, 1.0, 50001), (7, 0, 'unique_4', 'default1', NULL, 'default2', NULL, NULL, 49999.0, 1.0, 5), (8, NULL, 'default1', 'default2', 'default2', 'default2', NULL, NULL, NULL, NULL, 4), (9, 50000, 'unique_2', NULL, NULL, 'default2', 'default1', '2023-01-02', 1.0, NULL, 50001), (10, 6, NULL, 'default2', 'default2', NULL, 'default1', '2023-01-01', NULL, 6.0, 6), (11, 10, 'unique_4', 'default2', 'default1', 'default2', 'default2', '2023-01-02', 50000.0, 5.0, 49999);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name FROM Employees WHERE department_id = 5 AND salary > 50000;

/*
Gold Result:
*/

-- Prediction Query
SELECT first_name FROM Employees WHERE department_id = 5;

/*
Prediction Result:
(None,)
*/