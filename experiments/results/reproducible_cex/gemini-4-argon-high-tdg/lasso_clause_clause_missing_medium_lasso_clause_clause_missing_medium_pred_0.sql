-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (10, 'Sales', 1, 'NY');
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (20, 'Engineering', 2, 'SF');
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (30, 'HR', 3, 'LA');
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (40, 'Finance', 4, 'CHI');
INSERT INTO Jobs (job_id, job_title, min_salary, max_salary) VALUES ('J1', 'Staff', 20000.0, 100000.0);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (1, 'Alice', 'Smith', 'a@test.com', '111', '2020-01-01', 'J1', 50000.0, 0.0, NULL, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (2, 'Bob', 'Jones', 'b@test.com', '222', '2020-01-02', 'J1', 80000.0, 0.0, 1, 20);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (3, 'Charlie', 'Brown', 'c@test.com', '333', '2020-01-03', 'J1', 40000.0, 0.0, 2, 20);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (4, 'Diana', 'Prince', 'd@test.com', '444', '2020-01-04', 'J1', 60000.0, 0.0, 1, 30);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (5, 'Evan', 'Wright', 'e@test.com', '555', '2020-01-05', 'J1', 30000.0, 0.0, 4, 30);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (6, 'Fiona', 'Gallagher', 'f@test.com', '666', '2020-01-06', 'J1', 50000.0, 0.0, 1, 40);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (7, 'George', 'Clark', 'g@test.com', '777', '2020-01-07', 'J1', 50001.0, 0.0, 6, 40);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT department_id, AVG(salary) FROM Employees GROUP BY department_id HAVING AVG(salary) > 50000;

/*
Gold Result:
(20, 60000.0)
(40, 50000.5)
*/

-- Prediction Query
SELECT department_id, AVG(salary) FROM Employees GROUP BY department_id;

/*
Prediction Result:
(10, 50000.0)
(20, 60000.0)
(30, 45000.0)
(40, 50000.5)
*/