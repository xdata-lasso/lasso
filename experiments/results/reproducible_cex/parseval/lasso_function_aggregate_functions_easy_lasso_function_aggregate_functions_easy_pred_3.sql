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
INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (1, 'rwbbp', 'luhvdltti', 'bnp', 'mdpos', '2021-06-28', 'job_id_1', 126.856521, 489.397796, 1861536320, -2147483648);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (2, 'fa9', '00t5c4e', 'cigce376nium', '52zbuo4nrq', '2023-01-30', 'job_id_1', 220.906948, 82.05602, -1031969798, -2147483648);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (3, '5bbp0', '2eutliqa11r', 'ytoo3o9', 'l7', '2024-12-21', 'job_id_1', 958.92567, 164.991544, -305670381, -2147483648);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (4, '7zwau2dwyr', '13pyu', '8d99rljsl', 'b4yp5qi', '2025-01-05', 'job_id_1', 272.94048, 811.601922, -705985602, -2147483648);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (5, 'pz0f8jegd', '1vy9uxj4', 'wb', 'v', '2022-01-29', 'job_id_1', 989.653112, 705.754562, -1642259219, -2147483648);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (6, 'q', 'nqcx5h', 'cprj', 'u0dz7', '2021-01-15', 'job_id_1', 154.065416, 261.415754, -1255130038, -2147483648);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (7, 'dqv0gcb98ozk', 'zbilyrkn', '6vck6ah0f8js', 'wlq7xb', '2025-11-20', 'job_id_1', 949.322482, 640.201736, 1350414441, -2147483648);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (8, '7ryfdrz16n', 'jja', '5dh', 'ogrgjd8y', '2024-05-29', 'job_id_1', 308.482994, 430.111467, 1250290042, -2147483648);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (9, 'ri', 'tsj3ayxp1q4', '01jh3den', 'c68x8vacx', '2025-10-14', 'job_id_1', 854.793228, 983.924121, -47052816, -2147483648);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(employee_id) FROM Employees;

/*
Gold Result:
(9,)
*/

-- Prediction Query
SELECT MIN(employee_id) FROM Employees;

/*
Prediction Result:
(1,)
*/