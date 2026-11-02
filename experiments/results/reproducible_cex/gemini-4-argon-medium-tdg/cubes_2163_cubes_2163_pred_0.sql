-- Schema DDL
CREATE TABLE "architect" ("id" TEXT PRIMARY KEY, "name" TEXT, "nationality" TEXT, "gender" TEXT);

CREATE TABLE "bridge" ("id" INTEGER PRIMARY KEY, "architect_id" INTEGER, "name" TEXT, "location" TEXT, "length_meters" REAL, "length_feet" REAL, FOREIGN KEY ("architect_id") REFERENCES "architect" ("id"));

CREATE TABLE "mill" ("id" INTEGER PRIMARY KEY, "architect_id" INTEGER, "location" TEXT, "name" TEXT, "type" TEXT, "built_year" INTEGER, "notes" TEXT, FOREIGN KEY ("architect_id") REFERENCES "architect" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic inequality filtering, duplicate names (DISTINCThandling), primary sort by name, and secondary sort by id.
INSERT INTO "architect" ("id", "name", "nationality", "gender") VALUES ('1', 'Frank Lloyd Wright', 'USA', 'Male');
INSERT INTO "mill" ("id", "architect_id", "location", "name", "type", "built_year", "notes") VALUES (1, 1, 'Donceel', 'Excluded Mill', 'Windmill', 1800, 'Should be filtered out');
INSERT INTO "mill" ("id", "architect_id", "location", "name", "type", "built_year", "notes") VALUES (2, 1, 'Brussels', 'Beta Mill', 'Watermill', 1850, 'Valid row');
INSERT INTO "mill" ("id", "architect_id", "location", "name", "type", "built_year", "notes") VALUES (3, 1, 'Antwerp', 'Alpha Mill', 'Windmill', 1900, 'Tie in name, higher id');
INSERT INTO "mill" ("id", "architect_id", "location", "name", "type", "built_year", "notes") VALUES (10, 1, 'Ghent', 'Alpha Mill', 'Watermill', 1910, 'Tie in name, even higher id');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "mill" WHERE ("location" <> 'Donceel') ORDER BY name, mill.id NULLS LAST;

/*
Gold Result:
('Alpha Mill',)
('Alpha Mill',)
('Beta Mill',)
*/

-- Prediction Query
SELECT name FROM mill WHERE LOCATION <> 'Donceel';

/*
Prediction Result:
('Beta Mill',)
('Alpha Mill',)
('Alpha Mill',)
*/