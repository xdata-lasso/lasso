-- Schema DDL
CREATE TABLE "mission" ("Mission_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Code" TEXT, "Launched_Year" INTEGER, "Location" TEXT, "Speed_knots" INTEGER, "Fate" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "ship" ("Ship_ID"));

CREATE TABLE "ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Nationality" TEXT, "Tonnage" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (1, 'Zulu', 'Destroyer', 'USA', 2000);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (2, 'Alpha', 'Submarine', 'UK', 5000);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (3, 'Alpha', 'Cruiser', 'France', 1000);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (4, 'Bravo', 'Carrier', 'USA', 8000);
INSERT INTO mission (Mission_ID, Ship_ID, Code, Launched_Year, Location, Speed_knots, Fate) VALUES (1, 1, 'M1', 1940, 'Pacific', 25, 'Sunk');
INSERT INTO mission (Mission_ID, Ship_ID, Code, Launched_Year, Location, Speed_knots, Fate) VALUES (2, 1, 'M2', 1941, 'Atlantic', 20, 'Survived');
INSERT INTO mission (Mission_ID, Ship_ID, Code, Launched_Year, Location, Speed_knots, Fate) VALUES (3, 2, 'M3', 1942, 'Mediterranean', 15, 'Survived');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM ship ORDER BY name, ship.ship_id NULLS LAST;

/*
Gold Result:
('Alpha',)
('Alpha',)
('Bravo',)
('Zulu',)
*/

-- Prediction Query
SELECT Name FROM ship ORDER BY Tonnage ASC, ship.ship_id NULLS LAST;

/*
Prediction Result:
('Alpha',)
('Zulu',)
('Alpha',)
('Bravo',)
*/