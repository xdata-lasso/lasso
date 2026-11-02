-- Schema DDL
CREATE TABLE "architect" ("id" TEXT PRIMARY KEY, "name" TEXT, "nationality" TEXT, "gender" TEXT);

CREATE TABLE "bridge" ("id" INTEGER PRIMARY KEY, "architect_id" INTEGER, "name" TEXT, "location" TEXT, "length_meters" REAL, "length_feet" REAL, FOREIGN KEY ("architect_id") REFERENCES "architect" ("id"));

CREATE TABLE "mill" ("id" INTEGER PRIMARY KEY, "architect_id" INTEGER, "location" TEXT, "name" TEXT, "type" TEXT, "built_year" INTEGER, "notes" TEXT, FOREIGN KEY ("architect_id") REFERENCES "architect" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "architect" ("id", "name", "nationality", "gender") VALUES ('1', 'Frank Lloyd Wright', 'American', 'male');
INSERT INTO "architect" ("id", "name", "nationality", "gender") VALUES ('2', 'Louis Sullivan', 'American', 'male');
INSERT INTO "architect" ("id", "name", "nationality", "gender") VALUES ('3', 'Norman Foster', 'British', 'male');
INSERT INTO "architect" ("id", "name", "nationality", "gender") VALUES ('4', 'Santiago Calatrava', NULL, 'male');
INSERT INTO "architect" ("id", "name", "nationality", "gender") VALUES ('5', 'Zaha Hadid', 'British', 'female');
INSERT INTO "architect" ("id", "name", "nationality", "gender") VALUES ('6', 'Julia Morgan', 'American', 'female');
INSERT INTO "architect" ("id", "name", "nationality", "gender") VALUES ('7', 'Unknown Architect', 'French', NULL);
INSERT INTO "bridge" ("id", "architect_id", "name", "location", "length_meters", "length_feet") VALUES (1, 3, 'Millennium Bridge', 'London', 325.0, 1066.0);
INSERT INTO "mill" ("id", "architect_id", "location", "name", "type", "built_year", "notes") VALUES (1, 1, 'Spring Green', 'Romeo and Juliet Windmill', 'Windmill', 1896, 'Wooden structure');
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
(2,)
*/