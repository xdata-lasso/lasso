-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests rounding boundaries for CEIL vs ROUND, FLOOR, CAST, and exact integers:
-- 100.0 * 1.05 = 105.0 (exact integer)
-- 10.0 * 1.05 = 10.5 (halfway boundary)
-- 1.0 * 1.05 = 1.05 (small fractional part < 0.5, where CEIL gives 2 and ROUND/FLOOR give 1)
-- 15.0 * 1.05 = 15.75 (large fractional part > 0.5, where CEIL/ROUND give 16 and FLOOR gives 15)
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (10, 'Sales', 1, 'NY');
INSERT INTO Jobs (job_id, job_title, min_salary, max_salary) VALUES ('J1', 'Rep', 1.0, 1000.0);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (1, 'Alice', 'Smith', 'a@test.com', '111', '2020-01-01', 'J1', 100.0, 0.1, NULL, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (2, 'Bob', 'Jones', 'b@test.com', '222', '2020-01-02', 'J1', 10.0, 0.2, 1, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (3, 'Charlie', 'Brown', 'c@test.com', '333', '2020-01-03', 'J1', 1.0, NULL, 1, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (4, 'Diana', 'Prince', 'd@test.com', '444', '2020-01-04', 'J1', 15.0, 0.0, 1, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CEIL(salary * 1.05) FROM Employees;

/*
Gold Result:
(105.0,)
(11.0,)
(2.0,)
(16.0,)
*/

-- Prediction Query
SELECT ABS(salary * 1.05) FROM Employees;

/*
Prediction Result:
(105.0,)
(10.5,)
(1.05,)
(15.75,)
*/