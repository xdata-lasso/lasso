-- Schema DDL
CREATE TABLE "mission" ("Mission_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Code" TEXT, "Launched_Year" INTEGER, "Location" TEXT, "Speed_knots" INTEGER, "Fate" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "ship" ("Ship_ID"));

CREATE TABLE "ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Nationality" TEXT, "Tonnage" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (1, 'Zulu', 'Destroyer', 'UK', 5000);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (2, 'Alpha', 'Cruiser', 'US', 8000);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (3, 'Bravo', 'Frigate', 'France', 3500);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (4, 'Alpha', 'Battleship', 'UK', 12000);
INSERT INTO mission (Mission_ID, Ship_ID, Code, Launched_Year, Location, Speed_knots, Fate) VALUES (101, 2, 'M-01', 1995, 'Atlantic', 25, 'Active');
INSERT INTO mission (Mission_ID, Ship_ID, Code, Launched_Year, Location, Speed_knots, Fate) VALUES (102, 2, 'M-02', 1998, 'Pacific', 28, 'Active');
INSERT INTO mission (Mission_ID, Ship_ID, Code, Launched_Year, Location, Speed_knots, Fate) VALUES (103, 3, 'M-03', 2001, 'Mediterranean', 22, 'Retired');
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
('Bravo',)
('Zulu',)
('Alpha',)
('Alpha',)
*/