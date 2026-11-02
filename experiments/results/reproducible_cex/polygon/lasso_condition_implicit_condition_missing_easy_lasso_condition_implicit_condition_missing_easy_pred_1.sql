-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Departments" ("department_id", "department_name", "manager_id", "location") VALUES (11, '11', 11, '11');
INSERT INTO "Employees" ("employee_id", "department_id", "job_id", "first_name", "last_name", "email", "phone", "hire_date", "salary", "commission_pct", "manager_id") VALUES (13, 11, '14', '29', '15', '16', '17', '1000-01-19', 19, NULL, 21);
INSERT INTO "Employees" ("employee_id", "department_id", "job_id", "first_name", "last_name", "email", "phone", "hire_date", "salary", "commission_pct", "manager_id") VALUES (12, 11, '14', '30', '22', '23', '24', '1000-01-26', 26, NULL, 28);
INSERT INTO "Jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('14', '11', 11, 11);
INSERT INTO "JobHistory" ("employee_id", "department_id", "job_id", "start_date", "end_date") VALUES (12, 11, '14', '1000-01-12', '1000-01-12');
INSERT INTO "JobHistory" ("employee_id", "department_id", "job_id", "start_date", "end_date") VALUES (12, 11, '14', '1000-01-12', '1000-01-12');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name FROM Employees WHERE NOT commission_pct IS NULL;

/*
Gold Result:
*/

-- Prediction Query
SELECT first_name FROM Employees WHERE commission_pct IS NULL;

/*
Prediction Result:
('30',)
('29',)
*/