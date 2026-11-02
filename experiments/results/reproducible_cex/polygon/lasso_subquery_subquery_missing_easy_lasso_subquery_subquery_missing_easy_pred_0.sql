-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Departments" ("department_id", "department_name", "manager_id", "location") VALUES (12, '11', 11, '11');
INSERT INTO "Departments" ("department_id", "department_name", "manager_id", "location") VALUES (11, '11', 11, '11');
INSERT INTO "Employees" ("employee_id", "department_id", "job_id", "first_name", "last_name", "email", "phone", "hire_date", "salary", "commission_pct", "manager_id") VALUES (14, 11, '15', NULL, '24', '25', '26', '1000-01-28', 1002, 28, 29);
INSERT INTO "Employees" ("employee_id", "department_id", "job_id", "first_name", "last_name", "email", "phone", "hire_date", "salary", "commission_pct", "manager_id") VALUES (13, 11, '15', NULL, '31', '32', '33', '1000-02-04', 1001, 35, 36);
INSERT INTO "Jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('15', '11', 11, 11);
INSERT INTO "JobHistory" ("employee_id", "department_id", "job_id", "start_date", "end_date") VALUES (14, 11, '15', '1000-01-12', '1000-01-12');
INSERT INTO "JobHistory" ("employee_id", "department_id", "job_id", "start_date", "end_date") VALUES (13, 11, '15', '1000-01-12', '1000-01-12');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name FROM Employees WHERE salary > (SELECT AVG(salary) FROM Employees);

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT first_name FROM Employees WHERE salary > 1000;

/*
Prediction Result:
(None,)
(None,)
*/