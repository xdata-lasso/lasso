-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Departments" ("department_id", "department_name", "manager_id", "location") VALUES (14, '29', 29, '29');
INSERT INTO "Departments" ("department_id", "department_name", "manager_id", "location") VALUES (11, '29', 29, '29');
INSERT INTO "Employees" ("employee_id", "department_id", "job_id", "first_name", "last_name", "email", "phone", "hire_date", "salary", "commission_pct", "manager_id") VALUES (13, 14, '16', '29', '19', '20', '21', '1000-01-23', 50001, 1, 23);
INSERT INTO "Employees" ("employee_id", "department_id", "job_id", "first_name", "last_name", "email", "phone", "hire_date", "salary", "commission_pct", "manager_id") VALUES (12, NULL, NULL, '29', '24', NULL, NULL, NULL, 50000, 0, 28);
INSERT INTO "Jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('17', '29', 29, 29);
INSERT INTO "Jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('16', '29', 29, 29);
INSERT INTO "JobHistory" ("employee_id", "department_id", "job_id", "start_date", "end_date") VALUES (13, 11, '17', '1000-01-30', '1000-01-30');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name FROM Employees WHERE salary BETWEEN 50000 AND 100000 AND NOT commission_pct IS NULL;

/*
Gold Result:
('29',)
('29',)
*/

-- Prediction Query
SELECT first_name FROM Employees WHERE salary > 50000 AND commission_pct > 0.1;

/*
Prediction Result:
('29',)
*/