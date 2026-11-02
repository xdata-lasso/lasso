-- Schema DDL
CREATE TABLE "architect" ("id" TEXT PRIMARY KEY, "name" TEXT, "nationality" TEXT, "gender" TEXT);

CREATE TABLE "bridge" ("id" INTEGER PRIMARY KEY, "architect_id" INTEGER, "name" TEXT, "location" TEXT, "length_meters" REAL, "length_feet" REAL, FOREIGN KEY ("architect_id") REFERENCES "architect" ("id"));

CREATE TABLE "mill" ("id" INTEGER PRIMARY KEY, "architect_id" INTEGER, "location" TEXT, "name" TEXT, "type" TEXT, "built_year" INTEGER, "notes" TEXT, FOREIGN KEY ("architect_id") REFERENCES "architect" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "architect" ("id", "name", "nationality", "gender") VALUES ('1', 'Frank Lloyd Wright', 'American', 'Male');
INSERT INTO "mill" ("id", "architect_id", "location", "name", "type", "built_year", "notes") VALUES (1, 1, 'Donceel', 'Donceel Mill', 'Water', 1850, 'Historic');
INSERT INTO "mill" ("id", "architect_id", "location", "name", "type", "built_year", "notes") VALUES (2, 1, 'Brussels', 'Grand Mill', 'Wind', 1900, 'Active');
INSERT INTO "mill" ("id", "architect_id", "location", "name", "type", "built_year", "notes") VALUES (3, 1, 'Antwerp', 'Grand Mill', 'Wind', 1920, 'Active');
INSERT INTO "mill" ("id", "architect_id", "location", "name", "type", "built_year", "notes") VALUES (4, 1, 'Liege', 'Alpha Mill', 'Steam', 1880, 'Renovated');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "mill" WHERE ("location" <> 'Donceel') ORDER BY name, mill.id NULLS LAST;

/*
Gold Result:
('Alpha Mill',)
('Grand Mill',)
('Grand Mill',)
*/

-- Prediction Query
SELECT name FROM mill WHERE LOCATION <> 'Donceel';

/*
Prediction Result:
('Grand Mill',)
('Grand Mill',)
('Alpha Mill',)
*/