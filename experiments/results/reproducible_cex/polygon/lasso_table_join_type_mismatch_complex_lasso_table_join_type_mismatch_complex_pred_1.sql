-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT, FOREIGN KEY (manager_id) REFERENCES Employees (employee_id));

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Departments" ("department_id", "manager_id", "department_name", "location") VALUES (16, NULL, NULL, '25');
INSERT INTO "Departments" ("department_id", "manager_id", "department_name", "location") VALUES (15, 18, '47', '34');
INSERT INTO "Employees" ("employee_id", "job_id", "first_name", "last_name", "email", "phone", "hire_date", "salary", "commission_pct", "manager_id", "department_id") VALUES (18, '20', '48', '26', '27', '28', NULL, 30, 31, 32, 33);
INSERT INTO "Jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('19', '18', 18, 18);
INSERT INTO "Jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('20', '18', 18, 18);
INSERT INTO "JobHistory" ("employee_id", "job_id", "department_id", "start_date", "end_date") VALUES (18, '20', 15, '1000-01-19', '1000-01-19');
INSERT INTO "JobHistory" ("employee_id", "job_id", "department_id", "start_date", "end_date") VALUES (18, '20', 15, '1000-01-19', '1000-01-19');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT d.department_name, e.first_name FROM Departments AS d LEFT JOIN Employees AS e ON d.manager_id = e.employee_id;

/*
Gold Result:
('47', '48')
(None, None)
*/

-- Prediction Query
SELECT d.department_name, e.first_name FROM Departments AS d CROSS JOIN Employees AS e ON d.manager_id = e.employee_id;

/*
Prediction Result:
('47', '48')
*/