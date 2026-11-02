-- Schema DDL
CREATE TABLE "mission" ("Mission_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Code" TEXT, "Launched_Year" INTEGER, "Location" TEXT, "Speed_knots" INTEGER, "Fate" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "ship" ("Ship_ID"));

CREATE TABLE "ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Nationality" TEXT, "Tonnage" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "ship" ("Ship_ID", "Name", "Type", "Nationality", "Tonnage") VALUES (1, 'Ship A', 'Destroyer', 'USA', 1000);
INSERT INTO "ship" ("Ship_ID", "Name", "Type", "Nationality", "Tonnage") VALUES (2, 'Ship B', 'Battlecruiser', 'UK', 2000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT TYPE, nationality FROM ship ORDER BY TYPE, ship.ship_id NULLS LAST;

/*
Gold Result:
('Battlecruiser', 'UK')
('Destroyer', 'USA')
*/

-- Prediction Query
SELECT TYPE, Nationality FROM ship;

/*
Prediction Result:
('Destroyer', 'USA')
('Battlecruiser', 'UK')
*/