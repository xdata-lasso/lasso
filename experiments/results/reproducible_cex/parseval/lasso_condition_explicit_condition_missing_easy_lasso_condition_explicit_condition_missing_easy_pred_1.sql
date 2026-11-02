-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: departments --
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (5, '5k5swwqcgs', 247012447, '8c4pgu7vfe');

INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (1, 'liqa1', 2074205376, 'yytoo');

-- Inserting into table: jobs --
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('job_id_1', 'hria2ypu', 882.963176, 841.297061);

-- Inserting into table: employees --
INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483648, 'emp_fdc889', 'rwbbp', 'luhvdltti', 'bnp', '2023-01-01', 'job_id_1', 50000.01, 986.066566, 907682809, 5);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (2, 'emp_fdc889', 'siie5unw6k', 'fa9', '00t5c4e', '2020-06-23', 'job_id_1', 50000.01, 128.76421, -1683203397, 5);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (3, 'emp_fdc889', '76nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2024-12-15', 'job_id_1', 50000.01, 825.231787, -1822992503, 5);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483645, 'emp_fdc889', '9hl7', 'klex14ji', '7zwau2dwyr', '2022-12-09', 'job_id_1', 50000.01, 433.533777, -1097120355, 1);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483644, 'emp_fdc889', '8d99rljsl', 'b4yp5qi', 'rkf9vqx5', '2022-08-22', 'job_id_1', 50000.0, 698.16972, -461695645, 5);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483643, NULL, '8jegd21vy9ux', 'j4hwbdvlph', 'gndqwnqc', '2024-02-11', 'job_id_1', 50000.01, 668.309685, 580968159, 5);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (4, '5sw', 'qcgsk9', '8c4p', 'u7', '2023-09-09', 'job_id_1', 50000.0, 86.520366, -1865039888, 1);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (5, 'ia2yp', 'uzhsrwbbp6lu', 'hvdlttilbnpr', 'dpos', '2021-06-28', 'job_id_1', NULL, 126.856521, -45536098, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name FROM Employees WHERE department_id = 5 AND salary > 50000;

/*
Gold Result:
('emp_fdc889',)
(None,)
('emp_fdc889',)
('emp_fdc889',)
*/

-- Prediction Query
SELECT first_name FROM Employees;

/*
Prediction Result:
('emp_fdc889',)
('emp_fdc889',)
('emp_fdc889',)
(None,)
('emp_fdc889',)
('emp_fdc889',)
('5sw',)
('ia2yp',)
*/