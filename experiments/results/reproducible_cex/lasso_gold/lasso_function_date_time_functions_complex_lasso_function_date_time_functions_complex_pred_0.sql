-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (1009, 'Valerie Gray', 1010, '310 Kendra Common Apt. 164
Reidstad, GA 49021');
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('Marine scientist', 'Engineer, manufacturing systems', 1011.5, 1012.5);
INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (1013, '2024-01-01', 'Santiago', 'lynchgeorge@example.net', '527.264.8350', '2024-01-02', 'Marine scientist', 1014.5, 1015.5, 1016, 1009);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT employee_id FROM Employees WHERE hire_date < DATE('2025-01-01 00:00:00', '-1 year');

/*
Gold Result:
*/

-- Prediction Query
SELECT employee_id FROM Employees WHERE hire_date < DATE('2025-01-01 00:00:00', '+1 year');

/*
Prediction Result:
(1013,)
*/