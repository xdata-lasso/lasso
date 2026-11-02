-- Schema DDL
CREATE TABLE Events (event_id INTEGER PRIMARY KEY, title TEXT, starts_at DATETIME, category TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Events (event_id, title, starts_at, category) VALUES (1, 'AI Seminar', '2020-01-01 00:00:00', 'seminar');
INSERT INTO Events (event_id, title, starts_at, category) VALUES (2, 'AI Seminar', '2021-06-15 12:00:00', 'seminar');
INSERT INTO Events (event_id, title, starts_at, category) VALUES (3, 'DB Seminar', '2022-12-31 23:59:59', 'seminar');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(title) FROM Events WHERE STRFTIME('%Y', starts_at) BETWEEN '2020' AND '2022' AND category = 'seminar';

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT(title) FROM Events WHERE starts_at BETWEEN '2020-01-01' AND '2022-12-31' AND category = 'seminar';

/*
Prediction Result:
(2,)
*/