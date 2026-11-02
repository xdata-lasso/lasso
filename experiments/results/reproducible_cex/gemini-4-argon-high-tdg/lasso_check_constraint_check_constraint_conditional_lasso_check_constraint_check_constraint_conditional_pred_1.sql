-- Schema DDL
CREATE TABLE Projects (id INTEGER PRIMARY KEY, status TEXT(20), closed_date DATE, CHECK (status <> 'Closed' OR NOT closed_date IS NULL));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Projects (id, status, closed_date) VALUES (1, 'Closed', '2023-01-15');
INSERT INTO Projects (id, status, closed_date) VALUES (2, 'Open', NULL);
INSERT INTO Projects (id, status, closed_date) VALUES (3, 'Open', '2023-02-01');
INSERT INTO Projects (id, status, closed_date) VALUES (4, 'Closed', '2023-03-10');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id FROM Projects WHERE status = 'Closed';

/*
Gold Result:
(1,)
(4,)
*/

-- Prediction Query
SELECT id FROM Projects WHERE status = 'Open';

/*
Prediction Result:
(2,)
(3,)
*/