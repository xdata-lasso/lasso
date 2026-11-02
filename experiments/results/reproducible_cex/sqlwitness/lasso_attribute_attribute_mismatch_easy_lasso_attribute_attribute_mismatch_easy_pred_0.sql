-- Schema DDL
CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone_number TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employees (employee_id, first_name, last_name, email, phone_number) VALUES (1, 'default2', 'default2', 'default1', 'default1'), (0, NULL, 'default2', 'default2', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email FROM Employees;

/*
Gold Result:
('default2',)
('default1',)
*/

-- Prediction Query
SELECT phone_number FROM Employees;

/*
Prediction Result:
(None,)
('default1',)
*/