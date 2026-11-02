-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests exact boundary condition (salary == AVG(salary)) to catch >= vs > mutations,
-- and tests column selection (first_name vs last_name).
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (1, 'HR', 101, 'NY');
INSERT INTO Jobs (job_id, job_title, min_salary, max_salary) VALUES ('J1', 'Clerk', 1000.0, 5000.0);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (101, 'Alice', 'Smith', 'alice@test.com', '111', '2020-01-01', 'J1', 1000.0, 0.1, NULL, 1);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (102, 'Bob', 'Jones', 'bob@test.com', '222', '2020-01-02', 'J1', 2000.0, 0.1, 101, 1);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (103, 'Charlie', 'Brown', 'charlie@test.com', '333', '2020-01-03', 'J1', 3000.0, 0.1, 101, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name FROM Employees WHERE salary > (SELECT AVG(salary) FROM Employees);

/*
Gold Result:
('Charlie',)
*/

-- Prediction Query
SELECT first_name FROM Employees WHERE salary > 1000;

/*
Prediction Result:
('Bob',)
('Charlie',)
*/