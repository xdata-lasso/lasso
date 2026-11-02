-- Schema DDL
CREATE TABLE Projects (id INTEGER PRIMARY KEY, status TEXT(20), closed_date DATE, CHECK (status <> 'Closed' OR NOT closed_date IS NULL));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "projects" ("id", "status", "closed_date") VALUES (1001, 'Closed', '1970-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id FROM Projects WHERE status = 'Closed';

/*
Gold Result:
(1001,)
*/

-- Prediction Query
SELECT id FROM Projects WHERE status = 'Open';

/*
Prediction Result:
*/