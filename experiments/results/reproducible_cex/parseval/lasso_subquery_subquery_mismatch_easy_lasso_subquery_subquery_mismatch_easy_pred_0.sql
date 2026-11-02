-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: departments --
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (1, '5k5swwqcgs', 247012447, 'New York');

INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (-2147483648, '8c4pgu7vfe', -1633151678, 'New York');

-- Inserting into table: jobs --
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('job_id_1', 'a2y', 797.015047, 241.913711);

-- Inserting into table: employees --
INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (2, 'emp_342d63', 'zhsrwb', 'p', 'luhvdltti', '2022-01-16', 'job_id_1', 22.535764, 600.048938, 462974032, 1);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (3, 'emp_342d63', 'siie', 'unw6klfa', '9000t5c4ec', '2021-06-11', 'job_id_1', 734.586266, 767.720387, -1833165707, 1);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483646, 'emp_342d63', 'um5', 'zbuo4nrq', 'rofqyp5s5b', '2020-04-03', 'job_id_1', 797.364011, 236.803246, 328305758, 1);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483645, NULL, 'liqa1', 'ryytoo3', '9hl7', '2024-12-21', 'job_id_1', 958.92567, 164.991544, -305670381, 1);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483644, 'emp_342d63', '7zw', 'au2dwyrq13', 'yu78', '2020-07-21', 'job_id_1', 550.03107, 272.376524, 1661181156, 1);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (4, 'b4yp5qi', 'rkf9vqx5', 'pz0f8jegd', '1vy9uxj4', '2021-05-25', 'job_id_1', 353.366837, 50.647649, 1581736075, -2147483648);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (5, 'nd', 'wnqcx', '5hncprjtu0d', '79fjgq8', '2022-05-01', 'job_id_1', 450.823993, 456.127515, -1056308489, -2147483648);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (6, 'gcb98ozk3z', 'i', 'yrk', 'n6vck6ah0f', '2025-12-20', 'job_id_1', 145.983385, 346.706184, -1388029300, -2147483648);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (7, '7', '2fxa7ryfdrz', '16nijjai5dh', 'ogrgjd8y', '2024-05-29', 'job_id_1', 308.482994, 430.111467, 1250290042, -2147483648);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name FROM Employees WHERE department_id IN (SELECT department_id FROM Departments WHERE location = 'New York');

/*
Gold Result:
('emp_342d63',)
(None,)
('emp_342d63',)
('emp_342d63',)
('emp_342d63',)
('b4yp5qi',)
('nd',)
('gcb98ozk3z',)
('7',)
*/

-- Prediction Query
SELECT first_name FROM Employees WHERE department_id IN (SELECT manager_id FROM Departments WHERE location = 'New York');

/*
Prediction Result:
*/