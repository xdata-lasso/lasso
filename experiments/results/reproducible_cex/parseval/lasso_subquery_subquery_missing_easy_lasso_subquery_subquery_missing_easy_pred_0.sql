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
INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (2, 'emp_a2d5e9', 'rwbbp', 'luhvdltti', 'bnp', '2023-01-01', 'job_id_1', 986.066566, 666.330692, 907682809, -2147483648);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (3, 'emp_a2d5e9', 'ie5', 'nw6klf', 'a9000t5c4eci', '2021-03-18', 'job_id_1', 44.682291, 73.182847, 1155439218, -2147483648);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483646, 'emp_a2d5e9', '52zb', 'uo4nrqrofqy', '5s5b', '2020-04-03', 'job_id_1', 797.364011, 236.803246, 328305758, -2147483648);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483645, 'iqa', '1ryytoo', 'o9hl72kl', 'x1', '2025-05-30', 'job_id_1', NULL, 144.777217, -453362185, -2147483648);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483644, '2dwyrq13pyu7', 'd99rljsl0', '4', 'p5qi2rk', '2021-01-15', 'job_id_1', NULL, 551.785129, 556727997, -2147483648);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483643, NULL, 'z0f8jegd21vy', '9uxj4hwbdvl', 'h2gn', '2020-08-28', 'job_id_1', 893.16532, 254.83756, -1245682094, -2147483648);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483642, NULL, '5hncprjtu0d', '79fjgq8', 'n2f3dqv0gcb9', '2022-06-25', 'job_id_1', 874.028321, 836.121091, -155284187, -2147483648);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483641, NULL, 'yrk', 'n6vck6ah0f', 'jswwlq7xb', '2025-11-20', 'job_id_1', NULL, 949.322482, 602161869, -2147483648);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483640, NULL, '7', 'yfdrz', '16nijjai5dh', '2025-06-24', 'job_id_1', NULL, 849.655083, -1738458256, -2147483648);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483639, 'emp_a2d5e9', '8', 'yzt1afgogrit', 'sj3ayxp1q430', '2024-10-12', 'job_id_1', 571.595144, 620.748111, 1948383687, -2147483648);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name FROM Employees WHERE salary > (SELECT AVG(salary) FROM Employees);

/*
Gold Result:
('emp_a2d5e9',)
(None,)
(None,)
('emp_a2d5e9',)
*/

-- Prediction Query
SELECT first_name FROM Employees WHERE salary > 1000;

/*
Prediction Result:
*/