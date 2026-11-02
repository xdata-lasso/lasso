-- Schema DDL
CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, department TEXT, salary REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employees (employee_id, first_name, last_name, email, department, salary) VALUES (1, NULL, 'default1', 'default1', 'default2', 0.0), (50000, NULL, 'default2', 'default1', 'default1', 50001.0), (50001, 'default2', 'default2', 'default2', 'default1', 0.0), (49999, NULL, NULL, 'default2', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name, last_name FROM Employees WHERE NOT email IS NULL AND salary >= 50000;

/*
Gold Result:
(None, 'default2')
*/

-- Prediction Query
SELECT first_name, last_name FROM Employees WHERE email IS NULL AND salary >= 50000;

/*
Prediction Result:
*/