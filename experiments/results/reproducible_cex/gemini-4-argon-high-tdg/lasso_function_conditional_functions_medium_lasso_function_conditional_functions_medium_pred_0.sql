-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 5
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (50, 'Executive', 40, 'Boston');
INSERT INTO Jobs (job_id, job_title, min_salary, max_salary) VALUES ('EXEC', 'Executive', 150000.0, 500000.0);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (40, 'Quinn', 'Fabray', 'quinn@example.com', '555-1111', '2020-05-01', 'EXEC', 200000.0, NULL, NULL, 50);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (41, 'Rachel', 'Berry', 'rachel@example.com', '555-1112', '2020-05-02', 'EXEC', 250000.0, NULL, 40, 50);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (42, 'Sam', 'Evans', 'sam@example.com', '555-1113', '2020-05-03', 'EXEC', 300000.0, NULL, 40, 50);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CASE WHEN salary > 100000 THEN 'High' ELSE 'Low' END FROM Employees;

/*
Gold Result:
('High',)
('High',)
('High',)
*/

-- Prediction Query
SELECT CASE WHEN salary < 100000 THEN 'High' ELSE 'Low' END FROM Employees;

/*
Prediction Result:
('Low',)
('Low',)
('Low',)
*/