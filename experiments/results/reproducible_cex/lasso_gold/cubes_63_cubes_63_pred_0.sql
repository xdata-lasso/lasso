-- Schema DDL
CREATE TABLE "AREA_CODE_STATE" ("area_code" INTEGER PRIMARY KEY, "state" TEXT(2) UNIQUE);

CREATE TABLE "CONTESTANTS" ("contestant_number" INTEGER PRIMARY KEY, "contestant_name" TEXT(50));

CREATE TABLE "VOTES" ("vote_id" INTEGER PRIMARY KEY, "contestant_number" INTEGER, "state" TEXT(2), "phone_number" INTEGER, "created" TIMESTAMP, FOREIGN KEY ("contestant_number") REFERENCES "CONTESTANTS" ("contestant_number"), FOREIGN KEY ("state") REFERENCES "AREA_CODE_STATE" ("state"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "area_code_state" ("area_code", "state") VALUES (1005, 'Ohio');
INSERT INTO "area_code_state" ("area_code", "state") VALUES (1010, 'Colorado');
INSERT INTO "contestants" ("contestant_number", "contestant_name") VALUES (1006, 'Noah Rhodes');
INSERT INTO "votes" ("vote_id", "contestant_number", "state", "phone_number", "created") VALUES (1007, 1006, 'Ohio', 1008, '1971-02-02');
INSERT INTO "votes" ("vote_id", "contestant_number", "state", "phone_number", "created") VALUES (1009, 1006, 'Colorado', 1008, '1971-02-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "created" AS "max_created_" FROM (SELECT "created", "vote_id", MAX("state") AS "state" FROM "votes" GROUP BY "created", "vote_id") WHERE ("state" = 'CA') ORDER BY max_created_;

/*
Gold Result:
*/

-- Prediction Query
SELECT MAX(created) FROM votes WHERE state = 'CA';

/*
Prediction Result:
(None,)
*/