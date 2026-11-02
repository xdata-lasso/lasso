-- Schema DDL
CREATE TABLE "mission" ("Mission_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Code" TEXT, "Launched_Year" INTEGER, "Location" TEXT, "Speed_knots" INTEGER, "Fate" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "ship" ("Ship_ID"));

CREATE TABLE "ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Nationality" TEXT, "Tonnage" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by Type, secondary ordering by Ship_ID, and detects incorrect INNER JOINs with the mission table.
INSERT INTO "ship" ("Ship_ID", "Name", "Type", "Nationality", "Tonnage") VALUES (10, 'Alpha', 'Destroyer', 'USA', 2000);
INSERT INTO "ship" ("Ship_ID", "Name", "Type", "Nationality", "Tonnage") VALUES (2, 'Beta', 'Destroyer', 'UK', 2500);
INSERT INTO "ship" ("Ship_ID", "Name", "Type", "Nationality", "Tonnage") VALUES (5, 'Gamma', 'Cruiser', 'France', 5000);
INSERT INTO "mission" ("Mission_ID", "Ship_ID", "Code", "Launched_Year", "Location", "Speed_knots", "Fate") VALUES (1, 10, 'M1', 1940, 'Atlantic', 30, 'Survived');
INSERT INTO "mission" ("Mission_ID", "Ship_ID", "Code", "Launched_Year", "Location", "Speed_knots", "Fate") VALUES (2, 10, 'M2', 1942, 'Pacific', 28, 'Sunk');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT TYPE, nationality FROM ship ORDER BY TYPE, ship.ship_id NULLS LAST;

/*
Gold Result:
('Cruiser', 'France')
('Destroyer', 'UK')
('Destroyer', 'USA')
*/

-- Prediction Query
SELECT TYPE, Nationality FROM ship;

/*
Prediction Result:
('Destroyer', 'UK')
('Cruiser', 'France')
('Destroyer', 'USA')
*/