-- Schema DDL
CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, salary REAL, bonus REAL, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id));

CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, budget REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: departments --
INSERT INTO "departments" ("department_id", "department_name", "budget") VALUES (-2147483648, '5k5swwqcgs', 171.746906);

-- Inserting into table: employees --
INSERT INTO "employees" ("employee_id", "first_name", "last_name", "salary", "bonus", "department_id") VALUES (-2147483648, 'emp_33f670', 'n8c4pgu7v', 0.0, 111293.0, -2147483648);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "salary", "bonus", "department_id") VALUES (2, 'emp_33f670', '4h', 0.0, 111293.0, -2147483648);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "salary", "bonus", "department_id") VALUES (3, 'emp_33f670', 'a2y', 0.0, 111293.0, -2147483648);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "salary", "bonus", "department_id") VALUES (-2147483645, 'emp_33f670', 'uzhsrwbbp6lu', 0.0, 0.0, -2147483648);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "salary", "bonus", "department_id") VALUES (-2147483644, NULL, 'dlttil', 0.0, 111293.0, -2147483648);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name FROM Employees WHERE salary + bonus > 100000;

/*
Gold Result:
('emp_33f670',)
(None,)
('emp_33f670',)
('emp_33f670',)
*/

-- Prediction Query
SELECT first_name FROM Employees WHERE salary - bonus > 100000;

/*
Prediction Result:
*/