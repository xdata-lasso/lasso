-- Schema DDL
CREATE TABLE "mission" ("Mission_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Code" TEXT, "Launched_Year" INTEGER, "Location" TEXT, "Speed_knots" INTEGER, "Fate" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "ship" ("Ship_ID"));

CREATE TABLE "ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Nationality" TEXT, "Tonnage" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO ship (ship_id, name, type, nationality, tonnage) VALUES (0, NULL, NULL, NULL, NULL), (1, 'default2', NULL, 'default1', NULL), (2, NULL, 'default1', 'default2', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM ship ORDER BY name, ship.ship_id NULLS LAST;

/*
Gold Result:
(None,)
(None,)
('default2',)
*/

-- Prediction Query
SELECT Name FROM ship ORDER BY Tonnage ASC, ship.ship_id NULLS LAST;

/*
Prediction Result:
(None,)
('default2',)
(None,)
*/