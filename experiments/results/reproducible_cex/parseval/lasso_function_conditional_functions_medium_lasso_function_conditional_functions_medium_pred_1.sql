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
INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483648, 'rwbbp', 'luhvdltti', 'bnp', 'mdpos', '2021-06-28', 'job_id_1', 1.0, 126.856521, -45536098, -2147483648);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483647, 'klfa9000t', 'c4ecigce', '76nium52', 'zbuo4nrqrof', '2022-11-29', 'job_id_1', 1.0, 389.878901, -921187550, -2147483648);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483646, '02eu', 'liqa1', 'ryytoo3', '9hl7', '2024-12-21', 'job_id_1', 1.0, 958.92567, -1438850342, -2147483648);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483645, '4ji7zwa', '2dwyrq', '3pyu78d', '9rljsl0b4', '2024-04-25', 'job_id_1', 100000.01, 598.741024, -1116181514, -2147483648);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (2, 'rkf9vqx5', 'pz0f8jegd', '1vy9uxj4', 'wb', '2020-07-26', 'job_id_1', 1.0, 328.40866, 2103044118, -2147483648);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (3, 'nd', 'wnqcx', '5hncprjtu0d', '79fjgq8', '2022-05-01', 'job_id_1', 1.0, 450.823993, -1056308489, -2147483648);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483644, 'cb98ozk3zbil', 'yrkn6vck6ah0', '8j', 'wwlq7', '2024-02-16', 'job_id_1', 1.0, 21.129657, -541746689, -2147483648);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483641, 'dr', 'z16nijjai5d', 'h5ogrgjd8yz', '1afgo', '2021-03-06', 'job_id_1', 1.0, 279.731401, -902895762, -2147483648);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483640, 'xp1q430', 'jh3den8', 'c68x8vacx7', 'f', '2023-07-08', 'job_id_1', NULL, 819.265503, -290314193, -2147483648);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483639, 'o72ctdc', 'mfg62', '0v', 'q8qdjpe1', '2021-07-27', 'job_id_1', NULL, 941.839689, -241848752, -2147483648);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483638, '7cvtjpttg6b', 'ou5z', '36c', 'bfkfoacd', '2024-08-20', 'job_id_1', 1.0, 668.776683, 76987628, -2147483648);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483637, 'zj', '7wgx', '5', 'sxcmr0o', '2024-07-19', 'job_id_1', 100000.0, 297.258735, -1699185893, -2147483648);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CASE WHEN salary > 100000 THEN 'High' ELSE 'Low' END FROM Employees;

/*
Gold Result:
('Low',)
('Low',)
('Low',)
('High',)
('Low',)
('Low',)
('Low',)
('Low',)
('Low',)
('Low',)
('Low',)
('Low',)
*/

-- Prediction Query
SELECT CASE WHEN salary > 100000 THEN 'Low' ELSE 'High' END FROM Employees;

/*
Prediction Result:
('High',)
('High',)
('High',)
('Low',)
('High',)
('High',)
('High',)
('High',)
('High',)
('High',)
('High',)
('High',)
*/