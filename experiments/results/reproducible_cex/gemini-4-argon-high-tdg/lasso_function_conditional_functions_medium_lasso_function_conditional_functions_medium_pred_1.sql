-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (10, 'Finance', 1, 'New York');
INSERT INTO Jobs (job_id, job_title, min_salary, max_salary) VALUES ('FIN_ANALYST', 'Financial Analyst', 50000.0, 150000.0);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (1, 'Alice', 'Smith', 'alice@example.com', '111-1111', '2020-01-01', 'FIN_ANALYST', 100000.0, NULL, NULL, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (2, 'Bob', 'Jones', 'bob@example.com', '111-1112', '2020-01-02', 'FIN_ANALYST', 100000.01, NULL, 1, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (3, 'Charlie', 'Brown', 'charlie@example.com', '111-1113', '2020-01-03', 'FIN_ANALYST', 99999.99, NULL, 1, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (4, 'Diana', 'Prince', 'diana@example.com', '111-1114', '2020-01-04', 'FIN_ANALYST', 100001.0, NULL, 1, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (5, 'Evan', 'Wright', 'evan@example.com', '111-1115', '2020-01-05', 'FIN_ANALYST', 99999.0, NULL, 1, 10);
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
*/