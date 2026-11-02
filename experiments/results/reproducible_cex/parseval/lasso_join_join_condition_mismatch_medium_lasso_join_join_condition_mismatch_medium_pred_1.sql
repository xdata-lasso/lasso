-- Schema DDL
CREATE TABLE employees (id INTEGER PRIMARY KEY, name TEXT, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES departments (id));

CREATE TABLE departments (id INTEGER PRIMARY KEY, name TEXT, manager_id INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: departments --
INSERT INTO "departments" ("id", "name", "manager_id") VALUES (1, 'd_s_971bea', -55602865);

INSERT INTO "departments" ("id", "name", "manager_id") VALUES (-2147483647, 'd_s_971bea', -59984348);

INSERT INTO "departments" ("id", "name", "manager_id") VALUES (2, 'd_s_971bea', -664303813);

INSERT INTO "departments" ("id", "name", "manager_id") VALUES (4, 'cgsk9', 1610062532);

-- Inserting into table: employees --
INSERT INTO "employees" ("id", "name", "department_id") VALUES (-2147483648, 'e_s_04ac81', 1);

INSERT INTO "employees" ("id", "name", "department_id") VALUES (2, 'e_s_04ac81', 1);

INSERT INTO "employees" ("id", "name", "department_id") VALUES (3, 'e_s_04ac81', 1);

INSERT INTO "employees" ("id", "name", "department_id") VALUES (-2147483645, 'e_s_04ac81', 4);

INSERT INTO "employees" ("id", "name", "department_id") VALUES (-2147483644, 'e_s_04ac81', 4);

INSERT INTO "employees" ("id", "name", "department_id") VALUES (-2147483643, 'e_s_04ac81', 1);

INSERT INTO "employees" ("id", "name", "department_id") VALUES (-2147483642, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.name, d.name FROM employees AS e JOIN departments AS d ON e.department_id = d.id;

/*
Gold Result:
('e_s_04ac81', 'd_s_971bea')
('e_s_04ac81', 'cgsk9')
('e_s_04ac81', 'cgsk9')
('e_s_04ac81', 'd_s_971bea')
(None, 'd_s_971bea')
('e_s_04ac81', 'd_s_971bea')
('e_s_04ac81', 'd_s_971bea')
*/

-- Prediction Query
SELECT e.name, d.name FROM employees AS e JOIN departments AS d ON e.department_id = e.department_id;

/*
Prediction Result:
('e_s_04ac81', 'd_s_971bea')
('e_s_04ac81', 'd_s_971bea')
('e_s_04ac81', 'd_s_971bea')
('e_s_04ac81', 'cgsk9')
('e_s_04ac81', 'd_s_971bea')
('e_s_04ac81', 'd_s_971bea')
('e_s_04ac81', 'd_s_971bea')
('e_s_04ac81', 'cgsk9')
('e_s_04ac81', 'd_s_971bea')
('e_s_04ac81', 'd_s_971bea')
('e_s_04ac81', 'd_s_971bea')
('e_s_04ac81', 'cgsk9')
('e_s_04ac81', 'd_s_971bea')
('e_s_04ac81', 'd_s_971bea')
('e_s_04ac81', 'd_s_971bea')
('e_s_04ac81', 'cgsk9')
(None, 'd_s_971bea')
(None, 'd_s_971bea')
(None, 'd_s_971bea')
(None, 'cgsk9')
('e_s_04ac81', 'd_s_971bea')
('e_s_04ac81', 'd_s_971bea')
('e_s_04ac81', 'd_s_971bea')
('e_s_04ac81', 'cgsk9')
('e_s_04ac81', 'd_s_971bea')
('e_s_04ac81', 'd_s_971bea')
('e_s_04ac81', 'd_s_971bea')
('e_s_04ac81', 'cgsk9')
*/