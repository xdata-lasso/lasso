-- Schema DDL
CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone_number TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Employees (employee_id, first_name, last_name, email, phone_number) VALUES (1, 'Alice', 'Smith', 'Alice.Smith@Example.COM', '555-0101');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email FROM Employees;

/*
Gold Result:
('Alice.Smith@Example.COM',)
*/

-- Prediction Query
SELECT last_name FROM Employees;

/*
Prediction Result:
('Smith',)
*/