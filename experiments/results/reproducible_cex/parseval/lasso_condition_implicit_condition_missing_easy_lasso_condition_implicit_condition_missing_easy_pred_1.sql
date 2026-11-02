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
INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483648, 'emp_81f554', 'rwbbp', 'luhvdltti', 'bnp', '2023-01-01', 'job_id_1', 986.066566, 1.0, 907682809, -2147483648);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (2, 'emp_81f554', 'ie5', 'nw6klf', 'a9000t5c4eci', '2021-03-18', 'job_id_1', 44.682291, 1.0, -1833165707, -2147483648);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (3, 'emp_81f554', 'm52zbu', '4nrq', 'rofqyp5s5b', '2020-04-03', 'job_id_1', 797.364011, 1.0, 328305758, -2147483648);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483645, 'emp_81f554', 'iqa', '1ryytoo', 'o9hl72kl', '2020-10-31', 'job_id_1', 763.856372, NULL, 1055976837, -2147483648);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483644, NULL, 'i7z', 'au2dwy', 'q13py', '2023-09-01', 'job_id_1', 520.715697, 1.0, 176380444, -2147483648);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (4, 'sl0', '4', 'p5qi2rk', '9v', '2022-12-15', 'job_id_1', 604.643336, NULL, 537874887, -2147483648);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (5, 'f8jegd21vy9u', 'j4hwbd', 'lph2gn', 'q', '2023-11-15', 'job_id_1', 209.967034, NULL, -1660358170, -2147483648);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (6, 'jtu0d', '79fjgq8', 'n2f3dqv0gcb9', 'ozk3zbily', '2023-02-18', 'job_id_1', 741.809988, NULL, 32204797, -2147483648);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (7, 'ah0f8jsww', 'q7x', '7', '2fxa7ryfdrz', '2024-11-10', 'job_id_1', 569.30821, NULL, -1259474148, -2147483648);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (8, 'i', 'dh5ogrgj', '8', 'yzt1afgogrit', '2023-04-01', 'job_id_1', 155.845079, NULL, -491938169, -2147483648);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name FROM Employees WHERE NOT commission_pct IS NULL;

/*
Gold Result:
('emp_81f554',)
(None,)
('emp_81f554',)
('emp_81f554',)
*/

-- Prediction Query
SELECT first_name FROM Employees WHERE commission_pct IS NULL;

/*
Prediction Result:
('emp_81f554',)
('sl0',)
('f8jegd21vy9u',)
('jtu0d',)
('ah0f8jsww',)
('i',)
*/