-- Schema DDL
CREATE TABLE employees (id INTEGER PRIMARY KEY, name TEXT, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES departments (id));

CREATE TABLE departments (id INTEGER PRIMARY KEY, name TEXT, manager_id INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: departments --
INSERT INTO "departments" ("id", "name", "manager_id") VALUES (1, 'd_s_706fd8', -55602865);

INSERT INTO "departments" ("id", "name", "manager_id") VALUES (-2147483647, 'd_s_706fd8', -59984348);

INSERT INTO "departments" ("id", "name", "manager_id") VALUES (3, 'wqcgsk', 1610062532);

INSERT INTO "departments" ("id", "name", "manager_id") VALUES (2, 'd_s_706fd8', -106629402);

INSERT INTO "departments" ("id", "name", "manager_id") VALUES (4, 'u7', -734455130);

-- Inserting into table: employees --
INSERT INTO "employees" ("id", "name", "department_id") VALUES (-2147483648, 'e_s_2558b3', 1);

INSERT INTO "employees" ("id", "name", "department_id") VALUES (2, 'e_s_2558b3', 1);

INSERT INTO "employees" ("id", "name", "department_id") VALUES (3, 'e_s_2558b3', 3);

INSERT INTO "employees" ("id", "name", "department_id") VALUES (-2147483645, 'e_s_2558b3', 4);

INSERT INTO "employees" ("id", "name", "department_id") VALUES (-2147483644, 'e_s_2558b3', 4);

INSERT INTO "employees" ("id", "name", "department_id") VALUES (-2147483643, 'e_s_2558b3', 1);

INSERT INTO "employees" ("id", "name", "department_id") VALUES (-2147483642, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.name, d.name FROM employees AS e JOIN departments AS d ON e.department_id = d.id;

/*
Gold Result:
('e_s_2558b3', 'd_s_706fd8')
('e_s_2558b3', 'u7')
('e_s_2558b3', 'u7')
('e_s_2558b3', 'd_s_706fd8')
(None, 'd_s_706fd8')
('e_s_2558b3', 'd_s_706fd8')
('e_s_2558b3', 'wqcgsk')
*/

-- Prediction Query
SELECT e.name, d.name FROM employees AS e JOIN departments AS d ON e.id = d.manager_id;

/*
Prediction Result:
*/