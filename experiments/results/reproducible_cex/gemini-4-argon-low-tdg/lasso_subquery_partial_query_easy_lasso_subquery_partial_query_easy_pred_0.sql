-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic positive difference (3 Employees, 2 Departments), duplicate attribute values (to kill COUNT(DISTINCT col) mutants), and NULL non-key attributes (to kill COUNT(col) mutants).
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (1, 'HR', 101, 'NY');
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (2, NULL, NULL, 'NY');
INSERT INTO Jobs (job_id, job_title, min_salary, max_salary) VALUES ('J1', 'Dev', 50000, 100000);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (101, 'John', 'Doe', 'jdoe@example.com', '123456', '2020-01-01', 'J1', 60000, NULL, NULL, 1);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (102, 'John', 'Doe', 'jdoe@example.com', '123456', '2020-01-01', 'J1', 60000, NULL, 101, 1);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (103, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO JobHistory (employee_id, start_date, end_date, job_id, department_id) VALUES (101, '2019-01-01', '2019-12-31', 'J1', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT (SELECT COUNT(*) FROM Employees) - (SELECT COUNT(*) FROM Departments);

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM Employees;

/*
Prediction Result:
(3,)
*/