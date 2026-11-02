-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Departments" ("department_id", "department_name", "manager_id", "location") VALUES (7, 'rank11', 11, 'rank11');
INSERT INTO "Departments" ("department_id", "department_name", "manager_id", "location") VALUES (6, 'rank11', 11, 'rank11');
INSERT INTO "Employees" ("employee_id", "department_id", "job_id", "first_name", "last_name", "email", "phone", "hire_date", "salary", "commission_pct", "manager_id") VALUES (9, NULL, 'row_number10', 'rank11', 'rank11', 'rank11', 'rank11', '1000-01-12', 11, 11, 11);
INSERT INTO "Employees" ("employee_id", "department_id", "job_id", "first_name", "last_name", "email", "phone", "hire_date", "salary", "commission_pct", "manager_id") VALUES (8, 6, 'rank11', 'rank11', 'rank11', 'rank11', 'rank11', '1000-01-12', 11, 11, 11);
INSERT INTO "Jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('row_number10', 'rank11', 11, 11);
INSERT INTO "Jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('rank11', 'rank11', 11, 11);
INSERT INTO "JobHistory" ("employee_id", "department_id", "job_id", "start_date", "end_date") VALUES (9, NULL, 'rank11', '1000-01-12', '1000-01-12');
INSERT INTO "JobHistory" ("employee_id", "department_id", "job_id", "start_date", "end_date") VALUES (8, NULL, 'rank11', '1000-01-12', '1000-01-12');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT employee_id, ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY salary DESC) FROM Employees;

/*
Gold Result:
(9, 1)
(8, 1)
*/

-- Prediction Query
SELECT employee_id, RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) FROM Employees;

/*
Prediction Result:
(9, 1)
(8, 1)
*/