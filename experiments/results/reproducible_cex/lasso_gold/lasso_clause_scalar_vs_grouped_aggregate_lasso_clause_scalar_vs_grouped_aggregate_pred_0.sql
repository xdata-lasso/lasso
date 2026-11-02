-- Schema DDL
CREATE TABLE employee (id INTEGER PRIMARY KEY, name TEXT, department_id TEXT, salary REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "employee" ("id", "name", "department_id", "salary") VALUES (1009, 'Daniel Wagner', 'D101', 1010.5);
INSERT INTO "employee" ("id", "name", "department_id", "salary") VALUES (1011, 'Cristian Santos', 'D101', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, SUM(salary) FROM employee WHERE department_id = 'D101';

/*
Gold Result:
('Daniel Wagner', 1010.5)
*/

-- Prediction Query
SELECT name, SUM(salary) FROM employee WHERE department_id = 'D101' GROUP BY name;

/*
Prediction Result:
('Cristian Santos', None)
('Daniel Wagner', 1010.5)
*/