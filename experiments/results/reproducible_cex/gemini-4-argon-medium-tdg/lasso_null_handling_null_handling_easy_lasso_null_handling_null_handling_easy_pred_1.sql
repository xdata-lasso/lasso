-- Schema DDL
CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, department TEXT, salary REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Employees (employee_id, first_name, last_name, email, department, salary) VALUES (1, 'David', 'Wilson', NULL, 'HR', 60000.0);
INSERT INTO Employees (employee_id, first_name, last_name, email, department, salary) VALUES (2, 'Eva', 'Davis', 'eva@company.com', 'Finance', 60000.0);
INSERT INTO Employees (employee_id, first_name, last_name, email, department, salary) VALUES (3, 'Frank', 'Miller', NULL, 'IT', 40000.0);
INSERT INTO Employees (employee_id, first_name, last_name, email, department, salary) VALUES (4, 'Grace', 'Taylor', 'grace@company.com', 'IT', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name, last_name FROM Employees WHERE NOT email IS NULL AND salary >= 50000;

/*
Gold Result:
('Eva', 'Davis')
*/

-- Prediction Query
SELECT first_name, last_name FROM Employees WHERE email IS NULL AND salary >= 50000;

/*
Prediction Result:
('David', 'Wilson')
*/