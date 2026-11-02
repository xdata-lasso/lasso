-- Schema DDL
CREATE TABLE employee (id INTEGER PRIMARY KEY, name TEXT, department_id TEXT, salary REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: employee --
INSERT INTO "employee" ("id", "name", "department_id", "salary") VALUES (-2147483648, 'emp_a163a6', 'D101', 582.588439);

INSERT INTO "employee" ("id", "name", "department_id", "salary") VALUES (2, 'emp_a163a6', 'D101', 680.190136);

INSERT INTO "employee" ("id", "name", "department_id", "salary") VALUES (3, 'emp_a163a6', 'D101', 487.053947);

INSERT INTO "employee" ("id", "name", "department_id", "salary") VALUES (-2147483645, 'emp_a163a6', 'emp_5b60fa', NULL);

INSERT INTO "employee" ("id", "name", "department_id", "salary") VALUES (-2147483644, 'emp_73dab0', 'emp_e8dfd3', NULL);

INSERT INTO "employee" ("id", "name", "department_id", "salary") VALUES (-2147483643, 'emp_a163a6', 'D101', NULL);

INSERT INTO "employee" ("id", "name", "department_id", "salary") VALUES (-2147483642, 'emp_73dab0', 'D101', NULL);

INSERT INTO "employee" ("id", "name", "department_id", "salary") VALUES (-2147483641, NULL, 'D101', NULL);

INSERT INTO "employee" ("id", "name", "department_id", "salary") VALUES (-2147483640, NULL, 'D101', NULL);

INSERT INTO "employee" ("id", "name", "department_id", "salary") VALUES (-2147483639, 'emp_a163a6', 'D101', NULL);

INSERT INTO "employee" ("id", "name", "department_id", "salary") VALUES (-2147483638, 'emp_73dab0', 'D101', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, SUM(salary) FROM employee WHERE department_id = 'D101';

/*
Gold Result:
('emp_a163a6', 1749.8325220000002)
*/

-- Prediction Query
SELECT name, SUM(salary) FROM employee WHERE department_id = 'D101' GROUP BY name;

/*
Prediction Result:
(None, None)
('emp_73dab0', None)
('emp_a163a6', 1749.8325220000002)
*/