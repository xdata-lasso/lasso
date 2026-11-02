-- Schema DDL
CREATE TABLE Events (event_id INTEGER PRIMARY KEY, start_date DATE, end_date DATE, CHECK (start_date <= end_date));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Events" ("event_id", "start_date", "end_date") VALUES (7, '2020-01-02', '2020-01-02');
INSERT INTO "Events" ("event_id", "start_date", "end_date") VALUES (6, '0998-01-16', '0998-06-30');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT event_id FROM Events WHERE start_date > '2020-01-01';

/*
Gold Result:
(7,)
*/

-- Prediction Query
SELECT event_id FROM Events;

/*
Prediction Result:
(6,)
(7,)
*/