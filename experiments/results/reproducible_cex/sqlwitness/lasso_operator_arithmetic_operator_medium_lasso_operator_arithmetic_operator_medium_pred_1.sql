-- Schema DDL
CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, salary REAL, bonus REAL, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id));

CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, budget REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO departments (department_id, department_name, budget) VALUES (99999, 'default1', NULL), (0, NULL, 100001.0), (100000, 'default1', 1.0), (100001, NULL, 1.0), (1, NULL, 100000.0);
INSERT INTO employees (employee_id, department_id, first_name, last_name, salary, bonus) VALUES (100001, 99999, 'default1', 'default1', 0.0, 100001.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name FROM Employees WHERE salary + bonus > 100000;

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT first_name FROM Employees WHERE salary * bonus > 100000;

/*
Prediction Result:
*/