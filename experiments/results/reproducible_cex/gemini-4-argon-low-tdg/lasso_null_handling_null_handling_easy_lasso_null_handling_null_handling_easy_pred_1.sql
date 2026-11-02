-- Schema DDL
CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, department TEXT, salary REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Employees (employee_id, first_name, last_name, email, department, salary) VALUES (1, 'Alice', 'Smith', 'alice@company.com', 'Engineering', 50000.0);
INSERT INTO Employees (employee_id, first_name, last_name, email, department, salary) VALUES (2, 'Bob', 'Jones', 'bob@company.com', 'Sales', 49999.99);
INSERT INTO Employees (employee_id, first_name, last_name, email, department, salary) VALUES (3, 'Charlie', 'Brown', 'charlie@company.com', 'HR', 50000.01);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name, last_name FROM Employees WHERE NOT email IS NULL AND salary >= 50000;

/*
Gold Result:
('Alice', 'Smith')
('Charlie', 'Brown')
*/

-- Prediction Query
SELECT first_name, last_name FROM Employees WHERE email IS NULL AND salary >= 50000;

/*
Prediction Result:
*/