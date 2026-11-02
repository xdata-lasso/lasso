-- Schema DDL
CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, department TEXT, salary REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employees (employee_id, first_name, last_name, email, department, salary) VALUES (0, 'default1', 'default1', NULL, 'default2', 50000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name, last_name FROM Employees WHERE NOT email IS NULL AND salary >= 50000;

/*
Gold Result:
*/

-- Prediction Query
SELECT first_name, last_name FROM Employees WHERE salary >= 50000;

/*
Prediction Result:
('default1', 'default1')
*/