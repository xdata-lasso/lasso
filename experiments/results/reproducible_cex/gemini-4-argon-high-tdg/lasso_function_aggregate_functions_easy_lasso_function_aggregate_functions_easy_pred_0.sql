-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (10, 'Sales', 10, 'New York');
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (20, 'Engineering', 20, 'San Francisco');
INSERT INTO Jobs (job_id, job_title, min_salary, max_salary) VALUES ('J_SALES', 'Salesperson', 40000.0, 80000.0);
INSERT INTO Jobs (job_id, job_title, min_salary, max_salary) VALUES ('J_ENG', 'Engineer', 60000.0, 120000.0);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (10, 'Alice', 'Smith', 'shared@example.com', '555-0100', '2020-01-15', 'J_SALES', 50000.0, 0.10, 10, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (20, 'Alice', 'Smith', 'shared@example.com', '555-0100', '2020-01-15', 'J_SALES', 50000.0, 0.10, 10, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (30, 'Bob', 'Jones', 'bob@example.com', '555-0200', '2021-06-01', 'J_ENG', 90000.0, 0.20, 20, 20);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (40, 'Bob', 'Jones', 'bob@example.com', '555-0200', '2021-06-01', 'J_ENG', 90000.0, 0.20, 20, 20);
INSERT INTO JobHistory (employee_id, start_date, end_date, job_id, department_id) VALUES (10, '2018-01-01', '2019-01-01', 'J_SALES', 10);
INSERT INTO JobHistory (employee_id, start_date, end_date, job_id, department_id) VALUES (10, '2019-01-02', '2020-01-14', 'J_ENG', 20);
INSERT INTO JobHistory (employee_id, start_date, end_date, job_id, department_id) VALUES (20, '2019-03-01', '2020-01-14', 'J_SALES', 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(employee_id) FROM Employees;

/*
Gold Result:
(4,)
*/

-- Prediction Query
SELECT SUM(employee_id) FROM Employees;

/*
Prediction Result:
(100,)
*/