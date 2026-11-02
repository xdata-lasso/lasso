-- Schema DDL
CREATE TABLE employees (id INTEGER PRIMARY KEY, email TEXT UNIQUE, name TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: employees --
INSERT INTO "employees" ("id", "email", "name") VALUES (2, 'A', 'emp_2be905');

INSERT INTO "employees" ("id", "email", "name") VALUES (3, 'C', 'emp_2be905');

INSERT INTO "employees" ("id", "email", "name") VALUES (4, 'email_3', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name FROM employees;

/*
Gold Result:
('emp_2be905',)
(None,)
*/

-- Prediction Query
SELECT name FROM employees;

/*
Prediction Result:
('emp_2be905',)
('emp_2be905',)
(None,)
*/