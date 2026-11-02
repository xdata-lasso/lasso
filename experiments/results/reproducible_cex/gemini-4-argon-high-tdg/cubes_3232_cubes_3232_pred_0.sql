-- Schema DDL
CREATE TABLE "mission" ("Mission_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Code" TEXT, "Launched_Year" INTEGER, "Location" TEXT, "Speed_knots" INTEGER, "Fate" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "ship" ("Ship_ID"));

CREATE TABLE "ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Nationality" TEXT, "Tonnage" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "ship" ("Ship_ID", "Name", "Type", "Nationality", "Tonnage") VALUES (1, 'Yamato', 'Battleship', 'Japan', 71659);
INSERT INTO "ship" ("Ship_ID", "Name", "Type", "Nationality", "Tonnage") VALUES (2, 'Enterprise', 'Aircraft Carrier', 'United States', 32000);
INSERT INTO "ship" ("Ship_ID", "Name", "Type", "Nationality", "Tonnage") VALUES (3, 'Bismarck', 'Battleship', 'Germany', 41700);
INSERT INTO "ship" ("Ship_ID", "Name", "Type", "Nationality", "Tonnage") VALUES (4, 'Hood', 'Battlecruiser', 'United Kingdom', 47430);
INSERT INTO "ship" ("Ship_ID", "Name", "Type", "Nationality", "Tonnage") VALUES (5, 'Missouri', 'Battleship', 'United States', 45000);
INSERT INTO "mission" ("Mission_ID", "Ship_ID", "Code", "Launched_Year", "Location", "Speed_knots", "Fate") VALUES (101, 1, 'M-01', 1941, 'Pacific', 27, 'Sunk');
INSERT INTO "mission" ("Mission_ID", "Ship_ID", "Code", "Launched_Year", "Location", "Speed_knots", "Fate") VALUES (102, 2, 'M-02', 1942, 'Midway', 32, 'Survived');
INSERT INTO "mission" ("Mission_ID", "Ship_ID", "Code", "Launched_Year", "Location", "Speed_knots", "Fate") VALUES (103, 3, 'M-03', 1941, 'Atlantic', 30, 'Sunk');
INSERT INTO "mission" ("Mission_ID", "Ship_ID", "Code", "Launched_Year", "Location", "Speed_knots", "Fate") VALUES (104, 4, 'M-04', 1941, 'Denmark Strait', 31, 'Sunk');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "ship" WHERE ("nationality" <> 'United States') ORDER BY name, ship.ship_id NULLS LAST;

/*
Gold Result:
('Bismarck',)
('Hood',)
('Yamato',)
*/

-- Prediction Query
SELECT Name FROM ship WHERE Nationality <> 'United States';

/*
Prediction Result:
('Yamato',)
('Bismarck',)
('Hood',)
*/