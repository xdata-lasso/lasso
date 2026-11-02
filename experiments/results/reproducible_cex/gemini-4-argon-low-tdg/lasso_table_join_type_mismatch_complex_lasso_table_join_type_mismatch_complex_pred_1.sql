-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT, FOREIGN KEY (manager_id) REFERENCES Employees (employee_id));

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. LEFT JOIN vs INNER JOIN (Department with NULL manager_id)
-- 2. Join condition on d.manager_id = e.employee_id vs d.department_id = e.department_id
-- 3. Join condition on d.manager_id = e.employee_id vs d.manager_id = e.manager_id
-- 4. Column selection (department_name vs location, first_name vs last_name)
INSERT INTO Jobs (job_id, job_title, min_salary, max_salary) VALUES ('J1', 'Manager', 50000.0, 100000.0);
INSERT INTO Jobs (job_id, job_title, min_salary, max_salary) VALUES ('J2', 'Clerk', 20000.0, 40000.0);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (1, 'Alice', 'Smith', 'alice@test.com', '111-1111', '2020-01-01', 'J1', 80000.0, 0.1, 2, 20);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (2, 'Bob', 'Jones', 'bob@test.com', '222-2222', '2020-02-01', 'J2', 35000.0, NULL, 1, 10);
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (10, 'Sales', 1, 'New York');
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (20, 'HR', NULL, 'Boston');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT d.department_name, e.first_name FROM Departments AS d LEFT JOIN Employees AS e ON d.manager_id = e.employee_id;

/*
Gold Result:
('Sales', 'Alice')
('HR', None)
*/

-- Prediction Query
SELECT d.department_name, e.first_name FROM Departments AS d CROSS JOIN Employees AS e ON d.manager_id = e.employee_id;

/*
Prediction Result:
('Sales', 'Alice')
*/