-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: departments --
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (1, '5k5swwqcgs', 247012447, '8c4pgu7vfe');

-- Inserting into table: jobs --
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('job_id_1', 'hria2ypu', 882.963176, 841.297061);

-- Inserting into table: employees --
INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483648, 'rwbbp', 'luhvdltti', 'bnp', 'mdpos', '2021-06-28', 'job_id_1', 126.856521, 489.397796, 1861536320, 1);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483647, 'klfa9000t', 'c4ecigce', '76nium52', 'zbuo4nrqrof', '2022-11-29', 'job_id_1', 389.878901, 488.977171, -921187550, 1);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483646, 'p', '02eutliqa11r', 'ytoo3o9', 'l7', '2024-12-21', 'job_id_1', 958.92567, 164.991544, -305670381, 1);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (2, '7zw', 'au2dwyrq13', 'yu78', '9', '2023-01-20', 'job_id_1', 182.777264, 943.791649, -904834265, 1);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (3, '4', 'p5qi2rk', '9v', 'x58pz', '2024-08-06', 'job_id_1', 694.765963, 707.476301, 176555546, 1);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483645, 'd2', 'vy9uxj4', 'wb', 'v', '2022-01-29', 'job_id_1', 989.653112, 705.754562, -1642259219, 1);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483642, 'q', 'nqcx5h', 'cprj', 'u0dz7', '2021-01-15', 'job_id_1', NULL, 154.065416, -1255130038, 1);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483641, 'dqv0gcb98ozk', 'zbilyrkn', '6vck6ah0f8js', 'wlq7xb', '2025-11-20', 'job_id_1', NULL, 949.322482, 602161869, 1);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483640, '7', 'yfdrz', '16nijjai5dh', 'ogrgjd8y', '2024-05-29', 'job_id_1', NULL, 308.482994, 1250290042, 1);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483639, 'grit', 'sj3ayxp1q430', 'jh3den8', 'c68x8vacx7', '2020-02-05', 'job_id_1', NULL, 983.924121, -47052816, 1);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483638, 'f77p', 'o72ctdc', 'mfg62', '0v', '2025-07-11', 'job_id_1', NULL, 935.437841, -1021978385, 1);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483637, 'e1io', '278507cv', 'jpttg', 'bnou5zi36', '2020-05-11', 'job_id_1', NULL, 900.959264, -2072838897, 1);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483636, 'oa', 'cd07z2zezjo7', 'wgxd5ysxcm', '0oztd', '2021-03-03', 'job_id_1', NULL, 145.027285, -20116244, 1);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483635, 'q5l', 'pim5', '58q', 's27p2r94gth2', '2022-03-04', 'job_id_1', NULL, 925.474843, 418247369, 1);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483634, 'la3', 'okv8uttmu2', 'e578', 'fvy', '2024-05-28', 'job_id_1', NULL, 823.908713, 448935289, 1);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483633, 'be8yvkv42q7', 'x58b4', 'pmaus3auvmkr', 'pdjwzw5chn9', '2022-02-22', 'job_id_1', NULL, 691.814216, -354292049, 1);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483632, '9n0jxfofwsz', 'o', '2zobb0q0k32o', 'w', '2020-06-05', 'job_id_1', NULL, 979.99406, 895277769, 1);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483631, 'msorlwyngc', 'dj9erhi', 'zgk1yoeyo6l0', 'dt', '2025-09-04', 'job_id_1', NULL, 834.163912, 1617348603, 1);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (4, 'xuzkb52', 'gwnlas6', 'elboeowii1', '5nxih66', '2024-12-13', 'job_id_1', 2.0, 259.245161, 1244279905, 1);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (5, 'otow9oa', 'awg96aqb0tbi', 'ndz39tajz9', 'd8n5w', '2020-05-31', 'job_id_1', 3.0, 105.460765, -1275298282, 1);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (6, 'tdu6bd0w96', '3vzxw1r', 'e9yfk7', 'k162n', '2021-04-03', 'job_id_1', 1.0, 722.776931, 774922170, 1);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (7, 'o', 'vu', '6dza35r', 'mkio18ri2hy', '2024-09-04', 'job_id_1', 1.0, 949.964729, 168442149, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT department_id, AVG(salary) FROM Employees GROUP BY department_id HAVING AVG(salary) > 50000;

/*
Gold Result:
*/

-- Prediction Query
SELECT department_id, AVG(salary) FROM Employees GROUP BY department_id;

/*
Prediction Result:
(1, 334.9857430999999)
*/