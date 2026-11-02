-- Schema DDL
CREATE TABLE employee (id INTEGER PRIMARY KEY, name TEXT, department_id TEXT, salary REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "employee" ("id", "name", "department_id", "salary") VALUES (6, 'D1017', 'D101', NULL);
INSERT INTO "employee" ("id", "name", "department_id", "salary") VALUES (5, NULL, 'D101', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, SUM(salary) FROM employee WHERE department_id = 'D101';

/*
Gold Result:
(None, None)
*/

-- Prediction Query
SELECT name, SUM(salary) FROM employee WHERE department_id = 'D101' GROUP BY name;

/*
Prediction Result:
(None, None)
('D1017', None)
*/