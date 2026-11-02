-- Schema DDL
CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone_number TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employees (employee_id, first_name, last_name, email, phone_number) VALUES (1, NULL, 'default2', 'default2', 'default2'), (0, NULL, 'default2', 'default2', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email FROM Employees;

/*
Gold Result:
('default2',)
('default2',)
*/

-- Prediction Query
SELECT employee_id FROM Employees;

/*
Prediction Result:
(0,)
(1,)
*/