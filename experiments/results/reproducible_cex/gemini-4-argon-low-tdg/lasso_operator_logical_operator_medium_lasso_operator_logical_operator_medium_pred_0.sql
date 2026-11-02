-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic inclusion (10, 20), boundary values (9, 11, 19, 21), BETWEEN (15), and NULL handling.
-- Kills mutants using AND instead of OR, BETWEEN 10 AND 20, missing one of the conditions, or wrong comparison operators (<, <=, >, >=, <>).
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (9, 'Dept 9', 100, 'Loc A');
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (10, 'Dept 10', 100, 'Loc B');
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (11, 'Dept 11', 100, 'Loc C');
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (15, 'Dept 15', 100, 'Loc D');
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (19, 'Dept 19', 100, 'Loc E');
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (20, 'Dept 20', 100, 'Loc F');
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (21, 'Dept 21', 100, 'Loc G');
INSERT INTO Jobs (job_id, job_title, min_salary, max_salary) VALUES ('J1', 'Developer', 50000.0, 100000.0);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (1, 'Alice', 'Smith', 'alice@example.com', '111-1111', '2020-01-01', 'J1', 60000.0, NULL, NULL, 9);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (2, 'Bob', 'Jones', 'bob@example.com', '111-1112', '2020-01-02', 'J1', 60000.0, NULL, NULL, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (3, 'Charlie', 'Brown', 'charlie@example.com', '111-1113', '2020-01-03', 'J1', 60000.0, NULL, NULL, 11);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (4, 'David', 'Wilson', 'david@example.com', '111-1114', '2020-01-04', 'J1', 60000.0, NULL, NULL, 15);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (5, 'Eve', 'Davis', 'eve@example.com', '111-1115', '2020-01-05', 'J1', 60000.0, NULL, NULL, 19);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (6, 'Frank', 'Miller', 'frank@example.com', '111-1116', '2020-01-06', 'J1', 60000.0, NULL, NULL, 20);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (7, 'Grace', 'Taylor', 'grace@example.com', '111-1117', '2020-01-07', 'J1', 60000.0, NULL, NULL, 21);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (8, 'Heidi', 'Anderson', 'heidi@example.com', '111-1118', '2020-01-08', 'J1', 60000.0, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name FROM Employees WHERE department_id = 10 OR department_id = 20;

/*
Gold Result:
('Bob',)
('Frank',)
*/

-- Prediction Query
SELECT first_name FROM Employees WHERE department_id = 10 AND manager_id = 20;

/*
Prediction Result:
*/