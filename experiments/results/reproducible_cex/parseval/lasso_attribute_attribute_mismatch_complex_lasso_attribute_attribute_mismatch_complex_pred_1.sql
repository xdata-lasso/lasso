-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: departments --
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (1, 'd_s_62ae8b', -55602865, 'swwqcgsk');

INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (-2147483647, 'd_s_62ae8b', 429706943, 'rmdp');

INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (3, '5c4ec', -1683203397, 'e376nium52');

INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (2, 'd_s_62ae8b', -1106983592, '5bbp0');

INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (4, '5k5swwqcgs', 247012447, '8c4pgu7vfe');

INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (5, '5k5swwqcgs', 247012447, '8c4pgu7vfe');

INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (-2147483642, NULL, -1633151678, 'a2y');

-- Inserting into table: jobs --
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('job_id_1', '9n8c4pgu7v', 86.520366, 65.761562);

-- Inserting into table: employees --
INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483648, 'e_s_17d56b', 'e_s_6906e9', 'hria2ypuzhs', 'rwbbp6luhvd', '2022-01-04', 'job_id_1', 50000.01, 303.05704, -1610064545, 1);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (2, 'e_s_17d56b', 'e_s_6906e9', 'siie5unw6k', 'fa9', '2024-07-24', 'job_id_1', 50000.01, 627.258639, 947159877, 1);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (3, 'e_s_17d56b', 'e_s_6906e9', 'u', '4nrq', '2023-01-30', 'job_id_1', 50000.01, 220.906948, -1031969798, 3);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483645, 'e_s_17d56b', 'e_s_6906e9', 'eutliqa11r', 'ytoo3o9', '2021-04-03', 'job_id_1', 50000.01, 187.343342, 90119032, 3);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483644, 'e_s_17d56b', 'e_s_6906e9', 'ex1', 'ji7zwau2', '2020-08-25', 'job_id_1', 50000.01, 845.831524, -511185946, 3);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483643, 'e_s_17d56b', 'e_s_6906e9', '3pyu78d', '9rljsl0b4', '2024-04-25', 'job_id_1', 50000.01, 598.741024, -1116181514, 3);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483642, 'e_s_17d56b', 'e_s_6906e9', 'x58pz', 'f8jegd2', '2024-11-12', 'job_id_1', 50000.0, 339.69384, -792092619, 1);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483641, 'e_s_17d56b', 'e_s_6906e9', 'hwbdvlph', 'gndqwnqc', '2024-02-11', 'job_id_1', 50000.01, 668.309685, 580968159, 1);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483640, 'e_s_17d56b', NULL, 'p', 'jtu0d', '2024-06-09', 'job_id_1', 50000.01, 521.610309, -1748371085, 1);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483639, NULL, 'e_s_6906e9', '8n2f3', 'dqv0gcb98ozk', '2025-03-14', 'job_id_1', 50000.01, 395.957566, -2078052421, 1);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (4, 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', 'bnp', '2023-01-01', 'job_id_1', NULL, 986.066566, 907682809, 4);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (5, 'uzhsrwbbp6lu', 'hvdlttilbnpr', 'dpos', 'ie5', '2023-09-04', 'job_id_1', 50000.01, 933.422701, 44952191, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.first_name, e.last_name, d.department_name FROM Employees AS e JOIN Departments AS d ON e.department_id = d.department_id WHERE e.salary > 50000;

/*
Gold Result:
('e_s_17d56b', 'e_s_6906e9', 'd_s_62ae8b')
('e_s_17d56b', 'e_s_6906e9', '5c4ec')
('e_s_17d56b', 'e_s_6906e9', '5c4ec')
('e_s_17d56b', 'e_s_6906e9', '5c4ec')
('e_s_17d56b', 'e_s_6906e9', 'd_s_62ae8b')
('e_s_17d56b', None, 'd_s_62ae8b')
(None, 'e_s_6906e9', 'd_s_62ae8b')
('e_s_17d56b', 'e_s_6906e9', 'd_s_62ae8b')
('e_s_17d56b', 'e_s_6906e9', '5c4ec')
('uzhsrwbbp6lu', 'hvdlttilbnpr', '5k5swwqcgs')
*/

-- Prediction Query
SELECT e.first_name, e.last_name, d.location FROM Employees AS e JOIN Departments AS d ON e.department_id = d.department_id WHERE e.salary > 50000;

/*
Prediction Result:
('e_s_17d56b', 'e_s_6906e9', 'swwqcgsk')
('e_s_17d56b', 'e_s_6906e9', 'e376nium52')
('e_s_17d56b', 'e_s_6906e9', 'e376nium52')
('e_s_17d56b', 'e_s_6906e9', 'e376nium52')
('e_s_17d56b', 'e_s_6906e9', 'swwqcgsk')
('e_s_17d56b', None, 'swwqcgsk')
(None, 'e_s_6906e9', 'swwqcgsk')
('e_s_17d56b', 'e_s_6906e9', 'swwqcgsk')
('e_s_17d56b', 'e_s_6906e9', 'e376nium52')
('uzhsrwbbp6lu', 'hvdlttilbnpr', '8c4pgu7vfe')
*/