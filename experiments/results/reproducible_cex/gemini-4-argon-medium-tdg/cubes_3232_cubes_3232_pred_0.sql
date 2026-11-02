-- Schema DDL
CREATE TABLE "mission" ("Mission_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Code" TEXT, "Launched_Year" INTEGER, "Location" TEXT, "Speed_knots" INTEGER, "Fate" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "ship" ("Ship_ID"));

CREATE TABLE "ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Nationality" TEXT, "Tonnage" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "ship" ("Ship_ID", "Name", "Type", "Nationality", "Tonnage") VALUES (1, 'Enterprise', 'Carrier', 'United States', 80000);
INSERT INTO "ship" ("Ship_ID", "Name", "Type", "Nationality", "Tonnage") VALUES (2, 'Victory', 'Battleship', 'United Kingdom', 35000);
INSERT INTO "ship" ("Ship_ID", "Name", "Type", "Nationality", "Tonnage") VALUES (3, 'Bismarck', 'Battleship', 'Germany', 41000);
INSERT INTO "ship" ("Ship_ID", "Name", "Type", "Nationality", "Tonnage") VALUES (4, 'Yamato', 'Battleship', 'Venezuela', 65000);
INSERT INTO "mission" ("Mission_ID", "Ship_ID", "Code", "Launched_Year", "Location", "Speed_knots", "Fate") VALUES (101, 2, 'M-01', 1940, 'Atlantic', 25, 'Survived');
INSERT INTO "mission" ("Mission_ID", "Ship_ID", "Code", "Launched_Year", "Location", "Speed_knots", "Fate") VALUES (102, 2, 'M-02', 1942, 'Pacific', 24, 'Survived');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "ship" WHERE ("nationality" <> 'United States') ORDER BY name, ship.ship_id NULLS LAST;

/*
Gold Result:
('Bismarck',)
('Victory',)
('Yamato',)
*/

-- Prediction Query
SELECT Name FROM ship WHERE Nationality <> 'United States';

/*
Prediction Result:
('Victory',)
('Bismarck',)
('Yamato',)
*/