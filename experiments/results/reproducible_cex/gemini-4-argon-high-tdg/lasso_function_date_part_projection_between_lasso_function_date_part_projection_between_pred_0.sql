-- Schema DDL
CREATE TABLE Events (event_id INTEGER PRIMARY KEY, title TEXT, starts_at DATETIME, category TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 5
INSERT INTO Events (event_id, title, starts_at, category) VALUES (1, 'Mid 2022 Seminar', '2022-07-01 10:00:00', 'seminar');
INSERT INTO Events (event_id, title, starts_at, category) VALUES (2, 'End of 2022 Seminar', '2022-12-31 23:59:59', 'seminar');
INSERT INTO Events (event_id, title, starts_at, category) VALUES (3, 'New Year 2023 Seminar', '2023-01-01 00:00:00', 'seminar');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(title) FROM Events WHERE STRFTIME('%Y', starts_at) BETWEEN '2020' AND '2022' AND category = 'seminar';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(title) FROM Events WHERE starts_at BETWEEN '2020-01-01' AND '2022-12-31' AND category = 'seminar';

/*
Prediction Result:
(1,)
*/