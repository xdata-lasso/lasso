-- Schema DDL
CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, department TEXT, salary REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "department", "salary") VALUES (1010, 'Kendra', 'Galloway', 'michellejames@example.com', 'prove', 50000.0);
INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "department", "salary") VALUES (1012, 'Amanda', 'Sanchez', NULL, 'maintain', 50000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name, last_name FROM Employees WHERE NOT email IS NULL AND salary >= 50000;

/*
Gold Result:
('Kendra', 'Galloway')
*/

-- Prediction Query
SELECT first_name, last_name FROM Employees WHERE salary >= 50000;

/*
Prediction Result:
('Kendra', 'Galloway')
('Amanda', 'Sanchez')
*/