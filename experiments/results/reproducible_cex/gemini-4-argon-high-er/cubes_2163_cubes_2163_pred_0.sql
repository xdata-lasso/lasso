-- Schema DDL
CREATE TABLE "architect" ("id" TEXT PRIMARY KEY, "name" TEXT, "nationality" TEXT, "gender" TEXT);

CREATE TABLE "bridge" ("id" INTEGER PRIMARY KEY, "architect_id" INTEGER, "name" TEXT, "location" TEXT, "length_meters" REAL, "length_feet" REAL, FOREIGN KEY ("architect_id") REFERENCES "architect" ("id"));

CREATE TABLE "mill" ("id" INTEGER PRIMARY KEY, "architect_id" INTEGER, "location" TEXT, "name" TEXT, "type" TEXT, "built_year" INTEGER, "notes" TEXT, FOREIGN KEY ("architect_id") REFERENCES "architect" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO mill (id, location, name) VALUES (1, 'Brussels', 'Mill B');
INSERT INTO mill (id, location, name) VALUES (2, 'Brussels', 'Mill A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "mill" WHERE ("location" <> 'Donceel') ORDER BY name, mill.id NULLS LAST;

/*
Gold Result:
('Mill A',)
('Mill B',)
*/

-- Prediction Query
SELECT name FROM mill WHERE LOCATION <> 'Donceel';

/*
Prediction Result:
('Mill B',)
('Mill A',)
*/