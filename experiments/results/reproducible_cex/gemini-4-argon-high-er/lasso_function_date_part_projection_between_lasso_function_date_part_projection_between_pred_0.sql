-- Schema DDL
CREATE TABLE Events (event_id INTEGER PRIMARY KEY, title TEXT, starts_at DATETIME, category TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Events (event_id, title, starts_at, category) VALUES (1, 'AI Seminar', '2022-12-31 12:00:00', 'seminar');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(title) FROM Events WHERE STRFTIME('%Y', starts_at) BETWEEN '2020' AND '2022' AND category = 'seminar';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(title) FROM Events WHERE starts_at BETWEEN '2020-01-01' AND '2022-12-31' AND category = 'seminar';

/*
Prediction Result:
(0,)
*/