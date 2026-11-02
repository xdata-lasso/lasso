-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('default1', '12-31-2020', 1.0, NULL), ('2020-12-31', NULL, 0.0, NULL), ('12-31-2020', 'default2', NULL, NULL);
INSERT INTO departments (department_id, department_name, manager_id, location) VALUES (0, 'default1', 0, '2020-12-31'), (1, '2020-12-31', 0, '12-31-2020'), (2, '2020-12-31', 1, 'default2');
INSERT INTO employees (employee_id, department_id, job_id, first_name, last_name, email, phone, hire_date, salary, commission_pct, manager_id) VALUES (0, 1, 'default1', '12-31-2020', '2020-12-31', '2020-12-31', 'default2', '2023-01-01', NULL, 1.0, NULL), (1, 0, '12-31-2020', 'default2', '2020-12-31', '12-31-2020', 'default2', NULL, 0.0, NULL, 1), (2, 1, 'default1', '12-31-2020', '2020-12-31', 'default2', 'default2', '2023-01-01', 1.0, 1.0, NULL), (3, NULL, '2020-12-31', '2020-12-31', '12-31-2020', 'default2', '12-31-2020', '2023-01-02', 0.0, 0.0, NULL), (4, 2, 'default1', 'default1', '2020-12-31', 'default2', 'default1', '2020-12-31', NULL, 0.0, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name FROM Employees WHERE hire_date > '2020-12-31';

/*
Gold Result:
('12-31-2020',)
('12-31-2020',)
('2020-12-31',)
*/

-- Prediction Query
SELECT first_name FROM Employees WHERE hire_date > '12-31-2020';

/*
Prediction Result:
('12-31-2020',)
('12-31-2020',)
('2020-12-31',)
('default1',)
*/