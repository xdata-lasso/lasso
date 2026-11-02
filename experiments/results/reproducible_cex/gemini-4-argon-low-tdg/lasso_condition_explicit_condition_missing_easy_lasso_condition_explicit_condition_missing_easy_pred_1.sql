-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (4, 'HR', 100, 'NY');
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (5, 'IT', 101, 'CA');
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (6, 'Sales', 102, 'TX');
INSERT INTO Jobs (job_id, job_title, min_salary, max_salary) VALUES ('J1', 'Developer', 40000, 100000);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (1, 'Alice', 'Smith', 'alice@test.com', '123-456', '2020-01-01', 'J1', 60000, 0.1, 101, 5);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (2, 'Bob', 'Jones', 'bob@test.com', '123-457', '2020-01-02', 'J1', 50000.01, 0.0, 101, 5);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (3, 'Charlie', 'Brown', 'charlie@test.com', '123-458', '2020-01-03', 'J1', 50000, NULL, 101, 5);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (4, 'David', 'Wilson', 'david@test.com', '123-459', '2020-01-04', 'J1', 49999.99, 0.2, 101, 5);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (5, 'Eve', 'Davis', 'eve@test.com', '123-460', '2020-01-05', 'J1', 60000, 0.1, 100, 4);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (6, 'Frank', 'Miller', 'frank@test.com', '123-461', '2020-01-06', 'J1', 60000, 0.1, 102, 6);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (7, 'Grace', 'Taylor', 'grace@test.com', '123-462', '2020-01-07', 'J1', 40000, 0.1, 100, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name FROM Employees WHERE department_id = 5 AND salary > 50000;

/*
Gold Result:
('Alice',)
('Bob',)
*/

-- Prediction Query
SELECT first_name FROM Employees;

/*
Prediction Result:
('Alice',)
('Bob',)
('Charlie',)
('David',)
('Eve',)
('Frank',)
('Grace',)
*/