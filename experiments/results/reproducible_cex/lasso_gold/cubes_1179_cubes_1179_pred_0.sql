-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (1008, 'Abigail Shaffer', 'save', 1009.5, 'knowledge', 'grow');
INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (1011, 'Ryan Munoz', 'surface', 1012.5, 'animal', 'show');
INSERT INTO "captain" ("captain_id", "ship_id", "name", "age", "class", "rank") VALUES (1010, 1008, 'Lisa Hensley', 'bar', 'best', 'finally');
INSERT INTO "captain" ("captain_id", "ship_id", "name", "age", "class", "rank") VALUES (1013, 1011, 'Daniel Gallagher', 'blue', 'old', 'husband');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, CLASS, rank FROM captain ORDER BY name, captain.captain_id NULLS LAST;

/*
Gold Result:
('Daniel Gallagher', 'old', 'husband')
('Lisa Hensley', 'best', 'finally')
*/

-- Prediction Query
SELECT name, CLASS, rank FROM captain;

/*
Prediction Result:
('Lisa Hensley', 'best', 'finally')
('Daniel Gallagher', 'old', 'husband')
*/