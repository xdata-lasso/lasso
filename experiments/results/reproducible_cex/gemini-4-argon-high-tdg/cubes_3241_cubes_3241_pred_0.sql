-- Schema DDL
CREATE TABLE "mission" ("Mission_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Code" TEXT, "Launched_Year" INTEGER, "Location" TEXT, "Speed_knots" INTEGER, "Fate" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "ship" ("Ship_ID"));

CREATE TABLE "ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Nationality" TEXT, "Tonnage" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (10, 'Alpha', 'Destroyer', 'USA', 5000);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (20, 'Beta', 'Cruiser', 'UK', 8000);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (30, 'UnassignedShip', 'Frigate', 'France', 3500);
INSERT INTO mission (Mission_ID, Ship_ID, Code, Launched_Year, Location, Speed_knots, Fate) VALUES (1, 10, 'M1', 1942, 'Pacific', 30, 'Sunk');
INSERT INTO mission (Mission_ID, Ship_ID, Code, Launched_Year, Location, Speed_knots, Fate) VALUES (10, 20, 'M2', 1943, 'Atlantic', 28, 'Active');
INSERT INTO mission (Mission_ID, Ship_ID, Code, Launched_Year, Location, Speed_knots, Fate) VALUES (3, NULL, 'M3', 1944, 'Arctic', 20, 'Lost');
INSERT INTO mission (Mission_ID, Ship_ID, Code, Launched_Year, Location, Speed_knots, Fate) VALUES (4, 10, 'M4', 1941, 'Mediterranean', 32, 'Returned');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT code, fate, name FROM (SELECT LHS.mission_id AS mission_id, LHS.ship_id AS ship_id, LHS.code AS code, LHS.launched_year AS launched_year, LHS.location AS LOCATION, LHS.speed_knots AS speed_knots, LHS.fate AS fate, RHS.name AS name, RHS.type AS TYPE, RHS.nationality AS nationality, RHS.tonnage AS tonnage FROM mission AS LHS INNER JOIN ship AS RHS ON (LHS.ship_id = RHS.ship_id)) ORDER BY code, fate NULLS LAST, name NULLS LAST;

/*
Gold Result:
('M1', 'Sunk', 'Alpha')
('M2', 'Active', 'Beta')
('M4', 'Returned', 'Alpha')
*/

-- Prediction Query
SELECT T1.Code, T1.Fate, T2.Name FROM mission AS T1 JOIN ship AS T2 ON T1.Ship_ID = T2.Ship_ID;

/*
Prediction Result:
('M1', 'Sunk', 'Alpha')
('M4', 'Returned', 'Alpha')
('M2', 'Active', 'Beta')
*/