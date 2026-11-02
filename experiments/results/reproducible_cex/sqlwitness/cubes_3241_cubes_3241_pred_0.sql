-- Schema DDL
CREATE TABLE "mission" ("Mission_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Code" TEXT, "Launched_Year" INTEGER, "Location" TEXT, "Speed_knots" INTEGER, "Fate" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "ship" ("Ship_ID"));

CREATE TABLE "ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Nationality" TEXT, "Tonnage" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO ship (ship_id, name, type, nationality, tonnage) VALUES (0, 'default2', 'default2', 'default1', 1), (1, 'default2', 'default1', 'default2', 0), (2, 'default2', 'default1', 'default2', 0), (3, NULL, 'default2', 'default1', NULL);
INSERT INTO mission (mission_id, ship_id, code, launched_year, location, speed_knots, fate) VALUES (0, 3, 'default1', 0, 'default2', NULL, 'default2'), (1, 1, 'default1', 0, 'default2', 0, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT code, fate, name FROM (SELECT LHS.mission_id AS mission_id, LHS.ship_id AS ship_id, LHS.code AS code, LHS.launched_year AS launched_year, LHS.location AS LOCATION, LHS.speed_knots AS speed_knots, LHS.fate AS fate, RHS.name AS name, RHS.type AS TYPE, RHS.nationality AS nationality, RHS.tonnage AS tonnage FROM mission AS LHS INNER JOIN ship AS RHS ON (LHS.ship_id = RHS.ship_id)) ORDER BY code, fate NULLS LAST, name NULLS LAST;

/*
Gold Result:
('default1', 'default2', 'default2')
('default1', 'default2', None)
*/

-- Prediction Query
SELECT T1.Code, T1.Fate, T2.Name FROM mission AS T1 JOIN ship AS T2 ON T1.Ship_ID = T2.Ship_ID;

/*
Prediction Result:
('default1', 'default2', None)
('default1', 'default2', 'default2')
*/