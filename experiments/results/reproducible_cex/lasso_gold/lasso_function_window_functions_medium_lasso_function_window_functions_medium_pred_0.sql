-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (1009, 'Valerie Gray', 1010, '310 Kendra Common Apt. 164
Reidstad, GA 49021');
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (1017, 'Jennifer Jones', 1018, 'PSC 9537, Box 6724
APO AE 32826');
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('Marine scientist', 'Engineer, manufacturing systems', 1011.5, 1012.5);
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('Surveyor, mining', 'Solicitor', 1019.5, 1020.5);
INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (1021, 'Jose', 'Richards', 'lynchgeorge@example.net', '610.212.2691x6697', '1972-03-03', 'Marine scientist', 1014.5, 1016.5, 1017, 1009);
INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (1013, 'Elizabeth', 'Miles', 'icox@example.net', '527.264.8350', '1971-02-02', 'Surveyor, mining', 1015.5, 1015.5, 1016, 1017);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT employee_id, ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY salary DESC) FROM Employees;

/*
Gold Result:
(1021, 1)
(1013, 1)
*/

-- Prediction Query
SELECT employee_id, ROW_NUMBER() OVER (ORDER BY salary DESC) FROM Employees;

/*
Prediction Result:
(1013, 1)
(1021, 2)
*/