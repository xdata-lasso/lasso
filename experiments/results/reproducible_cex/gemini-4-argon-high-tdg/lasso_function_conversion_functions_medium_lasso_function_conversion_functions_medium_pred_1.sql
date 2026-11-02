-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (10, 'Administration', 101, 'New York');
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (20, 'Marketing', 102, 'London');
INSERT INTO Jobs (job_id, job_title, min_salary, max_salary) VALUES ('AD_PRES', 'President', 20000.0, 40000.0);
INSERT INTO Jobs (job_id, job_title, min_salary, max_salary) VALUES ('MK_REP', 'Marketing Representative', 4000.0, 9000.0);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (101, 'Alice', 'Smith', 'asmith@example.com', '555-0101', '2020-01-15', 'AD_PRES', 25000.5, 0.15, NULL, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (102, 'Bob', 'Jones', 'bjones@example.com', '555-0102', '2021-03-22', 'MK_REP', 9500.75, 0.05, 101, 20);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (103, 'Charlie', 'Brown', 'cbrown@example.com', '555-0103', '2022-07-01', 'MK_REP', 9500.75, 0.05, 102, 20);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (104, 'Diana', 'Prince', 'dprince@example.com', '555-0104', '2019-11-10', 'AD_PRES', 12000.0, 0.2, 101, 10);
INSERT INTO JobHistory (employee_id, start_date, end_date, job_id, department_id) VALUES (101, '2018-01-01', '2019-01-01', 'MK_REP', 20);
INSERT INTO JobHistory (employee_id, start_date, end_date, job_id, department_id) VALUES (101, '2019-01-02', '2020-01-14', 'AD_PRES', 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(salary AS TEXT) FROM Employees;

/*
Gold Result:
('25000.5',)
('9500.75',)
('9500.75',)
('12000.0',)
*/

-- Prediction Query
SELECT CAST(salary AS INTEGER) FROM Employees;

/*
Prediction Result:
(25000,)
(9500,)
(9500,)
(12000,)
*/