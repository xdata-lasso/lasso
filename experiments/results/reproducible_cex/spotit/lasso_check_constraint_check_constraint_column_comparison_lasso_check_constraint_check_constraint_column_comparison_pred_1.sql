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
INSERT INTO EVENTS VALUES (-1, '2020-01-02', '2020-01-02');
INSERT INTO EVENTS VALUES (0, '2020-01-02', '2020-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT event_id FROM Events WHERE start_date > '2020-01-01';

/*
Gold Result:
(-1,)
(0,)
*/

-- Prediction Query
SELECT event_id FROM Events WHERE start_date < '2020-01-01';

/*
Prediction Result:
*/