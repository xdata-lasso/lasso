-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (1057, 'Mike Allen', 1058, '5107 Charles Forest Suite 251
West Justin, NV 71701');
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (1066, 'Mike Allen', 1058, '5107 Charles Forest Suite 251
West Justin, NV 71701');
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('Immigration officer', 'Veterinary surgeon', 1059.5, 1060.5);
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('Engineer, electronics', 'Veterinary surgeon', 1059.5, 1060.5);
INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (1061, 'Tonya', 'Roman', 'contrerasangela@example.net', '524-711-8244', '1977-08-08', 'Immigration officer', 1062.5, 1063.5, 1064, 1057);
INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (1065, 'Tonya', 'Roman', 'contrerasangela@example.net', '524-711-8244', '1977-08-08', 'Immigration officer', 1062.5, 1063.5, 1064, 1057);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT employee_id, ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY salary DESC) FROM Employees;

/*
Gold Result:
(1061, 1)
(1065, 2)
*/

-- Prediction Query
SELECT employee_id, RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) FROM Employees;

/*
Prediction Result:
(1061, 1)
(1065, 1)
*/