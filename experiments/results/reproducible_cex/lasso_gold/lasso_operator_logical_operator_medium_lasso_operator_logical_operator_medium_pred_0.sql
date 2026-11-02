-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (10, 'Allison Hill', 1001, '600 Jeffery Parkways
New Jamesside, MT 29394');
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (20, 'Noah Rhodes', 1008.0, '26542 Susan Junction Apt. 161
Melanieview, AS 06196');
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('Psychiatric nurse', 'Software engineer', 1003.5, 1004.5);
INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (1005, 'David', 'Miller', 'barbara10@example.net', '664-375-2553', '1970-01-01', 'Psychiatric nurse', 1007.5, 1009.5, 1011, 10);
INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (1006, 'Sandra', 'Carter', 'kendragalloway@example.org', '+1-528-232-7648x350', '1970-01-02', 'Psychiatric nurse', 1024.5, 1028.5, 1032.0, 20);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name FROM Employees WHERE department_id = 10 OR department_id = 20;

/*
Gold Result:
('David',)
('Sandra',)
*/

-- Prediction Query
SELECT first_name FROM Employees WHERE department_id = 10 AND manager_id = 20;

/*
Prediction Result:
*/