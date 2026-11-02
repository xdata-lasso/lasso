-- Schema DDL
CREATE TABLE employee (id INTEGER PRIMARY KEY, name TEXT NOT NULL, bonus INTEGER CHECK (bonus > 100));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: employee --
INSERT INTO "employee" ("id", "name", "bonus") VALUES (-2147483648, 'emp_477ff4', NULL);

INSERT INTO "employee" ("id", "name", "bonus") VALUES (2, 'emp_477ff4', NULL);

INSERT INTO "employee" ("id", "name", "bonus") VALUES (3, 'emp_477ff4', NULL);

INSERT INTO "employee" ("id", "name", "bonus") VALUES (-2147483645, 'emp_477ff4', 101);

INSERT INTO "employee" ("id", "name", "bonus") VALUES (-2147483644, 'emp_477ff4', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM employee WHERE bonus IS NULL;

/*
Gold Result:
('emp_477ff4',)
('emp_477ff4',)
('emp_477ff4',)
('emp_477ff4',)
*/

-- Prediction Query
SELECT bonus FROM employee WHERE bonus IS NULL;

/*
Prediction Result:
(None,)
(None,)
(None,)
(None,)
*/