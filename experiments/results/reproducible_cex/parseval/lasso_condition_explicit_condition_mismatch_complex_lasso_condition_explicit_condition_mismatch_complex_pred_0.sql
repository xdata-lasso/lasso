-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: departments --
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (-2147483648, '5k5swwqcgs', 247012447, '8c4pgu7vfe');

-- Inserting into table: jobs --
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('job_id_1', 'hria2ypu', 882.963176, 841.297061);

-- Inserting into table: employees --
INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483648, 'emp_c06df8', 'rwbbp', 'luhvdltti', 'bnp', '2023-01-01', 'job_id_1', 50000.0, 1.0, 2087640001, -2147483648);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (2, 'emp_c06df8', 'siie', 'unw6klfa', '9000t5c4ec', '2021-06-11', 'job_id_1', 50000.0, 1.0, 1149850321, -2147483648);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (3, 'emp_c06df8', '76nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2024-12-15', 'job_id_1', 50001.0, 1.0, -1822992503, -2147483648);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483645, 'emp_c06df8', 'qa1', 'ryytoo3', '9hl7', '2024-12-21', 'job_id_1', 100001.0, 1.0, -1438850342, -2147483648);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483644, 'emp_c06df8', '4ji7zwa', '2dwyrq', '3pyu78d', '2023-01-20', 'job_id_1', 50000.0, NULL, -1362461264, -2147483648);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483643, NULL, 'b4yp5qi', 'rkf9vqx5', 'pz0f8jegd', '2025-01-26', 'job_id_1', 50000.0, 1.0, 1675430660, -2147483648);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (4, '9uxj4hwbdvl', 'h2gn', 'q', 'nqcx5h', '2022-05-10', 'job_id_1', 50000.0, NULL, -1106350634, -2147483648);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (5, '0dz79f', 'gq8', 'n2f3dqv0gcb9', 'ozk3zbily', '2023-02-18', 'job_id_1', 50000.0, NULL, 1038566008, -2147483648);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (6, 'k', 'ah0f8jsww', 'q7x', '7', '2024-12-09', 'job_id_1', 50000.0, NULL, 1350414441, -2147483648);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (7, '7ryfdrz16n', 'jja', '5dh', 'ogrgjd8y', '2024-05-29', 'job_id_1', 50000.0, NULL, 1250290042, -2147483648);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name FROM Employees WHERE salary BETWEEN 50000 AND 100000 AND NOT commission_pct IS NULL;

/*
Gold Result:
('emp_c06df8',)
(None,)
('emp_c06df8',)
('emp_c06df8',)
*/

-- Prediction Query
SELECT first_name FROM Employees WHERE salary > 50000 AND commission_pct > 0.1;

/*
Prediction Result:
('emp_c06df8',)
('emp_c06df8',)
*/