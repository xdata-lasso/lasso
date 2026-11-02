-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering (out-of-order insertion), duplicate names (testing DISTINCT mutants),
-- and Ship vs Captain relationship (testing erroneous JOINs, missing captains, and multiple captains per ship).
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (1, 'Zulu', 'Cargo', 1995.0, 'A', 'Panama');
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (2, 'Alpha', 'Tanker', 2005.0, 'B', 'Liberia');
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (3, 'Alpha', 'Passenger', 2010.0, 'A', 'Bahamas');
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (101, 1, 'John Smith', '45', 'A', 'Senior');
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (102, 1, 'Jane Doe', '38', 'B', 'Junior');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM ship ORDER BY name, ship.ship_id NULLS LAST;

/*
Gold Result:
('Alpha',)
('Alpha',)
('Zulu',)
*/

-- Prediction Query
SELECT name FROM ship ORDER BY built_year, CLASS, ship.ship_id NULLS LAST;

/*
Prediction Result:
('Zulu',)
('Alpha',)
('Alpha',)
*/