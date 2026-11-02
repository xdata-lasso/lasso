-- Schema DDL
CREATE TABLE Events (event_id INTEGER PRIMARY KEY, start_date DATE, end_date DATE, CHECK (start_date <= end_date));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Events (event_id, start_date, end_date) VALUES (1, '2020-01-01', '2020-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT event_id FROM Events WHERE start_date > '2020-01-01';

/*
Gold Result:
*/

-- Prediction Query
SELECT event_id FROM Events;

/*
Prediction Result:
(1,)
*/