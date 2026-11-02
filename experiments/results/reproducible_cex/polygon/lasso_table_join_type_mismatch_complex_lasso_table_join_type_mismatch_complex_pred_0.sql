-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT, FOREIGN KEY (manager_id) REFERENCES Employees (employee_id));

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Departments" ("department_id", "manager_id", "department_name", "location") VALUES (33, NULL, NULL, NULL);
INSERT INTO "Departments" ("department_id", "manager_id", "department_name", "location") VALUES (15, 17, NULL, '32');
INSERT INTO "Employees" ("employee_id", "job_id", "first_name", "last_name", "email", "phone", "hire_date", "salary", "commission_pct", "manager_id", "department_id") VALUES (16, NULL, '17', '17', '17', '17', '1000-01-18', 17, 17, 17, 17);
INSERT INTO "Employees" ("employee_id", "job_id", "first_name", "last_name", "email", "phone", "hire_date", "salary", "commission_pct", "manager_id", "department_id") VALUES (17, '19', NULL, '24', '25', '26', '1000-01-28', 28, 29, 30, 31);
INSERT INTO "Jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('18', '17', 17, 17);
INSERT INTO "Jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('19', '17', 17, 17);
INSERT INTO "JobHistory" ("employee_id", "job_id", "department_id", "start_date", "end_date") VALUES (17, '19', 33, '1000-01-18', '1000-01-18');
INSERT INTO "JobHistory" ("employee_id", "job_id", "department_id", "start_date", "end_date") VALUES (17, '19', 15, '1000-01-18', '1000-01-18');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT d.department_name, e.first_name FROM Departments AS d LEFT JOIN Employees AS e ON d.manager_id = e.employee_id;

/*
Gold Result:
(None, None)
(None, None)
*/

-- Prediction Query
SELECT d.department_name, e.first_name FROM Departments AS d INNER JOIN Employees AS e ON d.manager_id = e.employee_id;

/*
Prediction Result:
(None, None)
*/