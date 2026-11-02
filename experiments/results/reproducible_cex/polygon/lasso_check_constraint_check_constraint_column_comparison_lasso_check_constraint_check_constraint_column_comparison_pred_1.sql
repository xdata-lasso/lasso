-- Schema DDL
CREATE TABLE Events (event_id INTEGER PRIMARY KEY, start_date DATE, end_date DATE, CHECK (start_date <= end_date));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Events" ("event_id", "start_date", "end_date") VALUES (8, '1000-08-27', '1000-08-27');
INSERT INTO "Events" ("event_id", "start_date", "end_date") VALUES (7, '2020-01-02', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT event_id FROM Events WHERE start_date > '2020-01-01';

/*
Gold Result:
(7,)
*/

-- Prediction Query
SELECT event_id FROM Events WHERE start_date < '2020-01-01';

/*
Prediction Result:
(8,)
*/