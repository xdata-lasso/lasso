-- Schema DDL
CREATE TABLE "AREA_CODE_STATE" ("area_code" INTEGER PRIMARY KEY, "state" TEXT(2) UNIQUE);

CREATE TABLE "CONTESTANTS" ("contestant_number" INTEGER PRIMARY KEY, "contestant_name" TEXT(50));

CREATE TABLE "VOTES" ("vote_id" INTEGER PRIMARY KEY, "contestant_number" INTEGER, "state" TEXT(2), "phone_number" INTEGER, "created" TIMESTAMP, FOREIGN KEY ("contestant_number") REFERENCES "CONTESTANTS" ("contestant_number"), FOREIGN KEY ("state") REFERENCES "AREA_CODE_STATE" ("state"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "area_code_state" ("area_code", "state") VALUES (1003, 'Ohio');
INSERT INTO "contestants" ("contestant_number", "contestant_name") VALUES (1002, 'Noah Rhodes');
INSERT INTO "votes" ("vote_id", "contestant_number", "state", "phone_number", "created") VALUES (1004, 1002, 'Ohio', 1005, '1970-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT COUNT(*) OVER () AS count___ FROM (SELECT * FROM contestants AS LHS WHERE NOT EXISTS(SELECT 1 FROM votes AS RHS WHERE (LHS.contestant_number = RHS.contestant_number))) ORDER BY count___;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(*) FROM contestants WHERE NOT contestant_number IN (SELECT contestant_number FROM votes);

/*
Prediction Result:
(0,)
*/