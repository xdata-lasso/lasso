-- Schema DDL
CREATE TABLE "mission" ("Mission_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Code" TEXT, "Launched_Year" INTEGER, "Location" TEXT, "Speed_knots" INTEGER, "Fate" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "ship" ("Ship_ID"));

CREATE TABLE "ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Nationality" TEXT, "Tonnage" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "ship" ("Ship_ID", "Name", "Type", "Nationality", "Tonnage") VALUES (1, 'Enterprise', 'Carrier', 'United States', 80000);
INSERT INTO "ship" ("Ship_ID", "Name", "Type", "Nationality", "Tonnage") VALUES (2, 'Victory', 'Battleship', 'United Kingdom', 3500);
INSERT INTO "ship" ("Ship_ID", "Name", "Type", "Nationality", "Tonnage") VALUES (3, 'Bismarck', 'Battleship', 'Germany', 41700);
INSERT INTO "ship" ("Ship_ID", "Name", "Type", "Nationality", "Tonnage") VALUES (4, 'Ghost', 'Phantom', NULL, 1000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "ship" WHERE ("nationality" <> 'United States' OR "nationality" <> 'United Kingdom') ORDER BY name, ship.ship_id NULLS LAST;

/*
Gold Result:
('Bismarck',)
('Enterprise',)
('Victory',)
*/

-- Prediction Query
SELECT Name FROM ship WHERE Nationality = 'United States' OR Nationality = 'United Kingdom';

/*
Prediction Result:
('Enterprise',)
('Victory',)
*/