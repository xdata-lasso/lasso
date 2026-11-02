-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: departments --
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (1, 'd_s_be38f4', -55602865, 'swwqcgsk');

INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (2, 'd_s_be38f4', -1137908826, 'siie5unw6k');

INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (-2147483647, 'd_s_be38f4', 1151980946, 'a9');

INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (3, 'bbp02eutliqa', -314162272, 'ytoo3o9');

INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (-2147483644, NULL, -55602865, 'swwqcgsk');

INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (4, '9n8c4pgu7v', -1865039888, 'hria2ypuzhs');

INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (-2147483642, NULL, 1151980946, 'a9');

INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (5, '00t5c4e', 1274489983, 'gce');

INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (-2147483640, NULL, -868774469, 'qa1');

INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (6, 'ryytoo3', -1666765085, '72klex14ji7z');

-- Inserting into table: jobs --
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('job_id_1', '9n8c4pgu7v', 86.520366, 65.761562);

-- Inserting into table: employees --
INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483648, 'e_s_caa488', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', '2022-01-16', 'job_id_1', 22.535764, 600.048938, 462974032, 1);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (2, 'e_s_caa488', '00t5c4ecigc', 'e376nium52', 'zbuo4nrqrof', '2022-11-29', 'job_id_1', 389.878901, 488.977171, -921187550, 2);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (3, 'e_s_caa488', '72k', 'ex1', 'ji7zwau2', '2020-08-25', 'job_id_1', 845.831524, 721.918386, -511185946, 3);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483645, 'e_s_caa488', '3pyu78d', '9rljsl0b4', 'p5qi2rk', '2021-01-15', 'job_id_1', 551.785129, 263.638479, 556727997, 2);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483644, 'e_s_caa488', 'pz0f8jegd', '1vy9uxj4', 'wb', '2020-07-26', 'job_id_1', 328.40866, 989.653112, -1642259219, 2);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483643, NULL, 'qcx5', 'hncprjtu0dz', '9fjgq8n2f', '2025-02-11', 'job_id_1', 687.701166, 656.638403, 513454646, 1);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483642, 'e_s_caa488', 'gcb98oz', '3zb', 'lyr', '2021-11-28', 'job_id_1', 615.222139, 203.331848, 32204797, 1);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (4, 'wbbp6luhvdlt', 'ilbnp', 'mdpos', 'ie5', '2023-09-04', 'job_id_1', 933.422701, 345.718563, 44952191, 4);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (5, '6nium52zb', 'uo4nrqrofqy', '5s5b', 'p', '2024-08-27', 'job_id_1', 673.065986, 825.231787, -1822992503, 5);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (6, 'au2dwyrq13', 'yu78', '9', 'rljsl0b4y', '2022-09-10', 'job_id_1', 495.297639, 261.217059, -227162283, 6);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.first_name, d.department_name FROM Employees AS e JOIN Departments AS d ON e.department_id = d.department_id;

/*
Gold Result:
('e_s_caa488', 'd_s_be38f4')
('e_s_caa488', 'd_s_be38f4')
('e_s_caa488', 'd_s_be38f4')
(None, 'd_s_be38f4')
('e_s_caa488', 'd_s_be38f4')
('e_s_caa488', 'd_s_be38f4')
('e_s_caa488', 'bbp02eutliqa')
('wbbp6luhvdlt', '9n8c4pgu7v')
('6nium52zb', '00t5c4e')
('au2dwyrq13', 'ryytoo3')
*/

-- Prediction Query
SELECT e.first_name, d.department_name FROM Employees AS e JOIN Departments AS d ON e.department_id = e.department_id;

