-- Schema DDL
CREATE TABLE Events (event_id INTEGER PRIMARY KEY, title TEXT, starts_at DATETIME, category TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO events (event_id, title, starts_at, category) VALUES (0, 'seminar', '2022-12-31 00:00:00.000000', '2022'), (1, '2020', '2022-10-27 00:00:00.000000', 'seminar'), (2, '2020', '2020-01-01 00:00:00.000000', NULL), (3, '2020-01-01', '2023-01-01 01:00:00.000000', '2020-01-01'), (4, '%Y', '2023-01-01 01:00:00.000000', 'default1'), (5, 'default2', '2022-12-31 00:00:00.000000', 'seminar'), (6, '2020', '2020-01-01 00:00:00.000000', '%Y'), (7, 'seminar', '2020-01-01 00:00:00.000000', 'seminar'), (8, NULL, NULL, 'default2');
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