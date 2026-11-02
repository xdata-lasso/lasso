-- Schema DDL
CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone_number TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employees (employee_id, first_name, last_name, email, phone_number) VALUES (1, 'default2', NULL, 'default1', 'default2'), (0, NULL, NULL, 'default1', NULL), (2, 'default1', NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email FROM Employees;

/*
Gold Result:
('default1',)
('default1',)
(None,)
*/

-- Prediction Query
SELECT first_name FROM Employees;

/*
Prediction Result:
(None,)
('default2',)
('default1',)
*/