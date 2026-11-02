-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (10, 'Engineering', 101, 'New York');
INSERT INTO Jobs (job_id, job_title, min_salary, max_salary) VALUES ('J1', 'Developer', 50000.0, 120000.0);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (1, 'Arthur', 'Pendelton', 'arthur@example.com', '555-0101', '2019-12-31', 'J1', 60000.0, 0.05, 101, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (2, 'Brenda', 'vance', 'brenda@example.com', '555-0102', '2020-01-01', 'J1', 62000.0, 0.05, 101, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (3, 'Charles', 'Dawson', 'charles@example.com', '555-0103', '2020-12-30', 'J1', 64000.0, 0.05, 101, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (4, 'Diana', 'Prince', 'diana@example.com', '555-0104', '2020-12-31', 'J1', 66000.0, 0.05, 101, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (5, 'Edward', 'Norton', 'edward@example.com', '555-0105', '2021-01-01', 'J1', 68000.0, 0.05, 101, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (6, 'Fiona', 'Gallagher', 'fiona@example.com', '555-0106', '2021-12-31', 'J1', 70000.0, 0.05, 101, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (7, 'George', 'Miller', 'george@example.com', '555-0107', '2022-06-15', 'J1', 72000.0, 0.05, 101, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name FROM Employees WHERE hire_date > '2020-12-31';

/*
Gold Result:
('Edward',)
('Fiona',)
('George',)
*/

-- Prediction Query
SELECT first_name FROM Employees WHERE hire_date > '12/31/2020';

/*
Prediction Result:
('Arthur',)
('Brenda',)
('Charles',)
('Diana',)
('Edward',)
('Fiona',)
('George',)
*/