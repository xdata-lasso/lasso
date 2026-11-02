-- Schema DDL
CREATE TABLE "AREA_CODE_STATE" ("area_code" INTEGER PRIMARY KEY, "state" TEXT(2) UNIQUE);

CREATE TABLE "CONTESTANTS" ("contestant_number" INTEGER PRIMARY KEY, "contestant_name" TEXT(50));

CREATE TABLE "VOTES" ("vote_id" INTEGER PRIMARY KEY, "contestant_number" INTEGER, "state" TEXT(2), "phone_number" INTEGER, "created" TIMESTAMP, FOREIGN KEY ("contestant_number") REFERENCES "CONTESTANTS" ("contestant_number"), FOREIGN KEY ("state") REFERENCES "AREA_CODE_STATE" ("state"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "CONTESTANTS" ("contestant_number", "contestant_name") VALUES (1, 'Alice');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT MAX(area_code) OVER () AS max_area_code_, minarea_code AS min_area_code_ FROM (SELECT area_code, state, MIN(area_code) OVER () AS minarea_code FROM area_code_state) ORDER BY max_area_code_, min_area_code_ NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT MAX(area_code), MIN(area_code) FROM area_code_state;

/*
Prediction Result:
(None, None)
*/