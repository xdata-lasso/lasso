-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Jobs (job_id, job_title, min_salary, max_salary) VALUES ('J1', 'Developer', 50000.0, 100000.0);
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (10, 'Engineering', 1, 'NY');
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (20, 'Engineering', NULL, 'NY');
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (30, 'HR', NULL, NULL);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (1, 'Alex', 'Smith', 'a1@test.com', '111', '2020-01-01', 'J1', 60000.0, NULL, NULL, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (2, 'Alex', 'Smith', 'a2@test.com', '111', '2020-01-01', 'J1', 60000.0, NULL, 1, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (3, 'Alex', 'Smith', 'a3@test.com', '111', '2020-01-01', 'J1', 60000.0, NULL, 1, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (4, 'Alex', 'Smith', 'a4@test.com', '111', '2020-01-01', 'J1', 60000.0, NULL, 1, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (5, 'Alex', 'Smith', 'a5@test.com', '111', '2020-01-01', 'J1', 60000.0, NULL, 1, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (6, 'Alex', 'Smith', 'a6@test.com', '111', '2020-01-01', 'J1', 60000.0, NULL, 1, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (7, 'Alex', 'Smith', 'a7@test.com', '111', '2020-01-01', 'J1', 60000.0, NULL, NULL, NULL);
INSERT INTO JobHistory (employee_id, start_date, end_date, job_id, department_id) VALUES (1, '2019-01-01', '2019-12-31', 'J1', 10);
INSERT INTO JobHistory (employee_id, start_date, end_date, job_id, department_id) VALUES (2, '2019-01-01', '2019-12-31', 'J1', 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT (SELECT COUNT(*) FROM Employees) - (SELECT COUNT(*) FROM Departments);

/*
Gold Result:
(4,)
*/

-- Prediction Query
SELECT COUNT(*) FROM Employees;

/*
Prediction Result:
(7,)
*/