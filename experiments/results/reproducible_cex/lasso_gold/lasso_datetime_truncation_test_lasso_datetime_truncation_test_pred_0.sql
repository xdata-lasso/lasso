-- Schema DDL
CREATE TABLE Events (event_id INTEGER PRIMARY KEY, event_time DATETIME);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "events" ("event_id", "event_time") VALUES (1010, '2023-05-15 12:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(event_id) FROM Events WHERE DATE(event_time) > '2023-05-15';

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(*) FROM Events WHERE event_time > '2023-05-15 00:00:00';

/*
Prediction Result:
(1,)
*/