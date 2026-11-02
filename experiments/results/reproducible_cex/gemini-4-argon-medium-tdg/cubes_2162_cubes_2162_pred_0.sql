-- Schema DDL
CREATE TABLE "architect" ("id" TEXT PRIMARY KEY, "name" TEXT, "nationality" TEXT, "gender" TEXT);

CREATE TABLE "bridge" ("id" INTEGER PRIMARY KEY, "architect_id" INTEGER, "name" TEXT, "location" TEXT, "length_meters" REAL, "length_feet" REAL, FOREIGN KEY ("architect_id") REFERENCES "architect" ("id"));

CREATE TABLE "mill" ("id" INTEGER PRIMARY KEY, "architect_id" INTEGER, "location" TEXT, "name" TEXT, "type" TEXT, "built_year" INTEGER, "notes" TEXT, FOREIGN KEY ("architect_id") REFERENCES "architect" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
-- Tests boundary condition where all rows are 'female' (Gold query should return an empty result set; catches inverted WHERE conditions or missing WHERE)
INSERT INTO "architect" ("id", "name", "nationality", "gender") VALUES ('1', 'Hannah', 'German', 'female');
INSERT INTO "architect" ("id", "name", "nationality", "gender") VALUES ('2', 'Irene', 'German', 'female');
INSERT INTO "architect" ("id", "name", "nationality", "gender") VALUES ('3', 'Julia', 'Spanish', 'female');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "n_distinct" AS "count___" FROM (SELECT "gender", "nationality", COUNT(DISTINCT "gender") AS "n_distinct" FROM "architect" GROUP BY "gender", "nationality") WHERE ("gender" <> 'female') ORDER BY count___;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(*) FROM architect WHERE gender = 'female';

/*
Prediction Result:
(3,)
*/