-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Jobs (job_id, job_title, min_salary, max_salary) VALUES ('J1', 'Developer', 50000.0, 100000.0);
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (1, 'Sales', 101, 'New York');
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (2, 'Finance', 102, 'New York');
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (3, 'New York', 103, 'Boston');
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (4, 'Marketing', 104, 'New York City');
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (5, 'Support', 105, 'new york');
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (101, 'Alice', 'Smith', 'asmith@example.com', '111-1111', '2020-01-10', 'J1', 75000.0, 0.1, NULL, 1);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (102, 'Alice', 'Jones', 'ajones@example.com', '111-2222', '2021-03-15', 'J1', 80000.0, NULL, 101, 2);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (103, 'Bob', 'Brown', 'bbrown@example.com', '111-3333', '2019-07-20', 'J1', 60000.0, NULL, 101, 3);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (104, 'Charlie', 'Davis', 'cdavis@example.com', '111-4444', '2022-05-01', 'J1', 65000.0, 0.05, 102, 4);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (105, 'Diana', 'Evans', 'devans@example.com', '111-5555', '2023-02-11', 'J1', 70000.0, NULL, 102, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name FROM Employees WHERE department_id IN (SELECT department_id FROM Departments WHERE location = 'New York');

/*
Gold Result:
('Alice',)
('Alice',)
*/

-- Prediction Query
SELECT first_name FROM Employees WHERE department_id IN (SELECT manager_id FROM Departments WHERE location = 'New York');

/*
Prediction Result:
*/