-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests against inner join mutants (NULL foreign keys in Employees) and DISTINCT mutants (duplicate outputs).
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (10, 'John', 'Doe', 'jdoe', '222-1111', '2021-03-15', NULL, 150000.0, NULL, NULL, NULL);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (11, 'Jane', 'Doe', 'jadoe', '222-1112', '2021-03-16', NULL, 250000.0, NULL, NULL, NULL);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (12, 'Jim', 'Beam', 'jbeam', '222-1113', '2021-03-17', NULL, 50000.0, NULL, NULL, NULL);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (13, 'Jack', 'Daniels', 'jdaniels', '222-1114', '2021-03-18', NULL, 0.0, NULL, NULL, NULL);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (14, 'Johnny', 'Walker', 'jwalker', '222-1115', '2021-03-19', NULL, -1000.0, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CASE WHEN salary > 100000 THEN 'High' ELSE 'Low' END FROM Employees;

/*
Gold Result:
('High',)
('High',)
('Low',)
('Low',)
('Low',)
*/

-- Prediction Query
SELECT CASE WHEN salary < 100000 THEN 'High' ELSE 'Low' END FROM Employees;

/*
Prediction Result:
('Low',)
('Low',)
('High',)
('High',)
('High',)
*/