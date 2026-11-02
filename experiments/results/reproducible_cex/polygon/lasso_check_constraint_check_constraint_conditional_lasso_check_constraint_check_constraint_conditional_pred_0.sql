-- Schema DDL
CREATE TABLE Projects (id INTEGER PRIMARY KEY, status TEXT(20), closed_date DATE, CHECK (status <> 'Closed' OR NOT closed_date IS NULL));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Projects" ("id", "status", "closed_date") VALUES (5, 'Closed', '1000-01-07');
INSERT INTO "Projects" ("id", "status", "closed_date") VALUES (4, 'Closed7', '1000-01-06');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id FROM Projects WHERE status = 'Closed';

/*
Gold Result:
(5,)
*/

-- Prediction Query
SELECT id FROM Projects;

/*
Prediction Result:
(4,)
(5,)
*/