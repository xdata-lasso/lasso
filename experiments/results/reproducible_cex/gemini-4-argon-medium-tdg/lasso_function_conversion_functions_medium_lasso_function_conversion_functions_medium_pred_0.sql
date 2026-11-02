-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic execution, decimal fractional values vs integer casting, duplicate salary retention (anti-DISTINCT), and ordering/magnitude edge cases (e.g., 900.5 vs 1000.0).
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (10, 'Finance', 101, 'New York');
INSERT INTO Jobs (job_id, job_title, min_salary, max_salary) VALUES ('FIN_ANALYST', 'Financial Analyst', 500.0, 5000.0);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (1, 'Alice', 'Smith', 'asmith@example.com', '555-0101', '2020-01-15', 'FIN_ANALYST', 1000.55, 0.05, 101, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (2, 'Bob', 'Jones', 'bjones@example.com', '555-0102', '2020-03-20', 'FIN_ANALYST', 1000.55, 0.10, 101, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (3, 'Charlie', 'Brown', 'cbrown@example.com', '555-0103', '2021-06-01', 'FIN_ANALYST', 900.0, 0.15, 101, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(salary AS TEXT) FROM Employees;

/*
Gold Result:
('1000.55',)
('1000.55',)
('900.0',)
*/

-- Prediction Query
SELECT CAST(salary AS BLOB) FROM Employees;

/*
Prediction Result:
(b'1000.55',)
(b'1000.55',)
(b'900.0',)
*/