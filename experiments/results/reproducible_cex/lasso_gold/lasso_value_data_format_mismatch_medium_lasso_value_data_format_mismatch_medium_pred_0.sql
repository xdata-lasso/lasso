-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (1049, 'John Daniel', 1050, '65133 Amanda Dam
Whitemouth, IA 10381');
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('Probation officer', 'Statistician', 1051.5, 1052.5);
INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (1053, 'Corey', 'Pearson', 'novaksara@example.org', '(267)873-6026', '2020-12-31', 'Probation officer', 1054.5, 1055.5, 1056, 1049);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name FROM Employees WHERE hire_date > '2020-12-31';

/*
Gold Result:
*/

-- Prediction Query
SELECT first_name FROM Employees WHERE hire_date > '12/31/2020';

/*
Prediction Result:
('Corey',)
*/