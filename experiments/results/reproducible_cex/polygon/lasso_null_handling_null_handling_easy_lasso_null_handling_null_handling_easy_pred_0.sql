-- Schema DDL
CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, department TEXT, salary REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Employees" ("employee_id", "first_name", "last_name", "email", "department", "salary") VALUES (7, NULL, NULL, '8', '9', 50000);
INSERT INTO "Employees" ("employee_id", "first_name", "last_name", "email", "department", "salary") VALUES (6, NULL, NULL, NULL, '11', 50000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name, last_name FROM Employees WHERE NOT email IS NULL AND salary >= 50000;

/*
Gold Result:
(None, None)
*/

-- Prediction Query
SELECT first_name, last_name FROM Employees WHERE salary >= 50000;

/*
Prediction Result:
(None, None)
(None, None)
*/