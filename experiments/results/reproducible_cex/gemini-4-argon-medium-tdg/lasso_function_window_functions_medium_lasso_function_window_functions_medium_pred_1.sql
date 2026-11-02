-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (10, 'HR', 101, 'LA');
INSERT INTO Jobs (job_id, job_title, min_salary, max_salary) VALUES ('J1', 'HR Rep', 2000.0, 6000.0);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (101, 'Frank', 'Miller', 'f@test.com', '666', '2020-05-01', 'J1', 5000.0, NULL, NULL, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (102, 'Grace', 'Taylor', 'g@test.com', '777', '2020-06-01', 'J1', 4000.0, NULL, 101, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (103, 'Heidi', 'Anderson', 'h@test.com', '888', '2020-07-01', 'J1', 4000.0, NULL, 101, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (104, 'Ivan', 'Thomas', 'i@test.com', '999', '2020-08-01', 'J1', 3000.0, NULL, 101, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT employee_id, ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY salary DESC) FROM Employees;

/*
Gold Result:
(101, 1)
(102, 2)
(103, 3)
(104, 4)
*/

-- Prediction Query
SELECT employee_id, RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) FROM Employees;

/*
Prediction Result:
(101, 1)
(102, 2)
(103, 2)
(104, 4)
*/