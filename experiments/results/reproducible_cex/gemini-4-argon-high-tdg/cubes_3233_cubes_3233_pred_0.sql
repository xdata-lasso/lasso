-- Schema DDL
CREATE TABLE "mission" ("Mission_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Code" TEXT, "Launched_Year" INTEGER, "Location" TEXT, "Speed_knots" INTEGER, "Fate" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "ship" ("Ship_ID"));

CREATE TABLE "ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Nationality" TEXT, "Tonnage" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (1, 'Zulu', 'Destroyer', 'UK', 1000);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (2, 'Yankee', 'Cruiser', 'US', 2000);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (3, 'Xray', 'Battleship', 'FR', 3000);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (4, 'Whiskey', 'Submarine', 'DE', 4000);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (5, 'Victor', 'Carrier', 'JP', 5000);
INSERT INTO mission (Mission_ID, Ship_ID, Code, Launched_Year, Location, Speed_knots, Fate) VALUES (1, 1, 'C1', 1920, 'Atlantic', 10, 'Retired');
INSERT INTO mission (Mission_ID, Ship_ID, Code, Launched_Year, Location, Speed_knots, Fate) VALUES (2, 2, 'C2', 1927, 'Pacific', 15, 'Sunk');
INSERT INTO mission (Mission_ID, Ship_ID, Code, Launched_Year, Location, Speed_knots, Fate) VALUES (3, 3, 'C3', 1928, 'Arctic', 20, 'Active');
INSERT INTO mission (Mission_ID, Ship_ID, Code, Launched_Year, Location, Speed_knots, Fate) VALUES (4, 4, 'C4', 1929, 'Indian', 25, 'Scrapped');
INSERT INTO mission (Mission_ID, Ship_ID, Code, Launched_Year, Location, Speed_knots, Fate) VALUES (5, 5, 'C5', 1945, 'Baltic', 30, 'Museum');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.mission_id AS mission_id, LHS.ship_id AS ship_id, LHS.code AS code, LHS.launched_year AS launched_year, LHS.location AS LOCATION, LHS.speed_knots AS speed_knots, LHS.fate AS fate, LHS.name AS name, LHS.type AS TYPE, LHS.nationality AS nationality, LHS.tonnage AS tonnage FROM (SELECT LHS.mission_id AS mission_id, LHS.ship_id AS ship_id, LHS.code AS code, LHS.launched_year AS launched_year, LHS.location AS LOCATION, LHS.speed_knots AS speed_knots, LHS.fate AS fate, RHS.name AS name, RHS.type AS TYPE, RHS.nationality AS nationality, RHS.tonnage AS tonnage FROM mission AS LHS INNER JOIN ship AS RHS ON (LHS.ship_id = RHS.ship_id)) AS LHS INNER JOIN (SELECT * FROM mission WHERE (launched_year >= 1928)) AS RHS ON (LHS.mission_id = RHS.mission_id AND LHS.ship_id = RHS.ship_id AND LHS.code = RHS.code AND LHS.launched_year = RHS.launched_year AND LHS.location = RHS.location AND LHS.speed_knots = RHS.speed_knots AND LHS.fate = RHS.fate)) ORDER BY name;

/*
Gold Result:
('Victor',)
('Whiskey',)
('Xray',)
*/

-- Prediction Query
SELECT T2.Name FROM mission AS T1 JOIN ship AS T2 ON T1.Ship_ID = T2.Ship_ID WHERE T1.Launched_Year > 1928;

/*
Prediction Result:
('Whiskey',)
('Victor',)
*/