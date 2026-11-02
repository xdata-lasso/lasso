-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Departments" ("department_id", "department_name", "manager_id", "location") VALUES (14, '12/31/202015', 15, '12/31/202015');
INSERT INTO "Departments" ("department_id", "department_name", "manager_id", "location") VALUES (11, '12/31/202015', 15, '12/31/202015');
INSERT INTO "Employees" ("employee_id", "department_id", "job_id", "first_name", "last_name", "email", "phone", "hire_date", "salary", "commission_pct", "manager_id") VALUES (13, 14, '12/31/202015', NULL, '12/31/202017', '12/31/202018', '12/31/202019', '2021-01-01', 20, 21, 22);
INSERT INTO "Employees" ("employee_id", "department_id", "job_id", "first_name", "last_name", "email", "phone", "hire_date", "salary", "commission_pct", "manager_id") VALUES (12, 11, '12/31/202016', NULL, '12/31/202023', '12/31/202024', '12/31/202025', '1000-05-23', 26, 27, 28);
INSERT INTO "Jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('12/31/202016', '12/31/202015', 15, 15);
INSERT INTO "Jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('12/31/202015', '12/31/202015', 15, 15);
INSERT INTO "JobHistory" ("employee_id", "department_id", "job_id", "start_date", "end_date") VALUES (12, 11, '12/31/202015', '1000-01-16', '1000-01-16');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name FROM Employees WHERE hire_date > '2020-12-31';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT first_name FROM Employees WHERE hire_date > '12/31/2020';

/*
Prediction Result:
(None,)
*/