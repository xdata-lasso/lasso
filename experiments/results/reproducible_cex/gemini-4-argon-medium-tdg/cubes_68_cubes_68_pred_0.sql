-- Schema DDL
CREATE TABLE "AREA_CODE_STATE" ("area_code" INTEGER PRIMARY KEY, "state" TEXT(2) UNIQUE);

CREATE TABLE "CONTESTANTS" ("contestant_number" INTEGER PRIMARY KEY, "contestant_name" TEXT(50));

CREATE TABLE "VOTES" ("vote_id" INTEGER PRIMARY KEY, "contestant_number" INTEGER, "state" TEXT(2), "phone_number" INTEGER, "created" TIMESTAMP, FOREIGN KEY ("contestant_number") REFERENCES "CONTESTANTS" ("contestant_number"), FOREIGN KEY ("state") REFERENCES "AREA_CODE_STATE" ("state"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering (out-of-order insertion, negative, zero, positive numbers),
-- ordering by contestant_number vs contestant_name, and join anomalies (0, 1, and multiple votes).
INSERT INTO AREA_CODE_STATE (area_code, state) VALUES (212, 'NY');
INSERT INTO AREA_CODE_STATE (area_code, state) VALUES (310, 'CA');
INSERT INTO CONTESTANTS (contestant_number, contestant_name) VALUES (10, 'Zack');
INSERT INTO CONTESTANTS (contestant_number, contestant_name) VALUES (2, 'Charlie');
INSERT INTO CONTESTANTS (contestant_number, contestant_name) VALUES (-5, 'York');
INSERT INTO CONTESTANTS (contestant_number, contestant_name) VALUES (0, 'Alice');
INSERT INTO VOTES (vote_id, contestant_number, state, phone_number, created) VALUES (101, 10, 'NY', 5550101, '2023-01-01 10:00:00');
INSERT INTO VOTES (vote_id, contestant_number, state, phone_number, created) VALUES (102, 10, 'CA', 5550102, '2023-01-01 10:05:00');
INSERT INTO VOTES (vote_id, contestant_number, state, phone_number, created) VALUES (103, 2, 'NY', 5550103, '2023-01-01 10:10:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT contestant_number, contestant_name FROM contestants ORDER BY contestant_number;

/*
Gold Result:
(-5, 'York')
(0, 'Alice')
(2, 'Charlie')
(10, 'Zack')
*/

-- Prediction Query
SELECT contestant_number, contestant_name FROM contestants ORDER BY contestant_name DESC, contestants.contestant_number NULLS LAST;

/*
Prediction Result:
(10, 'Zack')
(-5, 'York')
(2, 'Charlie')
(0, 'Alice')
*/