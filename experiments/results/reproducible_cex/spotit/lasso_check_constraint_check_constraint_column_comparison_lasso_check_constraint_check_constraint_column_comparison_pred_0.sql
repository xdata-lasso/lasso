-- Schema DDL
CREATE TABLE "EVENTS" (
    "EVENT_ID" INT,
    "START_DATE" DATE,
    "END_DATE" DATE,
    PRIMARY KEY ("EVENT_ID"),
    CHECK (start_date <= end_date)
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO EVENTS VALUES (1, '0001-01-01', '2020-01-01');
INSERT INTO EVENTS VALUES (0, '2020-01-01', '2020-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT event_id FROM Events WHERE start_date > '2020-01-01';

/*
Gold Result:
*/

-- Prediction Query
SELECT event_id FROM Events;

/*
Prediction Result:
(0,)
(1,)
*/