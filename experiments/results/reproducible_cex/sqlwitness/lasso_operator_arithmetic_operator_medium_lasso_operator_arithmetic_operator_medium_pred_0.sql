-- Schema DDL
CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, salary REAL, bonus REAL, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id));

CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, budget REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employees (employee_id, department_id, first_name, last_name, salary, bonus) VALUES (99999, NULL, NULL, 'default1', NULL, 1.0), (100000, NULL, NULL, 'default1', 100000.0, 1.0), (1, NULL, 'default1', 'default2', NULL, 100001.0), (100001, NULL, 'default1', 'default2', 99999.0, 99999.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name FROM Employees WHERE salary + bonus > 100000;

/*
Gold Result:
(None,)
('default1',)
*/

-- Prediction Query
SELECT first_name FROM Employees WHERE salary - bonus > 100000;

/*
Prediction Result:
*/