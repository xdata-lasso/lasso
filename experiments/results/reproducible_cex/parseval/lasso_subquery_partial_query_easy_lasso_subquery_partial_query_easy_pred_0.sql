-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: departments --
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (1, '5k5swwqcgs', 247012447, '8c4pgu7vfe');

INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (2, 'unw6klfa', 1419861592, '4ecigce376n');

INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (3, 'liqa1', 2074205376, 'yytoo');

INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (4, 'b4yp5qi', -227162283, 'f9v');

INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (5, 'nd', -1052964641, 'qcx5');

INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (6, 'i', -512640349, 'kn6vck6ah0f8');

INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (7, 'rg', -1478247928, 'yzt1afgog');

-- Inserting into table: jobs --
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('job_id_1', 'hria2ypuzhs', 663.049759, 711.020062);

-- Inserting into table: employees --
INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (1, 'b', 'p6luhvdlttil', 'n', 'rmdp', '2022-07-21', 'job_id_1', 619.836822, 286.037632, -1602639011, 1);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (2, '52zb', 'uo4nrqrofqy', '5s5b', 'p', '2024-08-27', 'job_id_1', 673.065986, 825.231787, -1822992503, 1);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (3, 'hl72klex1', 'ji7zwau2', 'dwyrq13pyu78', '9', '2023-01-20', 'job_id_1', 182.777264, 943.791649, -904834265, 2);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (4, '8pz0f8je', 'd2', 'vy9uxj4', 'wb', '2020-07-26', 'job_id_1', 328.40866, 989.653112, -1642259219, 3);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (5, 'p', 'jtu0d', '79fjgq8', 'n2f3dqv0gcb9', '2022-06-25', 'job_id_1', 874.028321, 836.121091, -155284187, 1);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (6, 'wlq7xb', '72fxa7ryfd', 'z16ni', 'jai', '2025-08-02', 'job_id_1', 62.386264, 816.712865, 1583472758, 2);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (7, 'tsj3ayxp1q4', '01jh3den', 'c68x8vacx', 'afu5w1of7', '2025-10-22', 'job_id_1', 243.919919, 224.624401, 87529806, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT (SELECT COUNT(*) FROM Employees) - (SELECT COUNT(*) FROM Departments);

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(*) FROM Employees;

/*
Prediction Result:
(7,)
*/