-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (10, 'Allison Hill', 1001, '819 Johnson Course
East William, AK 74064');
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('Engineer, civil (contracting)', 'Sports administrator', 1002.5, 1003.5);
INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (1004, 'Robert', 'Cole', 'lisa02@example.net', '(254)923-5116x15594', '1970-01-01', 'Engineer, civil (contracting)', 1005.5, 1006.5, 1007, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name FROM Employees WHERE department_id = 10;

/*
Gold Result:
('Robert',)
*/

-- Prediction Query
SELECT * FROM Departments;

/*
Prediction Result:
(10, 'Allison Hill', 1001, '819 Johnson Course\nEast William, AK 74064')
*/