-- Schema DDL
CREATE TABLE employees (id INTEGER PRIMARY KEY, name TEXT, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES departments (id));

CREATE TABLE departments (id INTEGER PRIMARY KEY, name TEXT, manager_id INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO departments (id, name, manager_id) VALUES (1, 'default2', 1), (0, NULL, 1), (2, NULL, 0);
INSERT INTO employees (id, department_id, name) VALUES (0, 1, NULL), (1, 0, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.name, d.name FROM employees AS e JOIN departments AS d ON e.department_id = d.id;

/*
Gold Result:
(None, 'default2')
('default2', None)
*/

-- Prediction Query
SELECT e.name, d.name FROM employees AS e JOIN departments AS d ON e.department_id = e.department_id;

/*
Prediction Result:
(None, None)
(None, 'default2')
(None, None)
('default2', None)
('default2', 'default2')
('default2', None)
*/