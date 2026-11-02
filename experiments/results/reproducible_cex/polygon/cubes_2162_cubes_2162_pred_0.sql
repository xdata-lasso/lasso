-- Schema DDL
CREATE TABLE "architect" ("id" TEXT PRIMARY KEY, "name" TEXT, "nationality" TEXT, "gender" TEXT);

CREATE TABLE "bridge" ("id" INTEGER PRIMARY KEY, "architect_id" INTEGER, "name" TEXT, "location" TEXT, "length_meters" REAL, "length_feet" REAL, FOREIGN KEY ("architect_id") REFERENCES "architect" ("id"));

CREATE TABLE "mill" ("id" INTEGER PRIMARY KEY, "architect_id" INTEGER, "location" TEXT, "name" TEXT, "type" TEXT, "built_year" INTEGER, "notes" TEXT, FOREIGN KEY ("architect_id") REFERENCES "architect" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "architect" ("id", "name", "nationality", "gender") VALUES ('female10', 'female1', NULL, NULL);
INSERT INTO "architect" ("id", "name", "nationality", "gender") VALUES ('female9', 'female1', NULL, 'female19');
INSERT INTO "bridge" ("id", "architect_id", "name", "location", "length_meters", "length_feet") VALUES (12, NULL, 'female1', 'female1', 1, 1);
INSERT INTO "bridge" ("id", "architect_id", "name", "location", "length_meters", "length_feet") VALUES (11, 'female9', 'female1', 'female1', 1, 1);
INSERT INTO "mill" ("id", "architect_id", "location", "name", "type", "built_year", "notes") VALUES (14, 'female10', 'female1', 'female1', 'female1', 1, 'female1');
INSERT INTO "mill" ("id", "architect_id", "location", "name", "type", "built_year", "notes") VALUES (13, 'female9', 'female1', 'female1', 'female1', 1, 'female1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "n_distinct" AS "count___" FROM (SELECT "gender", "nationality", COUNT(DISTINCT "gender") AS "n_distinct" FROM "architect" GROUP BY "gender", "nationality") WHERE ("gender" <> 'female') ORDER BY count___;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM architect WHERE gender = 'female';

/*
Prediction Result:
(0,)
*/