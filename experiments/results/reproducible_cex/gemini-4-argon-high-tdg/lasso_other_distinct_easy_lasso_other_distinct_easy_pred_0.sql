-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (10, 'Administration', 200, 'Seattle');
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (20, 'Marketing', 201, 'Toronto');
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (30, 'Purchasing', 114, 'Seattle');
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (40, 'Human Resources', 203, 'London');
INSERT INTO Jobs (job_id, job_title, min_salary, max_salary) VALUES ('AD_ASST', 'Administration Assistant', 3000.0, 6000.0);
INSERT INTO Jobs (job_id, job_title, min_salary, max_salary) VALUES ('MK_MAN', 'Marketing Manager', 9000.0, 15000.0);
INSERT INTO Jobs (job_id, job_title, min_salary, max_salary) VALUES ('MK_REP', 'Marketing Representative', 4000.0, 9000.0);
INSERT INTO Jobs (job_id, job_title, min_salary, max_salary) VALUES ('HR_REP', 'Human Resources Representative', 4000.0, 8000.0);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (101, 'Jennifer', 'Whalen', 'JWHALEN', '515.123.4444', '2018-09-17', 'AD_ASST', 4400.0, 0.1, 200, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (102, 'Michael', 'Hartstein', 'MHARTSTE', '515.123.5555', '2019-02-17', 'MK_MAN', 13000.0, 0.2, 100, 20);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (103, 'Pat', 'Fay', 'PFAY', '603.123.6666', '2020-08-17', 'MK_REP', 6000.0, 0.15, 102, 20);
INSERT INTO JobHistory (employee_id, start_date, end_date, job_id, department_id) VALUES (101, '2016-01-01', '2018-09-16', 'HR_REP', 40);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT department_id FROM Employees;

/*
Gold Result:
(10,)
(20,)
*/

-- Prediction Query
SELECT department_id FROM Employees;

/*
Prediction Result:
(10,)
(20,)
(20,)
*/