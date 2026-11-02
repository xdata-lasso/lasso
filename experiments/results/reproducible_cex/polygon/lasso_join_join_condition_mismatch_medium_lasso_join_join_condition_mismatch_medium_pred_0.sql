-- Schema DDL
CREATE TABLE employees (id INTEGER PRIMARY KEY, name TEXT, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES departments (id));

CREATE TABLE departments (id INTEGER PRIMARY KEY, name TEXT, manager_id INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "employees" ("id", "department_id", "name") VALUES (10, 11, '18');
INSERT INTO "employees" ("id", "department_id", "name") VALUES (21, NULL, '22');
INSERT INTO "departments" ("id", "name", "manager_id") VALUES (11, '19', 20);
INSERT INTO "departments" ("id", "name", "manager_id") VALUES (12, '23', 21);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.name, d.name FROM employees AS e JOIN departments AS d ON e.department_id = d.id;

/*
Gold Result:
('18', '19')
*/

-- Prediction Query
SELECT e.name, d.name FROM employees AS e JOIN departments AS d ON e.id = d.manager_id;

/*
Prediction Result:
('22', '23')
*/