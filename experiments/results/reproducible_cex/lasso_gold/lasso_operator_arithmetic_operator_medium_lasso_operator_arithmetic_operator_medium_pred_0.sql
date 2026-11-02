-- Schema DDL
CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, salary REAL, bonus REAL, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id));

CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, budget REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "departments" ("department_id", "department_name", "budget") VALUES (1004, 'Stephanie Miller', 1005.5);
INSERT INTO "employees" ("employee_id", "first_name", "last_name", "salary", "bonus", "department_id") VALUES (1006, 'Robert', 'Johnson', 99999.0, 2.0, 1004);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name FROM Employees WHERE salary + bonus > 100000;

/*
Gold Result:
('Robert',)
*/

-- Prediction Query
SELECT first_name FROM Employees WHERE salary - bonus > 100000;

/*
Prediction Result:
*/