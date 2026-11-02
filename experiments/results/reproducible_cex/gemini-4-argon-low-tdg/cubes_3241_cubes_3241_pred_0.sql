-- Schema DDL
CREATE TABLE "mission" ("Mission_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Code" TEXT, "Launched_Year" INTEGER, "Location" TEXT, "Speed_knots" INTEGER, "Fate" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "ship" ("Ship_ID"));

CREATE TABLE "ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Nationality" TEXT, "Tonnage" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests ORDER BY hierarchy (code ASC NULLS FIRST, fate ASC NULLS LAST, name ASC NULLS LAST).
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (1, 'Alpha', 'Destroyer', 'UK', 5000);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (2, 'Bravo', 'Cruiser', 'USA', 10000);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (3, NULL, 'Submarine', 'USSR', 2000);
INSERT INTO mission (Mission_ID, Ship_ID, Code, Launched_Year, Location, Speed_knots, Fate) VALUES (10, 1, 'C1', 1950, 'Sea', 25, 'Active');
INSERT INTO mission (Mission_ID, Ship_ID, Code, Launched_Year, Location, Speed_knots, Fate) VALUES (11, 2, 'C1', 1950, 'Sea', 25, 'Active');
INSERT INTO mission (Mission_ID, Ship_ID, Code, Launched_Year, Location, Speed_knots, Fate) VALUES (12, 3, 'C1', 1950, 'Sea', 25, 'Active');
INSERT INTO mission (Mission_ID, Ship_ID, Code, Launched_Year, Location, Speed_knots, Fate) VALUES (13, 1, 'C1', 1950, 'Sea', 25, 'Retired');
INSERT INTO mission (Mission_ID, Ship_ID, Code, Launched_Year, Location, Speed_knots, Fate) VALUES (14, 1, 'C1', 1950, 'Sea', 25, NULL);
INSERT INTO mission (Mission_ID, Ship_ID, Code, Launched_Year, Location, Speed_knots, Fate) VALUES (15, 2, 'C2', 1960, 'Ocean', 30, 'Active');
INSERT INTO mission (Mission_ID, Ship_ID, Code, Launched_Year, Location, Speed_knots, Fate) VALUES (16, 1, NULL, 1940, 'Bay', 15, 'Sunk');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT code, fate, name FROM (SELECT LHS.mission_id AS mission_id, LHS.ship_id AS ship_id, LHS.code AS code, LHS.launched_year AS launched_year, LHS.location AS LOCATION, LHS.speed_knots AS speed_knots, LHS.fate AS fate, RHS.name AS name, RHS.type AS TYPE, RHS.nationality AS nationality, RHS.tonnage AS tonnage FROM mission AS LHS INNER JOIN ship AS RHS ON (LHS.ship_id = RHS.ship_id)) ORDER BY code, fate NULLS LAST, name NULLS LAST;

/*
Gold Result:
(None, 'Sunk', 'Alpha')
('C1', 'Active', 'Alpha')
('C1', 'Active', 'Bravo')
('C1', 'Active', None)
('C1', 'Retired', 'Alpha')
('C1', None, 'Alpha')
('C2', 'Active', 'Bravo')
*/

-- Prediction Query
SELECT T1.Code, T1.Fate, T2.Name FROM mission AS T1 JOIN ship AS T2 ON T1.Ship_ID = T2.Ship_ID;

/*
Prediction Result:
('C1', 'Active', 'Alpha')
('C1', 'Active', 'Bravo')
('C1', 'Active', None)
('C1', 'Retired', 'Alpha')
('C1', None, 'Alpha')
('C2', 'Active', 'Bravo')
(None, 'Sunk', 'Alpha')
*/