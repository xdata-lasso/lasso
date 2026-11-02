-- Schema DDL
CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone_number TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employees (employee_id, first_name, last_name, email, phone_number) VALUES (1, 'default1', 'default2', NULL, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email FROM Employees;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT last_name FROM Employees;

/*
Prediction Result:
('default2',)
*/