-- Schema DDL
CREATE TABLE Events (event_id INTEGER PRIMARY KEY, start_date DATE, end_date DATE, CHECK (start_date <= end_date));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests exact boundary conditions on start_date ('2020-01-01', day before, day after)
-- and ensures end_date does not interfere when equal to start_date.
INSERT INTO Events (event_id, start_date, end_date) VALUES (1, '2019-12-31', '2019-12-31');
INSERT INTO Events (event_id, start_date, end_date) VALUES (2, '2020-01-01', '2020-01-01');
INSERT INTO Events (event_id, start_date, end_date) VALUES (3, '2020-01-02', '2020-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT event_id FROM Events WHERE start_date > '2020-01-01';

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT event_id FROM Events;

/*
Prediction Result:
(1,)
(2,)
(3,)
*/