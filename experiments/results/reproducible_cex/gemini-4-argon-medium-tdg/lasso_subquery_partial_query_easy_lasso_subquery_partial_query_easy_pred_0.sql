-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Employees > Departments (Positive result), includes NULLs, duplicates, and orphan rows
INSERT INTO Jobs (job_id, job_title, min_salary, max_salary) VALUES ('J1', 'Dev', 50000.0, 100000.0);
INSERT INTO Jobs (job_id, job_title, min_salary, max_salary) VALUES ('J2', 'QA', 40000.0, 80000.0);
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (10, 'IT', 101, 'NY');
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (20, NULL, NULL, 'LA');
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (101, 'Alice', 'Smith', 'a@b.c', '111', '2020-01-01', 'J1', 60000.0, 0.1, NULL, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (102, 'Bob', 'Jones', 'b@b.c', '222', '2020-01-02', 'J1', 60000.0, NULL, 101, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (103, 'Charlie', 'Brown', 'c@b.c', '333', '2020-01-03', 'J2', 50000.0, NULL, 101, NULL);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (104, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (105, 'Eve', 'Davis', 'e@b.c', '555', '2020-01-05', 'J2', 55000.0, 0.2, 101, 10);
INSERT INTO JobHistory (employee_id, start_date, end_date, job_id, department_id) VALUES (101, '2019-01-01', '2019-12-31', 'J2', 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT (SELECT COUNT(*) FROM Employees) - (SELECT COUNT(*) FROM Departments);

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT(*) FROM Employees;

/*
Prediction Result:
(5,)
*/