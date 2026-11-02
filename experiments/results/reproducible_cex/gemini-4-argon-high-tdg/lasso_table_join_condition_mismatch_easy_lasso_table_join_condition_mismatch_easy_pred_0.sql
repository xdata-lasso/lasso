-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (10, 'HR', 100, 'New York');
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (20, 'Engineering', 200, 'San Francisco');
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (30, 'Marketing', 300, 'Los Angeles');
INSERT INTO Jobs (job_id, job_title, min_salary, max_salary) VALUES ('J_DEV', 'Developer', 60000.0, 120000.0);
INSERT INTO Jobs (job_id, job_title, min_salary, max_salary) VALUES ('J_MGR', 'Manager', 80000.0, 150000.0);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (10, 'Alice', 'Smith', 'alice@example.com', '555-0101', '2022-01-15', 'J_DEV', 75000.0, 0.05, 999, 20);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (100, 'Bob', 'Jones', 'bob@example.com', '555-0102', '2021-06-01', 'J_MGR', 95000.0, 0.10, 100, 20);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (30, 'Charlie', 'Brown', 'charlie@example.com', '555-0103', '2023-03-10', 'J_DEV', 65000.0, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.first_name, d.department_name FROM Employees AS e JOIN Departments AS d ON e.department_id = d.department_id;

/*
Gold Result:
('Alice', 'Engineering')
('Bob', 'Engineering')
*/

-- Prediction Query
SELECT e.first_name, d.department_name FROM Employees AS e JOIN Departments AS d ON e.manager_id = d.manager_id;

/*
Prediction Result:
('Bob', 'HR')
*/