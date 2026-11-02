-- Schema DDL
CREATE TABLE Events (event_id INTEGER PRIMARY KEY, start_date DATE, end_date DATE, CHECK (start_date <= end_date));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Events (event_id, start_date, end_date) VALUES (1, '2019-12-31', '2020-01-01');
INSERT INTO Events (event_id, start_date, end_date) VALUES (2, '2019-12-31', '2020-01-05');
INSERT INTO Events (event_id, start_date, end_date) VALUES (3, '2020-01-01', '2020-01-01');
INSERT INTO Events (event_id, start_date, end_date) VALUES (4, '2020-01-01', '2020-01-05');
INSERT INTO Events (event_id, start_date, end_date) VALUES (5, '2020-01-02', '2020-01-02');
INSERT INTO Events (event_id, start_date, end_date) VALUES (6, '2020-01-02', '2020-01-10');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT event_id FROM Events WHERE start_date > '2020-01-01';

/*
Gold Result:
(5,)
(6,)
*/

-- Prediction Query
SELECT event_id FROM Events;

/*
Prediction Result:
(1,)
(2,)
(3,)
(4,)
(5,)
(6,)
*/