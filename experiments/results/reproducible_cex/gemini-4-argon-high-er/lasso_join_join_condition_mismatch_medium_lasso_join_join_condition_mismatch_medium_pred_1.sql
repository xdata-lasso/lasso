-- Schema DDL
CREATE TABLE employees (id INTEGER PRIMARY KEY, name TEXT, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES departments (id));

CREATE TABLE departments (id INTEGER PRIMARY KEY, name TEXT, manager_id INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO departments (id, name, manager_id) VALUES (1, 'Sales', 1);
INSERT INTO departments (id, name, manager_id) VALUES (2, 'HR', 2);
INSERT INTO employees (id, name, department_id) VALUES (1, 'Alice', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.name, d.name FROM employees AS e JOIN departments AS d ON e.department_id = d.id;

/*
Gold Result:
('Alice', 'Sales')
*/

-- Prediction Query
SELECT e.name, d.name FROM employees AS e JOIN departments AS d ON e.department_id = e.department_id;

/*
Prediction Result:
('Alice', 'Sales')
('Alice', 'HR')
*/