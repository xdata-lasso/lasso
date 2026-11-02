-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT, FOREIGN KEY (manager_id) REFERENCES Employees (employee_id));

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('Clinical research associate', 'Agricultural consultant', 1001.5, 1002.5);
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('Psychiatric nurse', 'Agricultural consultant', 1001.5, 1002.5);
INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (1003, 'Judith', 'Sanchez', 'jillrhodes@example.net', '296-500-1338', '1970-01-01', 'Clinical research associate', 1004.5, 1005.5, 1006, 1007);
INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (1011, 'Judith', 'Sanchez', 'jillrhodes@example.net', '296-500-1338', '1970-01-01', 'Clinical research associate', 1004.5, 1005.5, 1006, 1007);
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (1008, 'Meredith Barnes', 1003, '26542 Susan Junction Apt. 161
Melanieview, AS 06196');
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (1009, 'Meredith Barnes', NULL, '26542 Susan Junction Apt. 161
Melanieview, AS 06196');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT d.department_name, e.first_name FROM Departments AS d LEFT JOIN Employees AS e ON d.manager_id = e.employee_id;

/*
Gold Result:
('Meredith Barnes', 'Judith')
('Meredith Barnes', None)
*/

-- Prediction Query
SELECT d.department_name, e.first_name FROM Departments AS d INNER JOIN Employees AS e ON d.manager_id = e.employee_id;

/*
Prediction Result:
('Meredith Barnes', 'Judith')
*/