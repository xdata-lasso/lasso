-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Departments" ("department_id", "department_name", "manager_id", "location") VALUES (16, NULL, 33, '34');
INSERT INTO "Departments" ("department_id", "department_name", "manager_id", "location") VALUES (15, NULL, 35, '36');
INSERT INTO "Employees" ("employee_id", "department_id", "job_id", "first_name", "last_name", "email", "phone", "hire_date", "salary", "commission_pct", "manager_id") VALUES (18, 15, '21', '43', '27', '28', '29', '1000-01-31', 31, 32, 35);
INSERT INTO "Employees" ("employee_id", "department_id", "job_id", "first_name", "last_name", "email", "phone", "hire_date", "salary", "commission_pct", "manager_id") VALUES (17, NULL, NULL, '43', NULL, NULL, NULL, NULL, NULL, NULL, 33);
INSERT INTO "Jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('20', '15', 15, 15);
INSERT INTO "Jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('21', '15', 15, 15);
INSERT INTO "JobHistory" ("employee_id", "job_id", "department_id", "start_date", "end_date") VALUES (18, '21', 15, '1000-01-16', '1000-01-16');
INSERT INTO "JobHistory" ("employee_id", "job_id", "department_id", "start_date", "end_date") VALUES (17, '21', 15, '1000-01-16', '1000-01-16');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.first_name, d.department_name FROM Employees AS e JOIN Departments AS d ON e.department_id = d.department_id;

/*
Gold Result:
('43', None)
*/

-- Prediction Query
SELECT e.first_name, d.department_name FROM Employees AS e JOIN Departments AS d ON e.manager_id = d.manager_id;

/*
Prediction Result:
('43', None)
('43', None)
*/