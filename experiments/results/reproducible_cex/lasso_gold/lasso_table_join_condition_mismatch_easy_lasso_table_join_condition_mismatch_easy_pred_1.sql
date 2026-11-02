-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (1009, 'Valerie Gray', 1010, '310 Kendra Common Apt. 164
Reidstad, GA 49021');
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (1018, 'Valerie Gray', 1010, '310 Kendra Common Apt. 164
Reidstad, GA 49021');
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('Marine scientist', 'Engineer, manufacturing systems', 1011.5, 1012.5);
INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (1013, 'Elizabeth', 'Miles', 'lynchgeorge@example.net', '527.264.8350', '1971-02-02', 'Marine scientist', 1014.5, 1015.5, 1016, 1009);
INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (1017, 'Elizabeth', 'Miles', 'lynchgeorge@example.net', '527.264.8350', '1971-02-02', 'Marine scientist', 1014.5, 1015.5, 1016, 1018);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.first_name, d.department_name FROM Employees AS e JOIN Departments AS d ON e.department_id = d.department_id;

/*
Gold Result:
('Elizabeth', 'Valerie Gray')
('Elizabeth', 'Valerie Gray')
*/

-- Prediction Query
SELECT e.first_name, d.department_name FROM Employees AS e JOIN Departments AS d ON e.department_id = e.department_id;

/*
Prediction Result:
('Elizabeth', 'Valerie Gray')
('Elizabeth', 'Valerie Gray')
('Elizabeth', 'Valerie Gray')
('Elizabeth', 'Valerie Gray')
*/