-- Schema DDL
CREATE TABLE "mission" ("Mission_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Code" TEXT, "Launched_Year" INTEGER, "Location" TEXT, "Speed_knots" INTEGER, "Fate" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "ship" ("Ship_ID"));

CREATE TABLE "ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Nationality" TEXT, "Tonnage" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "ship" ("ship_id", "name", "type", "nationality", "tonnage") VALUES (1006, 'Kevin Pacheco', 'mouth', 'Italy', 1007);
INSERT INTO "ship" ("ship_id", "name", "type", "nationality", "tonnage") VALUES (1008, 'Allen Robinson', 'offer', 'Netherlands', 1008);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM ship ORDER BY name, ship.ship_id NULLS LAST;

/*
Gold Result:
('Allen Robinson',)
('Kevin Pacheco',)
*/

-- Prediction Query
SELECT Name FROM ship ORDER BY Tonnage ASC, ship.ship_id NULLS LAST;

/*
Prediction Result:
('Kevin Pacheco',)
('Allen Robinson',)
*/