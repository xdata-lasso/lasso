-- Schema DDL
CREATE TABLE Events (event_id INTEGER PRIMARY KEY, start_date DATE, end_date DATE, CHECK (start_date <= end_date));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: events --
INSERT INTO "events" ("event_id", "start_date", "end_date") VALUES (1, '2020-01-02', '2025-06-17');

INSERT INTO "events" ("event_id", "start_date", "end_date") VALUES (2, '2020-01-01', '2025-06-17');

INSERT INTO "events" ("event_id", "start_date", "end_date") VALUES (3, NULL, '2021-11-08');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT event_id FROM Events WHERE start_date > '2020-01-01';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT event_id FROM Events;

/*
Prediction Result:
(1,)
(2,)
(3,)
*/