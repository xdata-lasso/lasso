-- Schema DDL
CREATE TABLE "mission" ("Mission_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Code" TEXT, "Launched_Year" INTEGER, "Location" TEXT, "Speed_knots" INTEGER, "Fate" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "ship" ("Ship_ID"));

CREATE TABLE "ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Nationality" TEXT, "Tonnage" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "ship" ("ship_id", "name", "type", "nationality", "tonnage") VALUES (1026, 'Dylan Miller', 'early', 'Tonga', 1027);
INSERT INTO "ship" ("ship_id", "name", "type", "nationality", "tonnage") VALUES (1028, 'Daniel Adams', 'his', 'Central African Republic', 1028);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "ship" WHERE ("nationality" <> 'United States') ORDER BY name, ship.ship_id NULLS LAST;

/*
Gold Result:
('Daniel Adams',)
('Dylan Miller',)
*/

-- Prediction Query
SELECT Name FROM ship WHERE Nationality <> 'United States';

/*
Prediction Result:
('Dylan Miller',)
('Daniel Adams',)
*/