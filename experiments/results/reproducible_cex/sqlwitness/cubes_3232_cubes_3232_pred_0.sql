-- Schema DDL
CREATE TABLE "mission" ("Mission_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Code" TEXT, "Launched_Year" INTEGER, "Location" TEXT, "Speed_knots" INTEGER, "Fate" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "ship" ("Ship_ID"));

CREATE TABLE "ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Nationality" TEXT, "Tonnage" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO ship (ship_id, name, type, nationality, tonnage) VALUES (1, 'default2', 'default1', 'default2', NULL), (0, 'United States', 'default1', 'default2', 1), (2, 'United States', NULL, 'default2', NULL), (3, 'United States', NULL, 'United States', 1), (4, 'default1', 'default2', 'United States', NULL), (5, 'default2', 'United States', NULL, NULL), (6, 'default1', 'United States', 'default2', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "ship" WHERE ("nationality" <> 'United States') ORDER BY name, ship.ship_id NULLS LAST;

/*
Gold Result:
('United States',)
('United States',)
('default1',)
('default2',)
*/

-- Prediction Query
SELECT Name FROM ship WHERE Nationality <> 'United States';

/*
Prediction Result:
('United States',)
('default2',)
('United States',)
('default1',)
*/