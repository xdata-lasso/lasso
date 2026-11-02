-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (9, 'Dept Nine', 100, 'Loc A');
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (10, 'Dept Ten', 101, 'Loc B');
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (11, 'Dept Eleven', 102, 'Loc C');
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (100, 'Dept Hundred', 103, 'Loc D');
INSERT INTO Jobs (job_id, job_title, min_salary, max_salary) VALUES ('J1', 'Developer', 5000.0, 10000.0);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (1, 'Alice', 'Smith', 'alice@test.com', '111-1111', '2020-01-10', 'J1', 6000.0, 0.1, 99, 9);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (2, 'Bob', 'Jones', 'bob@test.com', '222-2222', '2020-02-10', 'J1', 7000.0, 0.2, 99, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (3, 'Charlie', 'Brown', 'charlie@test.com', '333-3333', '2020-03-10', 'J1', 8000.0, 0.3, 10, 11);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (10, 'David', 'Wilson', 'david@test.com', '444-4444', '2020-04-10', 'J1', 10.0, 0.0, 99, 100);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name FROM Employees WHERE department_id = 10;

/*
Gold Result:
('Bob',)
*/

-- Prediction Query
SELECT * FROM Departments;

/*
Prediction Result:
(9, 'Dept Nine', 100, 'Loc A')
(10, 'Dept Ten', 101, 'Loc B')
(11, 'Dept Eleven', 102, 'Loc C')
(100, 'Dept Hundred', 103, 'Loc D')
*/