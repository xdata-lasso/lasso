-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (1020, 'Jennifer Jones', 1021, 'PSC 9537, Box 6724
APO AE 32826');
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('Surveyor, mining', 'Solicitor', 1022.5, 1023.5);
INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (1024, 'Jose', 'Richards', 'icox@example.net', '610.212.2691x6697', '1972-03-03', 'Surveyor, mining', 49995, 1025.5, 1026, 1020);
INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (1027, 'Jose', 'Richards', 'icox@example.net', '610.212.2691x6697', '1972-03-03', 'Surveyor, mining', 49995, 1025.5, 1026, 1020);
INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (1028, 'Jose', 'Richards', 'icox@example.net', '610.212.2691x6697', '1972-03-03', 'Surveyor, mining', 50007.0, 1025.5, 1026, 1020);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT department_id, AVG(salary) FROM Employees GROUP BY department_id HAVING AVG(salary) > 50000;

/*
Gold Result:
*/

-- Prediction Query
SELECT department_id, AVG(salary) FROM Employees GROUP BY department_id;

/*
Prediction Result:
(1020, 49999.0)
*/