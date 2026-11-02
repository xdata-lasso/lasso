-- Schema DDL
CREATE TABLE Events (event_id INTEGER PRIMARY KEY, start_date DATE, end_date DATE, CHECK (start_date <= end_date));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Events (event_id, start_date, end_date) VALUES (101, '2019-12-31', '2020-01-05');
INSERT INTO Events (event_id, start_date, end_date) VALUES (102, '2020-01-01', '2020-01-01');
INSERT INTO Events (event_id, start_date, end_date) VALUES (103, '2020-01-01', '2020-01-02');
INSERT INTO Events (event_id, start_date, end_date) VALUES (104, '2020-01-02', '2020-01-02');
INSERT INTO Events (event_id, start_date, end_date) VALUES (105, '2020-02-01', '2020-03-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT event_id FROM Events WHERE start_date > '2020-01-01';

/*
Gold Result:
(104,)
(105,)
*/

-- Prediction Query
SELECT event_id FROM Events WHERE start_date < '2020-01-01';

/*
Prediction Result:
(101,)
*/