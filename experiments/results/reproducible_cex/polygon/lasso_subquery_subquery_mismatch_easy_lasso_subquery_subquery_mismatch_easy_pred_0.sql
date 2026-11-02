-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Departments" ("department_id", "department_name", "manager_id", "location") VALUES (21, 'New York18', 19, 'New York');
INSERT INTO "Departments" ("department_id", "department_name", "manager_id", "location") VALUES (14, 'New York20', 21, 'New York');
INSERT INTO "Employees" ("employee_id", "department_id", "job_id", "first_name", "last_name", "email", "phone", "hire_date", "salary", "commission_pct", "manager_id") VALUES (13, 21, 'New York15', 'New York36', 'New York22', 'New York23', 'New York24', '1000-01-26', 26, 27, 28);
INSERT INTO "Employees" ("employee_id", "department_id", "job_id", "first_name", "last_name", "email", "phone", "hire_date", "salary", "commission_pct", "manager_id") VALUES (12, 14, NULL, 'New York36', NULL, NULL, 'New York31', NULL, NULL, NULL, NULL);
INSERT INTO "Jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('New York15', 'New York21', 21, 21);
INSERT INTO "JobHistory" ("employee_id", "job_id", "department_id", "start_date", "end_date") VALUES (13, NULL, 14, '1000-01-22', '1000-01-22');
INSERT INTO "JobHistory" ("employee_id", "job_id", "department_id", "start_date", "end_date") VALUES (13, 'New York15', 14, '1000-01-22', '1000-01-22');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name FROM Employees WHERE department_id IN (SELECT department_id FROM Departments WHERE location = 'New York');

/*
Gold Result:
('New York36',)
('New York36',)
*/

-- Prediction Query
SELECT first_name FROM Employees WHERE department_id IN (SELECT manager_id FROM Departments WHERE location = 'New York');

/*
Prediction Result:
('New York36',)
*/