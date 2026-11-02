-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Departments (department_id, department_name) VALUES (1, 'HR');
INSERT INTO Departments (department_id, department_name) VALUES (2, 'IT');
INSERT INTO Employees (employee_id, first_name, department_id) VALUES (1, 'Alice', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.first_name, d.department_name FROM Employees AS e JOIN Departments AS d ON e.department_id = d.department_id;

/*
Gold Result:
('Alice', 'HR')
*/

-- Prediction Query
SELECT e.first_name, d.department_name FROM Employees AS e JOIN Departments AS d ON e.department_id = e.department_id;

/*
Prediction Result:
('Alice', 'HR')
('Alice', 'IT')
*/