-- Schema DDL
CREATE TABLE "mission" ("Mission_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Code" TEXT, "Launched_Year" INTEGER, "Location" TEXT, "Speed_knots" INTEGER, "Fate" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "ship" ("Ship_ID"));

CREATE TABLE "ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Nationality" TEXT, "Tonnage" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "ship" ("Ship_ID", "Name", "Type", "Nationality", "Tonnage") VALUES (1, 'A', 'Cargo', 'US', 200);
INSERT INTO "ship" ("Ship_ID", "Name", "Type", "Nationality", "Tonnage") VALUES (2, 'B', 'Cargo', 'US', 100);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM ship ORDER BY name, ship.ship_id NULLS LAST;

/*
Gold Result:
('A',)
('B',)
*/

-- Prediction Query
SELECT Name FROM ship ORDER BY Tonnage ASC, ship.ship_id NULLS LAST;

/*
Prediction Result:
('B',)
('A',)
*/