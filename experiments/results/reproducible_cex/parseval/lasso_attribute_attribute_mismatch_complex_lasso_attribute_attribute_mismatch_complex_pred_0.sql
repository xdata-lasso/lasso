-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: departments --
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (1, 'd_s_1dec44', -55602865, 'swwqcgsk');

INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (-2147483647, 'd_s_1dec44', 429706943, 'rmdp');

INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (2, 'd_s_1dec44', 902887186, 'qrofqyp5s5b');

INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (3, 'p', 882961052, '2eutliqa11r');

INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (4, '5k5swwqcgs', 247012447, '8c4pgu7vfe');

INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (-2147483643, NULL, -55602865, 'swwqcgsk');

INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (5, '9n8c4pgu7v', -1865039888, 'hria2ypuzhs');

-- Inserting into table: jobs --
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('job_id_1', '9n8c4pgu7v', 86.520366, 65.761562);

-- Inserting into table: employees --
INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483648, 'e_s_7e6f55', 'e_s_e826d8', 'hria2ypuzhs', 'rwbbp6luhvd', '2022-01-04', 'job_id_1', 50000.01, 303.05704, -1610064545, 1);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (2, 'e_s_7e6f55', 'e_s_e826d8', 'siie5unw6k', 'fa9', '2024-07-24', 'job_id_1', 50000.01, 627.258639, 947159877, 1);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (3, 'e_s_7e6f55', 'e_s_e826d8', 'c4ecigce', '76nium52', '2024-06-13', 'job_id_1', 50000.01, 21.917736, -747753377, 1);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483645, 'e_s_7e6f55', 'e_s_e826d8', 'ytoo3o9hl7', 'klex14ji', '2025-11-18', 'job_id_1', 50000.01, 394.443388, 481163439, 3);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483644, 'e_s_7e6f55', 'e_s_e826d8', '2dwyrq13pyu7', 'd99rljsl0', '2020-04-20', 'job_id_1', 50000.01, 470.165282, 1692174491, 3);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483643, 'e_s_7e6f55', 'e_s_e826d8', 'i2rkf', 'vqx58pz0f', '2021-08-12', 'job_id_1', 50000.01, 75.31458, -1937207087, 3);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483642, 'e_s_7e6f55', 'e_s_e826d8', 'wb', 'v', '2022-01-29', 'job_id_1', 50000.0, 989.653112, -1642259219, 1);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483641, 'e_s_7e6f55', 'e_s_e826d8', 'dqwn', 'cx5hn', '2020-06-20', 'job_id_1', 50000.01, 866.804244, -988981234, 1);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483640, 'e_s_7e6f55', NULL, '0dz79f', 'gq8', '2022-05-01', 'job_id_1', 50000.01, 450.823993, -1056308489, 1);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483639, NULL, 'e_s_e826d8', 'gcb98ozk3z', 'i', '2021-12-23', 'job_id_1', 50000.01, 728.712934, 638024588, 1);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (4, 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', 'bnp', '2023-01-01', 'job_id_1', NULL, 986.066566, 907682809, 4);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (5, 'wbbp6luhvdlt', 'ilbnp', 'mdpos', 'ie5', '2023-09-04', 'job_id_1', 50000.01, 933.422701, 44952191, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.first_name, e.last_name, d.department_name FROM Employees AS e JOIN Departments AS d ON e.department_id = d.department_id WHERE e.salary > 50000;

/*
Gold Result:
('e_s_7e6f55', 'e_s_e826d8', 'd_s_1dec44')
('e_s_7e6f55', 'e_s_e826d8', 'p')
('e_s_7e6f55', 'e_s_e826d8', 'p')
('e_s_7e6f55', 'e_s_e826d8', 'p')
('e_s_7e6f55', 'e_s_e826d8', 'd_s_1dec44')
('e_s_7e6f55', None, 'd_s_1dec44')
(None, 'e_s_e826d8', 'd_s_1dec44')
('e_s_7e6f55', 'e_s_e826d8', 'd_s_1dec44')
('e_s_7e6f55', 'e_s_e826d8', 'd_s_1dec44')
('wbbp6luhvdlt', 'ilbnp', '9n8c4pgu7v')
*/

-- Prediction Query
SELECT e.email, e.last_name, d.department_name FROM Employees AS e JOIN Departments AS d ON e.department_id = d.department_id WHERE e.salary > 50000;

/*
Prediction Result:
('hria2ypuzhs', 'e_s_e826d8', 'd_s_1dec44')
('ytoo3o9hl7', 'e_s_e826d8', 'p')
('2dwyrq13pyu7', 'e_s_e826d8', 'p')
('i2rkf', 'e_s_e826d8', 'p')
('dqwn', 'e_s_e826d8', 'd_s_1dec44')
('0dz79f', None, 'd_s_1dec44')
('gcb98ozk3z', 'e_s_e826d8', 'd_s_1dec44')
('siie5unw6k', 'e_s_e826d8', 'd_s_1dec44')
('c4ecigce', 'e_s_e826d8', 'd_s_1dec44')
('mdpos', 'ilbnp', '9n8c4pgu7v')
*/