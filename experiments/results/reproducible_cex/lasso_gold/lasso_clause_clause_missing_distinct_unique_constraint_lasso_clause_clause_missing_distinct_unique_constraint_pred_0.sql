-- Schema DDL
CREATE TABLE employees (id INTEGER PRIMARY KEY, email TEXT UNIQUE, name TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "employees" ("id", "email", "name") VALUES (1002, 'garzaanthony@example.org', 'Jonathan Johnson');
INSERT INTO "employees" ("id", "email", "name") VALUES (1003, 'jennifermiles@example.com', 'Jonathan Johnson');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name FROM employees;

/*
Gold Result:
('Jonathan Johnson',)
*/

-- Prediction Query
SELECT name FROM employees;

/*
Prediction Result:
('Jonathan Johnson',)
('Jonathan Johnson',)
*/