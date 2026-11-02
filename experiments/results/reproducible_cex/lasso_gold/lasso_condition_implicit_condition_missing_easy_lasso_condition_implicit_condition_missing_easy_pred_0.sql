-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (1018, 'Jennifer Jones', 1019, 'PSC 9537, Box 6724
APO AE 32826');
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (1026, 'Ashley Dyer', 1027, '46270 Stanton Track Apt. 814
East Nathaniel, GA 71198');
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('Surveyor, mining', 'Solicitor', 1020.5, 1021.5);
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('Set designer', 'Academic librarian', 1028.5, 1029.5);
INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (1022, 'Jose', 'Richards', 'icox@example.net', '610.212.2691x6697', '1972-03-03', 'Surveyor, mining', 1023.5, 1024.5, 1025, 1018);
INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (1030, 'Carol', 'Burns', 'hickmannatasha@example.com', '403.491.1718', '1973-04-04', 'Set designer', 1031.5, NULL, 1032, 1026);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name FROM Employees WHERE NOT commission_pct IS NULL;

/*
Gold Result:
('Jose',)
*/

-- Prediction Query
SELECT first_name FROM Employees;

/*
Prediction Result:
('Jose',)
('Carol',)
*/