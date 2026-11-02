-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: departments --
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (10, '5k5swwqcgs', 247012447, '8c4pgu7vfe');

INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (1, 'qa1', 2074205376, 'yytoo');

-- Inserting into table: jobs --
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('job_id_1', 'hria2ypu', 882.963176, 841.297061);

-- Inserting into table: employees --
INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483648, 'emp_bb7d57', 'rwbbp', 'luhvdltti', 'bnp', '2023-01-01', 'job_id_1', 986.066566, 666.330692, 907682809, 10);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (2, 'emp_bb7d57', 'siie5unw6k', 'fa9', '00t5c4e', '2020-06-23', 'job_id_1', 128.76421, 610.208018, -1683203397, 10);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (3, 'emp_bb7d57', '76nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2024-12-15', 'job_id_1', 825.231787, 75.551482, -868774469, 10);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483645, 'emp_bb7d57', '9hl7', 'klex14ji', '7zwau2dwyr', '2022-12-09', 'job_id_1', 433.533777, 458.991081, -1097120355, 1);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (-2147483644, NULL, '8d99rljsl', 'b4yp5qi', 'rkf9vqx5', '2022-08-22', 'job_id_1', 698.16972, 690.435103, -461695645, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name FROM Employees WHERE department_id = 10;

/*
Gold Result:
('emp_bb7d57',)
(None,)
('emp_bb7d57',)
('emp_bb7d57',)
*/

-- Prediction Query
SELECT * FROM Departments;

/*
Prediction Result:
(1, 'qa1', 2074205376, 'yytoo')
(10, '5k5swwqcgs', 247012447, '8c4pgu7vfe')
*/