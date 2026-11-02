-- Schema DDL
CREATE TABLE employee (id INTEGER PRIMARY KEY, name TEXT NOT NULL, bonus INTEGER CHECK (bonus > 100));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO employee (id, name, bonus) VALUES (1, 'Alice', NULL);
INSERT INTO employee (id, name, bonus) VALUES (2, 'Bob', 101);
INSERT INTO employee (id, name, bonus) VALUES (3, 'Charlie', 500);
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