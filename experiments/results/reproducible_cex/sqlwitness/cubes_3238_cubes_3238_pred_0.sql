-- Schema DDL
CREATE TABLE "mission" ("Mission_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Code" TEXT, "Launched_Year" INTEGER, "Location" TEXT, "Speed_knots" INTEGER, "Fate" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "ship" ("Ship_ID"));

CREATE TABLE "ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Nationality" TEXT, "Tonnage" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO ship (ship_id, name, type, nationality, tonnage) VALUES (0, 'default2', NULL, 'default1', 1);
INSERT INTO mission (mission_id, ship_id, code, launched_year, location, speed_knots, fate) VALUES (1, NULL, 'default1', 2, NULL, 1, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM ship AS LHS WHERE NOT EXISTS(SELECT 1 FROM mission AS RHS WHERE (LHS.ship_id = RHS.ship_id))) ORDER BY name;

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT Name FROM ship WHERE NOT Ship_ID IN (SELECT Ship_ID FROM mission);

/*
Prediction Result:
*/