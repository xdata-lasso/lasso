-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Departments" ("department_id", "department_name", "manager_id", "location") VALUES (7, '10', 10, '10');
INSERT INTO "Departments" ("department_id", "department_name", "manager_id", "location") VALUES (10, '10', 10, '10');
INSERT INTO "Employees" ("employee_id", "department_id", "job_id", "first_name", "last_name", "email", "phone", "hire_date", "salary", "commission_pct", "manager_id") VALUES (9, 10, NULL, '10', '10', '10', '10', '1000-01-11', 10, 10, 10);
INSERT INTO "Employees" ("employee_id", "department_id", "job_id", "first_name", "last_name", "email", "phone", "hire_date", "salary", "commission_pct", "manager_id") VALUES (8, 10, NULL, '10', '10', '10', '10', '1000-01-11', 10, 10, 10);
INSERT INTO "Jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('11', '10', 10, 10);
INSERT INTO "Jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('12', '10', 10, 10);
INSERT INTO "JobHistory" ("employee_id", "department_id", "job_id", "start_date", "end_date") VALUES (9, 10, '12', '1000-01-11', '1000-01-11');
INSERT INTO "JobHistory" ("employee_id", "department_id", "job_id", "start_date", "end_date") VALUES (NULL, 7, '12', '1000-01-11', '1000-01-11');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT department_id FROM Employees;

/*
Gold Result:
(10,)
*/

-- Prediction Query
SELECT department_id FROM Employees;

/*
Prediction Result:
(10,)
(10,)
*/