-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Departments" ("department_id", "department_name", "manager_id", "location") VALUES (5, '5', 5, '5');
INSERT INTO "Employees" ("employee_id", "department_id", "job_id", "first_name", "last_name", "email", "phone", "hire_date", "salary", "commission_pct", "manager_id") VALUES (12, NULL, NULL, NULL, '5', '5', '5', '1000-01-06', NULL, 5, 5);
INSERT INTO "Employees" ("employee_id", "department_id", "job_id", "first_name", "last_name", "email", "phone", "hire_date", "salary", "commission_pct", "manager_id") VALUES (11, 5, '14', NULL, '17', '18', '19', '1000-01-21', 50001, 21, 22);
INSERT INTO "Jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('13', '5', 5, 5);
INSERT INTO "Jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('14', '5', 5, 5);
INSERT INTO "JobHistory" ("employee_id", "department_id", "job_id", "start_date", "end_date") VALUES (11, 5, '14', '1000-01-06', '1000-01-06');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name FROM Employees WHERE department_id = 5 AND salary > 50000;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT first_name FROM Employees;

/*
Prediction Result:
(None,)
(None,)
*/