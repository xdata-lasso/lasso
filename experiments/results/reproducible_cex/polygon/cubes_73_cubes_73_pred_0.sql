-- Schema DDL
CREATE TABLE "AREA_CODE_STATE" ("area_code" INTEGER PRIMARY KEY, "state" TEXT(2) UNIQUE);

CREATE TABLE "CONTESTANTS" ("contestant_number" INTEGER PRIMARY KEY, "contestant_name" TEXT(50));

CREATE TABLE "VOTES" ("vote_id" INTEGER PRIMARY KEY, "contestant_number" INTEGER, "state" TEXT(2), "phone_number" INTEGER, "created" TIMESTAMP, FOREIGN KEY ("contestant_number") REFERENCES "CONTESTANTS" ("contestant_number"), FOREIGN KEY ("state") REFERENCES "AREA_CODE_STATE" ("state"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "AREA_CODE_STATE" ("area_code", "state") VALUES (7, NULL);
INSERT INTO "AREA_CODE_STATE" ("area_code", "state") VALUES (6, '12');
INSERT INTO "CONTESTANTS" ("contestant_number", "contestant_name") VALUES (9, '12');
INSERT INTO "CONTESTANTS" ("contestant_number", "contestant_name") VALUES (8, '12');
INSERT INTO "VOTES" ("vote_id", "contestant_number", "state", "phone_number", "created") VALUES (11, 9, 12, 12, 13);
INSERT INTO "VOTES" ("vote_id", "contestant_number", "state", "phone_number", "created") VALUES (10, 8, 12, 12, 13);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT state, created FROM votes ORDER BY state, votes.vote_id NULLS LAST;

/*
Gold Result:
('12', 13)
('12', 13)
*/

-- Prediction Query
SELECT DISTINCT state, created FROM votes;

/*
Prediction Result:
('12', 13)
*/