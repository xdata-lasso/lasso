-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Jobs (job_id, job_title, min_salary, max_salary) VALUES ('J1', 'Dev', 50000.0, 100000.0);
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (10, 'Sales', 100, 'New York');
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (20, 'HR', 101, 'Chicago');
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (30, 'IT', 102, 'new york');
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (40, 'New York', 103, 'Boston');
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (50, 'Marketing', 104, 'New York City');
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (60, 'Finance', 105, NULL);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (1, 'Alice', 'Smith', 'a@test.com', '111', '2020-01-01', 'J1', 60000.0, NULL, 100, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (2, 'Bob', 'Jones', 'b@test.com', '222', '2020-01-02', 'J1', 60000.0, NULL, 101, 20);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (3, 'Charlie', 'Brown', 'c@test.com', '333', '2020-01-03', 'J1', 60000.0, NULL, 102, 30);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (4, 'David', 'Wilson', 'd@test.com', '444', '2020-01-04', 'J1', 60000.0, NULL, 103, 40);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (5, 'Eve', 'Davis', 'e@test.com', '555', '2020-01-05', 'J1', 60000.0, NULL, 104, 50);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (6, 'Frank', 'Miller', 'f@test.com', '666', '2020-01-06', 'J1', 60000.0, NULL, 105, 60);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (7, 'Grace', 'Taylor', 'g@test.com', '777', '2020-01-07', 'J1', 60000.0, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name FROM Employees WHERE department_id IN (SELECT department_id FROM Departments WHERE location = 'New York');

/*
Gold Result:
('Alice',)
*/

-- Prediction Query
SELECT first_name FROM Employees WHERE department_id IN (SELECT manager_id FROM Departments WHERE location = 'New York');

/*
Prediction Result:
*/