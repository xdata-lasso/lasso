-- Schema DDL
CREATE TABLE "AREA_CODE_STATE" ("area_code" INTEGER PRIMARY KEY, "state" TEXT(2) UNIQUE);

CREATE TABLE "CONTESTANTS" ("contestant_number" INTEGER PRIMARY KEY, "contestant_name" TEXT(50));

CREATE TABLE "VOTES" ("vote_id" INTEGER PRIMARY KEY, "contestant_number" INTEGER, "state" TEXT(2), "phone_number" INTEGER, "created" TIMESTAMP, FOREIGN KEY ("contestant_number") REFERENCES "CONTESTANTS" ("contestant_number"), FOREIGN KEY ("state") REFERENCES "AREA_CODE_STATE" ("state"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO AREA_CODE_STATE (area_code, state) VALUES (212, 'NY');
INSERT INTO AREA_CODE_STATE (area_code, state) VALUES (310, 'CA');
INSERT INTO CONTESTANTS (contestant_number, contestant_name) VALUES (10, 'Zoe');
INSERT INTO CONTESTANTS (contestant_number, contestant_name) VALUES (2, 'Bob');
INSERT INTO CONTESTANTS (contestant_number, contestant_name) VALUES (1, 'Alice');
INSERT INTO CONTESTANTS (contestant_number, contestant_name) VALUES (5, 'Charlie');
INSERT INTO VOTES (vote_id, contestant_number, state, phone_number, created) VALUES (101, 2, 'NY', 5550101, '2023-01-01 10:00:00');
INSERT INTO VOTES (vote_id, contestant_number, state, phone_number, created) VALUES (102, 2, 'CA', 5550102, '2023-01-01 10:05:00');
INSERT INTO VOTES (vote_id, contestant_number, state, phone_number, created) VALUES (103, 10, 'NY', 5550103, '2023-01-01 10:10:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT contestant_number, contestant_name FROM contestants ORDER BY contestant_number;

/*
Gold Result:
(1, 'Alice')
(2, 'Bob')
(5, 'Charlie')
(10, 'Zoe')
*/

-- Prediction Query
SELECT contestant_number, contestant_name FROM contestants ORDER BY contestant_name DESC, contestants.contestant_number NULLS LAST;

/*
Prediction Result:
(10, 'Zoe')
(5, 'Charlie')
(2, 'Bob')
(1, 'Alice')
*/