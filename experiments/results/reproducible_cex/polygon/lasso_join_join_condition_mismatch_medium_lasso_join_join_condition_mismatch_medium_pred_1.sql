-- Schema DDL
CREATE TABLE employees (id INTEGER PRIMARY KEY, name TEXT, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES departments (id));

CREATE TABLE departments (id INTEGER PRIMARY KEY, name TEXT, manager_id INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "employees" ("id", "department_id", "name") VALUES (11, 13, NULL);
INSERT INTO "employees" ("id", "department_id", "name") VALUES (10, 12, NULL);
INSERT INTO "departments" ("id", "name", "manager_id") VALUES (12, '21', 18);
INSERT INTO "departments" ("id", "name", "manager_id") VALUES (13, '23', 19);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.name, d.name FROM employees AS e JOIN departments AS d ON e.department_id = d.id;

/*
Gold Result:
(None, '21')
(None, '23')
*/

-- Prediction Query
SELECT e.name, d.name FROM employees AS e JOIN departments AS d ON e.department_id = e.department_id;

/*
Prediction Result:
(None, '21')
(None, '23')
(None, '21')
(None, '23')
*/