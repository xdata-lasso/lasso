-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT, FOREIGN KEY (manager_id) REFERENCES Employees (employee_id));

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Jobs (job_id, job_title, min_salary, max_salary) VALUES ('J1', 'Developer', 50000.0, 100000.0);
INSERT INTO Jobs (job_id, job_title, min_salary, max_salary) VALUES ('J2', 'Director', 80000.0, 150000.0);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (101, 'Alice', 'Smith', 'alice@example.com', '111-2222', '2020-01-15', 'J2', 95000.0, NULL, 102, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (102, 'Bob', 'Jones', 'bob@example.com', '111-3333', '2019-03-10', 'J2', 110000.0, 0.1, NULL, 20);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (103, 'Charlie', 'Brown', 'charlie@example.com', '111-4444', '2021-06-01', 'J1', 60000.0, NULL, 101, 10);
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (10, 'Engineering', 101, 'New York');
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (20, 'Marketing', NULL, 'Chicago');
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (30, 'Finance', 102, 'Boston');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT d.department_name, e.first_name FROM Departments AS d LEFT JOIN Employees AS e ON d.manager_id = e.employee_id;

/*
Gold Result:
('Engineering', 'Alice')
('Marketing', None)
('Finance', 'Bob')
*/

-- Prediction Query
SELECT d.department_name, e.first_name FROM Departments AS d CROSS JOIN Employees AS e ON d.manager_id = e.employee_id;

/*
Prediction Result:
('Engineering', 'Alice')
('Finance', 'Bob')
*/