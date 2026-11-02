-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: departments --
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (1, 'd_s_738c22', -55602865, 'swwqcgsk');

INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (-2147483647, 'd_s_738c22', -1137908826, 'siie5unw6k');

INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (2, 'd_s_738c22', 624571013, 'o9hl72kl');

INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (3, 'x1', -74849714, '7zw');

INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (4, '5k5swwqcgs', 247012447, '8c4pgu7vfe');

INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (-2147483643, NULL, -1633151678, 'a2y');

INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (5, 'fa9', 1620389964, '00t5c4ecigc');

INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (-2147483641, NULL, 528680845, '76nium52');

INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (6, 'liqa1', 2074205376, 'yytoo');

INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (-2147483639, NULL, 1644911394, '9hl7');

-- Inserting into table: jobs --
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('job_id_1', '9n8c4pgu7v', 86.520366, 65.761562);

-- Inserting into table: employees --
INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483648, 'e_s_0ae950', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', '2022-01-16', 'job_id_1', 22.535764, 600.048938, 462974032, 1);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (2, 'e_s_0ae950', 'a9', '00t5c4e', 'cigce376nium', '2025-06-20', 'job_id_1', 452.706544, 672.826911, -747753377, 1);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (3, 'e_s_0ae950', 'rqro', 'fqyp5s5bbp0', '2eutliqa11r', '2024-03-30', 'job_id_1', 881.232072, 377.535852, 1898504886, 1);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483645, 'e_s_0ae950', '2dwyrq', '3pyu78d', '9rljsl0b4', '2024-04-25', 'job_id_1', 598.741024, 240.118738, 1255852738, 3);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483644, 'e_s_0ae950', 'rkf9vqx5', 'pz0f8jegd', '1vy9uxj4', '2021-05-25', 'job_id_1', 353.366837, 50.647649, 1581736075, 3);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483643, 'e_s_0ae950', 'nqcx5h', 'cprj', 'u0dz7', '2021-01-15', 'job_id_1', 154.065416, 261.415754, -1255130038, 1);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483642, NULL, 'dqv0gcb9', 'ozk3zbily', 'kn6vc', '2021-10-25', 'job_id_1', 508.771546, 591.134092, 834709651, 1);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (4, 'uzhsrwbbp6lu', 'hvdlttilbnpr', 'dpos', 'ie5', '2023-09-04', 'job_id_1', 933.422701, 345.718563, 44952191, 4);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (5, 'u', '4nrq', 'rofqyp5s5b', 'p', '2024-08-27', 'job_id_1', 673.065986, 825.231787, -1822992503, 5);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (6, 'lex', '4ji7zwa', '2dwyrq', '3pyu78d', '2023-01-20', 'job_id_1', 182.777264, 943.791649, -904834265, 6);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.first_name, d.department_name FROM Employees AS e JOIN Departments AS d ON e.department_id = d.department_id;

/*
Gold Result:
('e_s_0ae950', 'd_s_738c22')
('e_s_0ae950', 'x1')
('e_s_0ae950', 'x1')
('e_s_0ae950', 'd_s_738c22')
(None, 'd_s_738c22')
('e_s_0ae950', 'd_s_738c22')
('e_s_0ae950', 'd_s_738c22')
('uzhsrwbbp6lu', '5k5swwqcgs')
('u', 'fa9')
('lex', 'liqa1')
*/

-- Prediction Query
SELECT e.first_name, d.department_name FROM Employees AS e JOIN Departments AS d ON e.manager_id = d.manager_id;

/*
Prediction Result:
*/