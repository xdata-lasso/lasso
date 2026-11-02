-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (10, 'Finance', 100, 'New York');
INSERT INTO Jobs (job_id, job_title, min_salary, max_salary) VALUES ('FIN_ANALYST', 'Financial Analyst', 50.0, 200.0);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (1, 'Alice', 'Smith', 'asmith@example.com', '555-0101', '2020-01-15', 'FIN_ANALYST', 100.0, 0.10, NULL, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (2, 'Bob', 'Jones', 'bjones@example.com', '555-0102', '2020-03-20', 'FIN_ANALYST', 101.0, 0.05, 1, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (3, 'Carol', 'White', 'cwhite@example.com', '555-0103', '2021-06-10', 'FIN_ANALYST', 110.0, 0.15, 1, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (4, 'David', 'Brown', 'dbrown@example.com', '555-0104', '2022-02-01', 'FIN_ANALYST', 50.25, 0.20, 1, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CEIL(salary * 1.05) FROM Employees;

/*
Gold Result:
(105.0,)
(107.0,)
(116.0,)
(53.0,)
*/

-- Prediction Query
SELECT ABS(salary * 1.05) FROM Employees;

/*
Prediction Result:
(105.0,)
(106.05000000000001,)
(115.5,)
(52.7625,)
*/