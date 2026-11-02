-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (10, 'Sales', 1, 'New York');
INSERT INTO Jobs (job_id, job_title, min_salary, max_salary) VALUES ('SA_REP', 'Sales Representative', 40000.0, 120000.0);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (1, 'ExactLow', 'UserA', 'el@example.com', '111-1111', '2020-01-01', 'SA_REP', 50000.0, 0.10, NULL, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (2, 'ExactHigh', 'UserB', 'eh@example.com', '111-1112', '2020-01-02', 'SA_REP', 100000.0, 0.20, 1, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (3, 'JustBelowFloat', 'UserC', 'jbf@example.com', '111-1113', '2020-01-03', 'SA_REP', 49999.99, 0.10, 1, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (4, 'JustAboveFloat', 'UserD', 'jaf@example.com', '111-1114', '2020-01-04', 'SA_REP', 100000.01, 0.20, 1, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (5, 'JustBelowInt', 'UserE', 'jbi@example.com', '111-1115', '2020-01-05', 'SA_REP', 49999.0, 0.15, 1, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (6, 'JustAboveInt', 'UserF', 'jai@example.com', '111-1116', '2020-01-06', 'SA_REP', 100001.0, 0.15, 1, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name FROM Employees WHERE salary BETWEEN 50000 AND 100000 AND NOT commission_pct IS NULL;

/*
Gold Result:
('ExactLow',)
('ExactHigh',)
*/

-- Prediction Query
SELECT first_name FROM Employees WHERE salary > 50000 AND commission_pct > 0.1;

/*
Prediction Result:
('ExactHigh',)
('JustAboveFloat',)
('JustAboveInt',)
*/