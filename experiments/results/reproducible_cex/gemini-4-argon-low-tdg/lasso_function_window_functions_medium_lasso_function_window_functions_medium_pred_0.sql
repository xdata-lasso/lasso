-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (10, 'Sales', 100, 'NY');
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (20, 'IT', 101, 'SF');
INSERT INTO Jobs (job_id, job_title, min_salary, max_salary) VALUES ('J1', 'Dev', 1000.0, 20000.0);
INSERT INTO Jobs (job_id, job_title, min_salary, max_salary) VALUES ('J2', 'QA', 1000.0, 20000.0);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (1, 'Alice', 'Smith', 'a@test.com', '111', '2020-01-03', 'J1', 900.0, 0.1, 100, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (2, 'Bob', 'Jones', 'b@test.com', '222', '2020-01-02', 'J2', 5000.0, 0.2, 100, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (3, 'Charlie', 'Brown', 'c@test.com', '333', '2020-01-01', 'J1', 12000.0, 0.3, 101, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (4, 'David', 'Wilson', 'd@test.com', '444', '2020-01-04', 'J2', 3000.0, 0.4, 101, 20);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (5, 'Eve', 'Davis', 'e@test.com', '555', '2020-01-05', 'J1', 8000.0, 0.5, 100, 20);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT employee_id, ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY salary DESC) FROM Employees;

/*
Gold Result:
(3, 1)
(2, 2)
(1, 3)
(5, 1)
(4, 2)
*/

-- Prediction Query
SELECT employee_id, ROW_NUMBER() OVER (ORDER BY salary DESC) FROM Employees;

/*
Prediction Result:
(3, 1)
(5, 2)
(2, 3)
(4, 4)
(1, 5)
*/