-- Schema DDL
CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, salary REAL, bonus REAL, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id));

CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, budget REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests exact boundary condition (100000), just above (100000.01), and just below (99999.99)
INSERT INTO Departments (department_id, department_name, budget) VALUES (1, 'Engineering', 500000.0);
INSERT INTO Employees (employee_id, first_name, last_name, salary, bonus, department_id) VALUES (1, 'Alice', 'Smith', 80000.0, 20000.0, 1);
INSERT INTO Employees (employee_id, first_name, last_name, salary, bonus, department_id) VALUES (2, 'Bob', 'Jones', 80000.0, 20000.01, 1);
INSERT INTO Employees (employee_id, first_name, last_name, salary, bonus, department_id) VALUES (3, 'Charlie', 'Brown', 80000.0, 19999.99, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name FROM Employees WHERE salary + bonus > 100000;

/*
Gold Result:
('Bob',)
*/

-- Prediction Query
SELECT first_name FROM Employees WHERE salary - bonus > 100000;

/*
Prediction Result:
*/