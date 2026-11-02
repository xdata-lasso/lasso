-- Schema DDL
CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone_number TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Employees (employee_id, first_name, last_name, email, phone_number) VALUES (1, 'Alice', 'Smith', 'alice.smith@example.com', '555-0101');
INSERT INTO Employees (employee_id, first_name, last_name, email, phone_number) VALUES (2, 'Bob', 'Jones', 'bob.jones@example.com', '555-0102');
INSERT INTO Employees (employee_id, first_name, last_name, email, phone_number) VALUES (3, 'Charlie', 'Brown', 'alice.smith@example.com', '555-0103');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email FROM Employees;

/*
Gold Result:
('alice.smith@example.com',)
('bob.jones@example.com',)
('alice.smith@example.com',)
*/

-- Prediction Query
SELECT phone_number FROM Employees;

/*
Prediction Result:
('555-0101',)
('555-0102',)
('555-0103',)
*/