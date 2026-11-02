-- Schema DDL
CREATE TABLE "mission" ("Mission_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Code" TEXT, "Launched_Year" INTEGER, "Location" TEXT, "Speed_knots" INTEGER, "Fate" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "ship" ("Ship_ID"));

CREATE TABLE "ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Nationality" TEXT, "Tonnage" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "ship" ("ship_id", "name", "type", "nationality", "tonnage") VALUES (1012, 'Timothy Watts', 'discuss', 'Poland', 1013);
INSERT INTO "mission" ("mission_id", "ship_id", "code", "launched_year", "location", "speed_knots", "fate") VALUES (1014, 1012, 'garden', 1928, '05641 Robin Port
Jasonfort, MO 84760', 1015, 'low');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.mission_id AS mission_id, LHS.ship_id AS ship_id, LHS.code AS code, LHS.launched_year AS launched_year, LHS.location AS LOCATION, LHS.speed_knots AS speed_knots, LHS.fate AS fate, LHS.name AS name, LHS.type AS TYPE, LHS.nationality AS nationality, LHS.tonnage AS tonnage FROM (SELECT LHS.mission_id AS mission_id, LHS.ship_id AS ship_id, LHS.code AS code, LHS.launched_year AS launched_year, LHS.location AS LOCATION, LHS.speed_knots AS speed_knots, LHS.fate AS fate, RHS.name AS name, RHS.type AS TYPE, RHS.nationality AS nationality, RHS.tonnage AS tonnage FROM mission AS LHS INNER JOIN ship AS RHS ON (LHS.ship_id = RHS.ship_id)) AS LHS INNER JOIN (SELECT * FROM mission WHERE (launched_year >= 1928)) AS RHS ON (LHS.mission_id = RHS.mission_id AND LHS.ship_id = RHS.ship_id AND LHS.code = RHS.code AND LHS.launched_year = RHS.launched_year AND LHS.location = RHS.location AND LHS.speed_knots = RHS.speed_knots AND LHS.fate = RHS.fate)) ORDER BY name;

/*
Gold Result:
('Timothy Watts',)
*/

-- Prediction Query
SELECT T2.Name FROM mission AS T1 JOIN ship AS T2 ON T1.Ship_ID = T2.Ship_ID WHERE T1.Launched_Year > 1928;

/*
Prediction Result:
*/