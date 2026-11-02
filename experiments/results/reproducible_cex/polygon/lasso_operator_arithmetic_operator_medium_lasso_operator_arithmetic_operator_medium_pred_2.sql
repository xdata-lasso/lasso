-- Schema DDL
CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, salary REAL, bonus REAL, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id));

CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, budget REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Employees" ("employee_id", "department_id", "first_name", "last_name", "salary", "bonus") VALUES (7, 8, '21', NULL, 100001, 0);
INSERT INTO "Employees" ("employee_id", "department_id", "first_name", "last_name", "salary", "bonus") VALUES (6, 8, '21', '11', 100001, 1);
INSERT INTO "Departments" ("department_id", "department_name", "budget") VALUES (9, '21', 21);
INSERT INTO "Departments" ("department_id", "department_name", "budget") VALUES (8, '21', 21);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name FROM Employees WHERE salary + bonus > 100000;

/*
Gold Result:
('21',)
('21',)
*/

-- Prediction Query
SELECT first_name FROM Employees WHERE salary / bonus > 100000;

/*
Prediction Result:
('21',)
*/