-- Schema DDL
CREATE TABLE employees (id INTEGER PRIMARY KEY, name TEXT, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES departments (id));

CREATE TABLE departments (id INTEGER PRIMARY KEY, name TEXT, manager_id INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "departments" ("id", "name", "manager_id") VALUES (1004, 'Angie Henderson', 1005);
INSERT INTO "departments" ("id", "name", "manager_id") VALUES (1008, 'Angie Henderson', 1005);
INSERT INTO "employees" ("id", "name", "department_id") VALUES (1006, 'Daniel Wagner', 1004);
INSERT INTO "employees" ("id", "name", "department_id") VALUES (1007, 'Daniel Wagner', 1008);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.name, d.name FROM employees AS e JOIN departments AS d ON e.department_id = d.id;

/*
Gold Result:
('Daniel Wagner', 'Angie Henderson')
('Daniel Wagner', 'Angie Henderson')
*/

-- Prediction Query
SELECT e.name, d.name FROM employees AS e JOIN departments AS d ON e.department_id = e.department_id;

/*
Prediction Result:
('Daniel Wagner', 'Angie Henderson')
('Daniel Wagner', 'Angie Henderson')
('Daniel Wagner', 'Angie Henderson')
('Daniel Wagner', 'Angie Henderson')
*/