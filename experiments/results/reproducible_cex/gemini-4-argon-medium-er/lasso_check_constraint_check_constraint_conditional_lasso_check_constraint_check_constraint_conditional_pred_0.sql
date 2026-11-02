-- Schema DDL
CREATE TABLE Projects (id INTEGER PRIMARY KEY, status TEXT(20), closed_date DATE, CHECK (status <> 'Closed' OR NOT closed_date IS NULL));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Projects (id, status, closed_date) VALUES (1, 'Open', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id FROM Projects WHERE status = 'Closed';

/*
Gold Result:
*/

-- Prediction Query
SELECT id FROM Projects;

/*
Prediction Result:
(1,)
*/