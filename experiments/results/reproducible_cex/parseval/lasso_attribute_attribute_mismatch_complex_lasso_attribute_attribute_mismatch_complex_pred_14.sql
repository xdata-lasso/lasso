-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: departments --
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (1, 'd_s_ad71a7', -55602865, 'swwqcgsk');

INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (2, 'd_s_ad71a7', 429706943, 'rmdp');

INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (-2147483647, 'd_s_ad71a7', 2026480202, 'ie5');

INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (3, '5c4ec', -1683203397, 'e376nium52');

INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (4, '5k5swwqcgs', 247012447, '8c4pgu7vfe');

INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (-2147483643, NULL, -55602865, 'swwqcgsk');

INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (5, '9n8c4pgu7v', -1865039888, 'hria2ypuzhs');

-- Inserting into table: jobs --
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('job_id_1', '9n8c4pgu7v', 86.520366, 65.761562);

-- Inserting into table: employees --
INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483648, 'e_s_14725b', 'e_s_a6da13', 'hria2ypuzhs', 'rwbbp6luhvd', '2022-01-04', 'job_id_1', 50000.01, 303.05704, -1610064545, 1);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (2, 'e_s_14725b', 'e_s_a6da13', 'w6kl', 'a9', '2024-07-24', 'job_id_1', 50000.01, 627.258639, 947159877, 2);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (3, 'e_s_14725b', 'e_s_a6da13', 'u', '4nrq', '2023-01-30', 'job_id_1', 50000.01, 220.906948, -1031969798, 3);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483645, 'e_s_14725b', 'e_s_a6da13', 's5bbp02e', 'tliqa1', '2024-10-14', 'job_id_1', 50000.01, 274.580687, 274769912, 3);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483644, 'e_s_14725b', 'e_s_a6da13', 'oo3o9hl72kl', 'x1', '2025-05-30', 'job_id_1', 50000.01, 144.777217, -453362185, 3);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483643, 'e_s_14725b', 'e_s_a6da13', '2dwyrq', '3pyu78d', '2023-01-20', 'job_id_1', 50000.01, 182.777264, -904834265, 3);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483642, 'e_s_14725b', 'e_s_a6da13', '2rk', '9v', '2022-12-15', 'job_id_1', 50000.0, 604.643336, 537874887, 1);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483641, 'e_s_14725b', 'e_s_a6da13', 'f8jegd2', 'vy9uxj4', '2021-05-25', 'job_id_1', 50000.01, 353.366837, -1929953647, 1);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483640, 'e_s_14725b', NULL, 'h2gn', 'q', '2023-11-15', 'job_id_1', 50000.01, 209.967034, -1660358170, 1);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483639, NULL, 'e_s_a6da13', 'rjtu', 'dz79fjg', '2022-12-06', 'job_id_1', 50000.01, 541.805676, 894242932, 1);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (4, 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', 'bnp', '2023-01-01', 'job_id_1', NULL, 986.066566, 907682809, 4);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (5, 'wbbp6luhvdlt', 'ilbnp', 'mdpos', 'ie5', '2023-09-04', 'job_id_1', 50000.01, 933.422701, 44952191, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.first_name, e.last_name, d.department_name FROM Employees AS e JOIN Departments AS d ON e.department_id = d.department_id WHERE e.salary > 50000;

/*
Gold Result:
('e_s_14725b', 'e_s_a6da13', 'd_s_ad71a7')
('e_s_14725b', 'e_s_a6da13', '5c4ec')
('e_s_14725b', 'e_s_a6da13', '5c4ec')
('e_s_14725b', 'e_s_a6da13', '5c4ec')
('e_s_14725b', 'e_s_a6da13', 'd_s_ad71a7')
('e_s_14725b', None, 'd_s_ad71a7')
(None, 'e_s_a6da13', 'd_s_ad71a7')
('e_s_14725b', 'e_s_a6da13', 'd_s_ad71a7')
('e_s_14725b', 'e_s_a6da13', '5c4ec')
('wbbp6luhvdlt', 'ilbnp', '9n8c4pgu7v')
*/

-- Prediction Query
SELECT e.first_name, hire_date, d.department_name FROM Employees AS e JOIN Departments AS d ON e.department_id = d.department_id WHERE e.salary > 50000;

/*
Prediction Result:
('e_s_14725b', '2022-01-04', 'd_s_ad71a7')
('e_s_14725b', '2024-10-14', '5c4ec')
('e_s_14725b', '2025-05-30', '5c4ec')
('e_s_14725b', '2023-01-20', '5c4ec')
('e_s_14725b', '2021-05-25', 'd_s_ad71a7')
('e_s_14725b', '2023-11-15', 'd_s_ad71a7')
(None, '2022-12-06', 'd_s_ad71a7')
('e_s_14725b', '2024-07-24', 'd_s_ad71a7')
('e_s_14725b', '2023-01-30', '5c4ec')
('wbbp6luhvdlt', '2023-09-04', '9n8c4pgu7v')
*/