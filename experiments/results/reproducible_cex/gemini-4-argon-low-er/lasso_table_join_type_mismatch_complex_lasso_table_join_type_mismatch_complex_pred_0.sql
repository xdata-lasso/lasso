-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT, FOREIGN KEY (manager_id) REFERENCES Employees (employee_id));

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (1, 'Unassigned Dept', NULL, 'New York');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT d.department_name, e.first_name FROM Departments AS d LEFT JOIN Employees AS e ON d.manager_id = e.employee_id;

/*
Gold Result:
('Unassigned Dept', None)
*/

-- Prediction Query
SELECT d.department_name, e.first_name FROM Departments AS d INNER JOIN Employees AS e ON d.manager_id = e.employee_id;

/*
Prediction Result:
*/