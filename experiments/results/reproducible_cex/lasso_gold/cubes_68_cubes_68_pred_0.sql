-- Schema DDL
CREATE TABLE "AREA_CODE_STATE" ("area_code" INTEGER PRIMARY KEY, "state" TEXT(2) UNIQUE);

CREATE TABLE "CONTESTANTS" ("contestant_number" INTEGER PRIMARY KEY, "contestant_name" TEXT(50));

CREATE TABLE "VOTES" ("vote_id" INTEGER PRIMARY KEY, "contestant_number" INTEGER, "state" TEXT(2), "phone_number" INTEGER, "created" TIMESTAMP, FOREIGN KEY ("contestant_number") REFERENCES "CONTESTANTS" ("contestant_number"), FOREIGN KEY ("state") REFERENCES "AREA_CODE_STATE" ("state"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "contestants" ("contestant_number", "contestant_name") VALUES (0, 'Abigail Shaffer');
INSERT INTO "contestants" ("contestant_number", "contestant_name") VALUES (150, 'Abigail Shaffer');
INSERT INTO "contestants" ("contestant_number", "contestant_name") VALUES (20, 'Ryan Munoz');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT contestant_number, contestant_name FROM contestants ORDER BY contestant_number;

/*
Gold Result:
(0, 'Abigail Shaffer')
(20, 'Ryan Munoz')
(150, 'Abigail Shaffer')
*/

-- Prediction Query
SELECT contestant_number, contestant_name FROM contestants ORDER BY contestant_name DESC, contestants.contestant_number NULLS LAST;

/*
Prediction Result:
(20, 'Ryan Munoz')
(0, 'Abigail Shaffer')
(150, 'Abigail Shaffer')
*/