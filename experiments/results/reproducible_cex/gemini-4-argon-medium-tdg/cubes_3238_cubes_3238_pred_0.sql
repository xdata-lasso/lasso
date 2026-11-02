-- Schema DDL
CREATE TABLE "mission" ("Mission_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Code" TEXT, "Launched_Year" INTEGER, "Location" TEXT, "Speed_knots" INTEGER, "Fate" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "ship" ("Ship_ID"));

CREATE TABLE "ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Nationality" TEXT, "Tonnage" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (1, 'Zulu', 'Cargo', 'UK', 5000);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (2, 'Alpha', 'Destroyer', 'US', 3000);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (3, 'Alpha', 'Frigate', 'US', 2000);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (4, 'Bravo', 'Submarine', 'UK', 1500);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (5, 'Charlie', 'Cruiser', 'FR', 4000);
INSERT INTO mission (Mission_ID, Ship_ID, Code, Launched_Year, Location, Speed_knots, Fate) VALUES (10, 4, 'M1', 1990, 'Atlantic', 20, 'Active');
INSERT INTO mission (Mission_ID, Ship_ID, Code, Launched_Year, Location, Speed_knots, Fate) VALUES (11, 5, 'M2', 1995, 'Pacific', 25, 'Sunk');
INSERT INTO mission (Mission_ID, Ship_ID, Code, Launched_Year, Location, Speed_knots, Fate) VALUES (12, 5, 'M3', 1996, 'Indian', 22, 'Retired');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM ship AS LHS WHERE NOT EXISTS(SELECT 1 FROM mission AS RHS WHERE (LHS.ship_id = RHS.ship_id))) ORDER BY name;

/*
Gold Result:
('Alpha',)
('Alpha',)
('Zulu',)
*/

-- Prediction Query
SELECT Name FROM ship WHERE NOT Ship_ID IN (SELECT Ship_ID FROM mission);

/*
Prediction Result:
('Zulu',)
('Alpha',)
('Alpha',)
*/