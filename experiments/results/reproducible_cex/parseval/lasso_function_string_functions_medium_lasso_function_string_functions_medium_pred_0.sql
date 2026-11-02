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
INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483648, 'rwbbp', 'luhvdltti', 'bnp', 'emp_18196d', '2023-01-01', 'job_id_1', 986.066566, 666.330692, 907682809, -2147483648);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483647, 'ie5', 'nw6klf', 'a9000t5c4eci', 'emp_36a909', '2021-03-18', 'job_id_1', 44.682291, 73.182847, 1155439218, -2147483648);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (2, '52zb', 'uo4nrqrofqy', '5s5b', 'emp_18196d', '2020-04-03', 'job_id_1', 797.364011, 236.803246, 328305758, -2147483648);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (3, 'iqa', '1ryytoo', 'o9hl72kl', 'emp_18196d', '2020-10-31', 'job_id_1', 763.856372, 745.863768, 1775126557, -2147483648);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483646, '7zw', 'au2dwyrq13', 'yu78', 'emp_36a909', '2020-07-21', 'job_id_1', 550.03107, 272.376524, 1661181156, -2147483648);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483643, '4', 'p5qi2rk', '9v', 'emp_7655bc', '2022-12-15', 'job_id_1', 604.643336, 829.94159, 537874887, -2147483648);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483642, 'f8jegd21vy9u', 'j4hwbd', 'lph2gn', NULL, '2020-08-28', 'job_id_1', 893.16532, 254.83756, -1245682094, -2147483648);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483641, '5hncprjtu0d', '79fjgq8', 'n2f3dqv0gcb9', NULL, '2022-06-25', 'job_id_1', 874.028321, 836.121091, -155284187, -2147483648);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUBSTRING(phone, 1, 3) FROM Employees;

/*
Gold Result:
('emp',)
('emp',)
('emp',)
('emp',)
(None,)
(None,)
('emp',)
('emp',)
*/

-- Prediction Query
SELECT SUBSTRING(phone, 1, 4) FROM Employees;

/*
Prediction Result:
('emp_',)
('emp_',)
('emp_',)
('emp_',)
(None,)
(None,)
('emp_',)
('emp_',)
*/