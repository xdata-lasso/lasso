-- Schema DDL
CREATE TABLE "mission" ("Mission_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Code" TEXT, "Launched_Year" INTEGER, "Location" TEXT, "Speed_knots" INTEGER, "Fate" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "ship" ("Ship_ID"));

CREATE TABLE "ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Nationality" TEXT, "Tonnage" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (1, 'HMS Victory', 'Destroyer', 'UK', 4000);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (2, 'USS Iowa', 'Battleship', 'USA', 6000);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (3, 'HMS Belfast', 'Cruiser', 'UK', 6001);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (4, 'USS Defiant', 'Frigate', 'USA', 3999);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (5, 'INS Vikrant', 'Corvette', 'India', 4001);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (6, 'U-96', 'Submarine', 'Germany', 5999);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (7, 'Ghost', 'Carrier', 'Unknown', NULL);
INSERT INTO mission (Mission_ID, Ship_ID, Code, Launched_Year, Location, Speed_knots, Fate) VALUES (101, 2, 'M-6000', 1943, 'Atlantic', 28, 'Active');
INSERT INTO mission (Mission_ID, Ship_ID, Code, Launched_Year, Location, Speed_knots, Fate) VALUES (102, 3, 'M-6001A', 1944, 'Arctic', 32, 'Survived');
INSERT INTO mission (Mission_ID, Ship_ID, Code, Launched_Year, Location, Speed_knots, Fate) VALUES (103, 3, 'M-6001B', 1950, 'Pacific', 30, 'Museum');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT TYPE FROM ship WHERE (tonnage > 6000 OR tonnage = 4000) ORDER BY TYPE, ship.ship_id NULLS LAST;

/*
Gold Result:
('Cruiser',)
('Destroyer',)
*/

-- Prediction Query
SELECT TYPE FROM ship WHERE Tonnage > 6000 INTERSECT SELECT TYPE FROM ship WHERE Tonnage < 4000;

/*
Prediction Result:
*/