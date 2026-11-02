-- Schema DDL
CREATE TABLE "mission" ("Mission_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Code" TEXT, "Launched_Year" INTEGER, "Location" TEXT, "Speed_knots" INTEGER, "Fate" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "ship" ("Ship_ID"));

CREATE TABLE "ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Nationality" TEXT, "Tonnage" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO ship (ship_id, name, type, nationality, tonnage) VALUES (0, 'default1', 'default2', NULL, 1), (1, NULL, NULL, 'default1', 1), (2, NULL, 'default1', 'default1', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT TYPE, nationality FROM ship ORDER BY TYPE, ship.ship_id NULLS LAST;

/*
Gold Result:
(None, 'default1')
('default1', 'default1')
('default2', None)
*/

-- Prediction Query
SELECT TYPE, Nationality FROM ship;

/*
Prediction Result:
('default2', None)
(None, 'default1')
('default1', 'default1')
*/