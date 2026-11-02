-- Schema DDL
CREATE TABLE employee (id INTEGER PRIMARY KEY, name TEXT NOT NULL, bonus INTEGER CHECK (bonus > 100));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (id, name, bonus) VALUES (1, 'Alice', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM employee WHERE bonus IS NULL;

/*
Gold Result:
('Alice',)
*/

-- Prediction Query
SELECT bonus FROM employee WHERE bonus IS NULL;

/*
Prediction Result:
(None,)
*/