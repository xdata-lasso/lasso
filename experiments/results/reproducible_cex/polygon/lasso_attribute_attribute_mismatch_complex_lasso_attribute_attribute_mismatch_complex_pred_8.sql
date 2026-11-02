-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Departments" ("department_id", "department_name", "manager_id", "location") VALUES (15, '30', 30, '30');
INSERT INTO "Departments" ("department_id", "department_name", "manager_id", "location") VALUES (30, '34', 31, '32');
INSERT INTO "Employees" ("employee_id", "department_id", "job_id", "first_name", "last_name", "email", "phone", "hire_date", "salary", "commission_pct", "manager_id") VALUES (22, 30, '23', NULL, '33', '25', '26', '1000-01-28', 50001, 28, 29);
INSERT INTO "Employees" ("employee_id", "department_id", "job_id", "first_name", "last_name", "email", "phone", "hire_date", "salary", "commission_pct", "manager_id") VALUES (16, NULL, '17', '30', '30', '30', '30', '1000-01-31', 30, 30, 30);
INSERT INTO "Jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('23', '30', 30, 30);
INSERT INTO "Jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('17', '30', 30, 30);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.first_name, e.last_name, d.department_name FROM Employees AS e JOIN Departments AS d ON e.department_id = d.department_id WHERE e.salary > 50000;

/*
Gold Result:
(None, '33', '34')
*/

-- Prediction Query
SELECT salary, e.last_name, d.department_name FROM Employees AS e JOIN Departments AS d ON e.department_id = d.department_id WHERE e.salary > 50000;

/*
Prediction Result:
(50001.0, '33', '34')
*/