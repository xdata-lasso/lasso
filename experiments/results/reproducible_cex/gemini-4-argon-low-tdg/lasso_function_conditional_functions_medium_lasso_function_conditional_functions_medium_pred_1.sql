-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Boundary value analysis: salary exactly at, just below, and just above 100000 (including floating point precision), plus NULL salary.
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (10, 'Sales', 100, 'New York');
INSERT INTO Jobs (job_id, job_title, min_salary, max_salary) VALUES ('SALES_REP', 'Sales Representative', 30000.0, 200000.0);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (1, 'Alice', 'Smith', 'asmith', '111-1111', '2020-01-01', 'SALES_REP', 100000.0, 0.1, 100, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (2, 'Bob', 'Jones', 'bjones', '111-1112', '2020-01-02', 'SALES_REP', 100000.01, 0.1, 100, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (3, 'Charlie', 'Brown', 'cbrown', '111-1113', '2020-01-03', 'SALES_REP', 99999.99, 0.1, 100, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (4, 'Diana', 'Prince', 'dprince', '111-1114', '2020-01-04', 'SALES_REP', 100001.0, 0.1, 100, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (5, 'Evan', 'Wright', 'ewright', '111-1115', '2020-01-05', 'SALES_REP', 99999.0, 0.1, 100, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (6, 'Fiona', 'Gallagher', 'fgallagher', '111-1116', '2020-01-06', 'SALES_REP', NULL, 0.1, 100, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CASE WHEN salary > 100000 THEN 'High' ELSE 'Low' END FROM Employees;

/*
Gold Result:
('Low',)
('High',)
('Low',)
('High',)
('Low',)
('Low',)
*/

-- Prediction Query
SELECT CASE WHEN salary > 100000 THEN 'Low' ELSE 'High' END FROM Employees;

/*
Prediction Result:
('High',)
('Low',)
('High',)
('Low',)
('High',)
('High',)
*/