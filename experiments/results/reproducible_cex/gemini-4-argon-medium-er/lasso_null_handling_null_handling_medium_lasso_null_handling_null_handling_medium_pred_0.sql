-- Schema DDL
CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, department_id INTEGER);

CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, manager_id INTEGER, FOREIGN KEY (manager_id) REFERENCES Employees (employee_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Employees (employee_id, first_name, department_id) VALUES (1, 'Alice', 1);
INSERT INTO Departments (department_id, manager_id) VALUES (1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name FROM Employees WHERE NOT employee_id IN (SELECT manager_id FROM Departments WHERE NOT manager_id IS NULL);

/*
Gold Result:
('Alice',)
*/

-- Prediction Query
SELECT first_name FROM Employees WHERE NOT employee_id IN (SELECT manager_id FROM Departments);

/*
Prediction Result:
*/