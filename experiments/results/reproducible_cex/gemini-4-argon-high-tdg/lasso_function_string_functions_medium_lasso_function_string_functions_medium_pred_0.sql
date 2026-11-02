-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (10, 'Administration', 101, 'Seattle');
INSERT INTO Jobs (job_id, job_title, min_salary, max_salary) VALUES ('AD_ASST', 'Administration Assistant', 3000.0, 6000.0);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (101, 'Jennifer', 'Whalen', 'JWHALEN', '515.123.4567', '2003-09-17', 'AD_ASST', 4400.0, 0.1, NULL, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (102, 'Michael', 'Hartstein', 'MHARTSTE', '515-987-6543', '2004-02-17', 'AD_ASST', 6000.0, 0.2, 101, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (103, 'Pat', 'Fay', 'PFAY', '6501234567', '2005-08-17', 'AD_ASST', 3500.0, 0.15, 101, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUBSTRING(phone, 1, 3) FROM Employees;

/*
Gold Result:
('515',)
('515',)
('650',)
*/

-- Prediction Query
SELECT SUBSTRING(phone, 1, 4) FROM Employees;

/*
Prediction Result:
('515.',)
('515-',)
('6501',)
*/