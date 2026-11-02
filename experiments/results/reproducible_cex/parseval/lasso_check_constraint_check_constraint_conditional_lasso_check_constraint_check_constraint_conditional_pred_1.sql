-- Schema DDL
CREATE TABLE Projects (id INTEGER PRIMARY KEY, status TEXT(20), closed_date DATE, CHECK (status <> 'Closed' OR NOT closed_date IS NULL));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: projects --
INSERT INTO "projects" ("id", "status", "closed_date") VALUES (1, 'Closed', '2025-06-17');

INSERT INTO "projects" ("id", "status", "closed_date") VALUES (2, 'pro_e9ad2c', '2025-06-17');

INSERT INTO "projects" ("id", "status", "closed_date") VALUES (3, NULL, '2021-11-08');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id FROM Projects WHERE status = 'Closed';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT id FROM Projects WHERE status = 'Open';

/*
Prediction Result:
*/