/*
Prediction Result:
('e_s_caa488', 'd_s_be38f4')
('e_s_caa488', None)
('e_s_caa488', None)
('e_s_caa488', None)
('e_s_caa488', 'd_s_be38f4')
('e_s_caa488', 'd_s_be38f4')
('e_s_caa488', 'bbp02eutliqa')
('e_s_caa488', '9n8c4pgu7v')
('e_s_caa488', '00t5c4e')
('e_s_caa488', 'ryytoo3')
('e_s_caa488', 'd_s_be38f4')
('e_s_caa488', None)
('e_s_caa488', None)
('e_s_caa488', None)
('e_s_caa488', 'd_s_be38f4')
('e_s_caa488', 'd_s_be38f4')
('e_s_caa488', 'bbp02eutliqa')
('e_s_caa488', '9n8c4pgu7v')
('e_s_caa488', '00t5c4e')
('e_s_caa488', 'ryytoo3')
('e_s_caa488', 'd_s_be38f4')
('e_s_caa488', None)
('e_s_caa488', None)
('e_s_caa488', None)
('e_s_caa488', 'd_s_be38f4')
('e_s_caa488', 'd_s_be38f4')
('e_s_caa488', 'bbp02eutliqa')
('e_s_caa488', '9n8c4pgu7v')
('e_s_caa488', '00t5c4e')
('e_s_caa488', 'ryytoo3')
(None, 'd_s_be38f4')
(None, None)
(None, None)
(None, None)
(None, 'd_s_be38f4')
(None, 'd_s_be38f4')
(None, 'bbp02eutliqa')
(None, '9n8c4pgu7v')
(None, '00t5c4e')
(None, 'ryytoo3')
('e_s_caa488', 'd_s_be38f4')
('e_s_caa488', None)
('e_s_caa488', None)
('e_s_caa488', None)
('e_s_caa488', 'd_s_be38f4')
('e_s_caa488', 'd_s_be38f4')
('e_s_caa488', 'bbp02eutliqa')
('e_s_caa488', '9n8c4pgu7v')
('e_s_caa488', '00t5c4e')
('e_s_caa488', 'ryytoo3')
('e_s_caa488', 'd_s_be38f4')
('e_s_caa488', None)
('e_s_caa488', None)
('e_s_caa488', None)
('e_s_caa488', 'd_s_be38f4')
('e_s_caa488', 'd_s_be38f4')
('e_s_caa488', 'bbp02eutliqa')
('e_s_caa488', '9n8c4pgu7v')
('e_s_caa488', '00t5c4e')
('e_s_caa488', 'ryytoo3')
('e_s_caa488', 'd_s_be38f4')
('e_s_caa488', None)
('e_s_caa488', None)
('e_s_caa488', None)
('e_s_caa488', 'd_s_be38f4')
('e_s_caa488', 'd_s_be38f4')
('e_s_caa488', 'bbp02eutliqa')
('e_s_caa488', '9n8c4pgu7v')
('e_s_caa488', '00t5c4e')
('e_s_caa488', 'ryytoo3')
('wbbp6luhvdlt', 'd_s_be38f4')
('wbbp6luhvdlt', None)
('wbbp6luhvdlt', None)
('wbbp6luhvdlt', None)
('wbbp6luhvdlt', 'd_s_be38f4')
('wbbp6luhvdlt', 'd_s_be38f4')
('wbbp6luhvdlt', 'bbp02eutliqa')
('wbbp6luhvdlt', '9n8c4pgu7v')
('wbbp6luhvdlt', '00t5c4e')
('wbbp6luhvdlt', 'ryytoo3')
('6nium52zb', 'd_s_be38f4')
('6nium52zb', None)
('6nium52zb', None)
('6nium52zb', None)
('6nium52zb', 'd_s_be38f4')
('6nium52zb', 'd_s_be38f4')
('6nium52zb', 'bbp02eutliqa')
('6nium52zb', '9n8c4pgu7v')
('6nium52zb', '00t5c4e')
('6nium52zb', 'ryytoo3')
('au2dwyrq13', 'd_s_be38f4')
('au2dwyrq13', None)
('au2dwyrq13', None)
('au2dwyrq13', None)
('au2dwyrq13', 'd_s_be38f4')
('au2dwyrq13', 'd_s_be38f4')
('au2dwyrq13', 'bbp02eutliqa')
('au2dwyrq13', '9n8c4pgu7v')
('au2dwyrq13', '00t5c4e')
('au2dwyrq13', 'ryytoo3')
*/