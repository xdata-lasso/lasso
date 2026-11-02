-- Schema DDL
CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone_number TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Employees" ("employee_id", "first_name", "last_name", "email", "phone_number") VALUES (5, '5', '5', '5', '7');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email FROM Employees;

/*
Gold Result:
('5',)
*/

-- Prediction Query
SELECT phone_number FROM Employees;

/*
Prediction Result:
('7',)
*/