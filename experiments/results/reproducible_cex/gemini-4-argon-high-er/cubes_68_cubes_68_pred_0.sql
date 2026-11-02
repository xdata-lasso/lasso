-- Schema DDL
CREATE TABLE "AREA_CODE_STATE" ("area_code" INTEGER PRIMARY KEY, "state" TEXT(2) UNIQUE);

CREATE TABLE "CONTESTANTS" ("contestant_number" INTEGER PRIMARY KEY, "contestant_name" TEXT(50));

CREATE TABLE "VOTES" ("vote_id" INTEGER PRIMARY KEY, "contestant_number" INTEGER, "state" TEXT(2), "phone_number" INTEGER, "created" TIMESTAMP, FOREIGN KEY ("contestant_number") REFERENCES "CONTESTANTS" ("contestant_number"), FOREIGN KEY ("state") REFERENCES "AREA_CODE_STATE" ("state"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO CONTESTANTS (contestant_number, contestant_name) VALUES (1, 'A');
INSERT INTO CONTESTANTS (contestant_number, contestant_name) VALUES (2, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT contestant_number, contestant_name FROM contestants ORDER BY contestant_number;

/*
Gold Result:
(1, 'A')
(2, 'B')
*/

-- Prediction Query
SELECT contestant_number, contestant_name FROM contestants ORDER BY contestant_name DESC, contestants.contestant_number NULLS LAST;

/*
Prediction Result:
(2, 'B')
(1, 'A')
*/