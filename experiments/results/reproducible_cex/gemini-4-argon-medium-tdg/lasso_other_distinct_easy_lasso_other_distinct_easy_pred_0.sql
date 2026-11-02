-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (10, 'Administration', 100, 'Seattle');
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (20, 'Marketing', 101, 'New York');
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (30, 'Purchasing', 102, 'London');
INSERT INTO Jobs (job_id, job_title, min_salary, max_salary) VALUES ('J1', 'Clerk', 2000.0, 5000.0);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (100, 'Steven', 'King', 'SKING', '515.123.4567', '2020-01-01', 'J1', 4000.0, NULL, NULL, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (101, 'Neena', 'Kochhar', 'NKOCHHAR', '515.123.4568', '2020-02-01', 'J1', 4500.0, 0.0, 100, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (102, 'Lex', 'De Haan', 'LDEHAAN', '515.123.4569', '2020-03-01', 'J1', 3000.0, 0.1, 100, 20);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (103, 'Alexander', 'Hunold', 'AHUNOLD', '590.423.4567', '2020-04-01', 'J1', 2500.0, NULL, 101, NULL);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (104, 'Bruce', 'Ernst', 'BERNST', '590.423.4568', '2020-05-01', 'J1', 2500.0, NULL, 101, NULL);
INSERT INTO JobHistory (employee_id, start_date, end_date, job_id, department_id) VALUES (100, '2018-01-01', '2019-12-31', 'J1', 30);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT department_id FROM Employees;

/*
Gold Result:
(10,)
(20,)
(None,)
*/

-- Prediction Query
SELECT department_id FROM Employees;

/*
Prediction Result:
(10,)
(10,)
(20,)
(None,)
(None,)
*/