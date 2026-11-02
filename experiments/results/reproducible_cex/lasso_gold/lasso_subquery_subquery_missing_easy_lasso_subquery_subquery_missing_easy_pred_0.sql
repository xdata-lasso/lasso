-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (1001, 'Allison Hill', 1004, '89083 Robinson Radial
Lisatown, WV 21427');
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (1002, 'Noah Rhodes', 1011.0, '2351 Noah Knolls Suite 940
Herrerafurt, CO 72858');
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location") VALUES (1003, 'Angie Henderson', 1018.0, '310 Kendra Common Apt. 164
Reidstad, GA 49021');
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('Marine scientist', 'Building surveyor', 1007.5, 1010.5);
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('Engineer, manufacturing systems', 'Transport planner', 1014.5, 1019.5);
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('Geologist, engineering', 'Dramatherapist', 1021.5, 1028.5);
INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (1013, 'Amanda', 'Nelson', 'gabriellecameron@example.org', '+1-876-772-4238x8496', '1970-01-01', 'Marine scientist', 1031.5, 1019.5, 1022, 1001);
INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (1014, 'John', 'Schaefer', 'lydiatrujillo@example.com', '828.371.0122', '1970-01-02', 'Marine scientist', 1033.5, 1038.5, 1043.0, 1001);
INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone", "hire_date", "job_id", "salary", "commission_pct", "manager_id", "department_id") VALUES (1015, 'Steven', 'Watts', 'carl95@example.org', '(669)878-4801x8451', '1970-01-03', 'Marine scientist', 1035.5, 1057.5, 1064.0, 1001);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name FROM Employees WHERE salary > (SELECT AVG(salary) FROM Employees);

/*
Gold Result:
('Steven',)
*/

-- Prediction Query
SELECT first_name FROM Employees WHERE salary > 1000;

/*
Prediction Result:
('Amanda',)
('John',)
('Steven',)
*/