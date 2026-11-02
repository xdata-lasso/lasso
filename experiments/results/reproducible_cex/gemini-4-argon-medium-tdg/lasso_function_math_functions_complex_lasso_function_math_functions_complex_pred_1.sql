-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (10, 'Finance', 1, 'New York');
INSERT INTO Jobs (job_id, job_title, min_salary, max_salary) VALUES ('FIN_MGR', 'Finance Manager', 50000.0, 150000.0);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (1, 'Alice', 'Smith', 'asmith@example.com', '111-111-1111', '2020-01-15', 'FIN_MGR', 100.0, 0.1, NULL, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (2, 'Bob', 'Jones', 'bjones@example.com', '111-111-1112', '2021-03-20', 'FIN_MGR', 1.0, 0.05, 1, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (3, 'Charlie', 'Brown', 'cbrown@example.com', '111-111-1113', '2022-06-10', 'FIN_MGR', 10.0, 0.0, 1, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (4, 'Diana', 'Prince', 'dprince@example.com', '111-111-1114', '2023-01-05', 'FIN_MGR', 15.0, NULL, 1, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CEIL(salary * 1.05) FROM Employees;

/*
Gold Result:
(105.0,)
(2.0,)
(11.0,)
(16.0,)
*/

-- Prediction Query
SELECT ROUND(salary * 1.05) FROM Employees;

/*
Prediction Result:
(105.0,)
(1.0,)
(11.0,)
(16.0,)
*/