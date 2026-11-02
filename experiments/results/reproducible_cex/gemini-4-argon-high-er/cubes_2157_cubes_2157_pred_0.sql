-- Schema DDL
CREATE TABLE "architect" ("id" TEXT PRIMARY KEY, "name" TEXT, "nationality" TEXT, "gender" TEXT);

CREATE TABLE "bridge" ("id" INTEGER PRIMARY KEY, "architect_id" INTEGER, "name" TEXT, "location" TEXT, "length_meters" REAL, "length_feet" REAL, FOREIGN KEY ("architect_id") REFERENCES "architect" ("id"));

CREATE TABLE "mill" ("id" INTEGER PRIMARY KEY, "architect_id" INTEGER, "location" TEXT, "name" TEXT, "type" TEXT, "built_year" INTEGER, "notes" TEXT, FOREIGN KEY ("architect_id") REFERENCES "architect" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO mill (id, name, type, built_year) VALUES (1, 'B', 'Grondzeiler', 1900);
INSERT INTO mill (id, name, type, built_year) VALUES (2, 'A', 'Grondzeiler', 1901);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name", "built_year" FROM "mill" WHERE ("type" = 'Grondzeiler') ORDER BY name, mill.id NULLS LAST;

/*
Gold Result:
('A', 1901)
('B', 1900)
*/

-- Prediction Query
SELECT name, built_year FROM mill WHERE TYPE = 'Grondzeiler';

/*
Prediction Result:
('B', 1900)
('A', 1901)
*/