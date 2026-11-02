-- Schema DDL
CREATE TABLE "architect" ("id" TEXT PRIMARY KEY, "name" TEXT, "nationality" TEXT, "gender" TEXT);

CREATE TABLE "bridge" ("id" INTEGER PRIMARY KEY, "architect_id" INTEGER, "name" TEXT, "location" TEXT, "length_meters" REAL, "length_feet" REAL, FOREIGN KEY ("architect_id") REFERENCES "architect" ("id"));

CREATE TABLE "mill" ("id" INTEGER PRIMARY KEY, "architect_id" INTEGER, "location" TEXT, "name" TEXT, "type" TEXT, "built_year" INTEGER, "notes" TEXT, FOREIGN KEY ("architect_id") REFERENCES "architect" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "architect" ("id", "name", "nationality", "gender") VALUES ('1', 'John Doe', 'USA', 'male');
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