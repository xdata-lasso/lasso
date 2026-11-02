-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (10, 'Sales', 101, 'New York');
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (20, 'Engineering', 104, 'San Francisco');
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (30, 'Marketing', NULL, 'Chicago');
INSERT INTO Jobs (job_id, job_title, min_salary, max_salary) VALUES ('J1', 'Rep', 100.0, 2000.0);
INSERT INTO Jobs (job_id, job_title, min_salary, max_salary) VALUES ('J2', 'Lead', 500.0, 5000.0);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (101, 'Alice', 'Smith', 'alice@ex.com', '111-1111', '2021-05-10', 'J1', 900.0, 0.20, 200, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (102, 'Bob', 'Jones', 'bob@ex.com', '111-2222', '2020-01-15', 'J2', 1000.0, 0.05, 101, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (103, 'Charlie', 'Brown', 'charlie@ex.com', '111-3333', '2022-11-01', 'J1', 200.0, 0.30, 101, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (104, 'Diana', 'Prince', 'diana@ex.com', '111-4444', '2019-03-20', 'J1', 850.0, 0.15, 200, 20);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (105, 'Evan', 'Wright', 'evan@ex.com', '111-5555', '2023-07-08', 'J2', 1200.0, 0.10, 104, 20);
INSERT INTO JobHistory (employee_id, start_date, end_date, job_id, department_id) VALUES (101, '2019-01-01', '2020-01-01', 'J1', 10);
INSERT INTO JobHistory (employee_id, start_date, end_date, job_id, department_id) VALUES (101, '2020-01-02', '2021-05-09', 'J2', 20);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT employee_id, ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY salary DESC) FROM Employees;

/*
Gold Result:
(102, 1)
(101, 2)
(103, 3)
(105, 1)
(104, 2)
*/

-- Prediction Query
SELECT employee_id, ROW_NUMBER() OVER (ORDER BY salary DESC) FROM Employees;

/*
Prediction Result:
(105, 1)
(102, 2)
(101, 3)
(104, 4)
(103, 5)
*/