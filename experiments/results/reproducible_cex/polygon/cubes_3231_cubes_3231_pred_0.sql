-- Schema DDL
CREATE TABLE "mission" ("Mission_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Code" TEXT, "Launched_Year" INTEGER, "Location" TEXT, "Speed_knots" INTEGER, "Fate" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "ship" ("Ship_ID"));

CREATE TABLE "ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Nationality" TEXT, "Tonnage" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "mission" ("mission_id", "ship_id", "code", "launched_year", "location", "speed_knots", "fate") VALUES (7, 8, 'United Kingdom15', 15, 'United Kingdom15', 15, 'United Kingdom15');
INSERT INTO "mission" ("mission_id", "ship_id", "code", "launched_year", "location", "speed_knots", "fate") VALUES (6, 9, 'United Kingdom15', 15, 'United Kingdom15', 15, 'United Kingdom15');
INSERT INTO "ship" ("ship_id", "name", "type", "nationality", "tonnage") VALUES (8, 'United Kingdom15', NULL, 'United States10', NULL);
INSERT INTO "ship" ("ship_id", "name", "type", "nationality", "tonnage") VALUES (9, 'United Kingdom15', 'United Kingdom13', 'United Kingdom', 14);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "ship" WHERE ("nationality" <> 'United States' OR "nationality" <> 'United Kingdom') ORDER BY name, ship.ship_id NULLS LAST;

/*
Gold Result:
('United Kingdom15',)
('United Kingdom15',)
*/

-- Prediction Query
SELECT Name FROM ship WHERE Nationality = 'United States' OR Nationality = 'United Kingdom';

/*
Prediction Result:
('United Kingdom15',)
*/