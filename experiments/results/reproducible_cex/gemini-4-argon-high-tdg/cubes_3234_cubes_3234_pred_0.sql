-- Schema DDL
CREATE TABLE "mission" ("Mission_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Code" TEXT, "Launched_Year" INTEGER, "Location" TEXT, "Speed_knots" INTEGER, "Fate" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "ship" ("Ship_ID"));

CREATE TABLE "ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Nationality" TEXT, "Tonnage" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (1, 'USS Nautilus', 'Submarine', 'US', 3500);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (20, 'USS Gato', 'Submarine', 'US', 1500);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (21, 'USS Balao', 'Submarine', 'US', 1800);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (2, 'HMS Ark Royal', 'Carrier', 'UK', 22000);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (10, 'HMS Defender', 'Destroyer', 'UK', 8000);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (11, 'HMS Daring', 'Destroyer', 'UK', 8000);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (3, 'Lafayette', 'Frigate', 'FR', 3600);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (30, 'Forbin', 'Destroyer', 'FR', 7000);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (31, 'Chevalier Paul', 'Destroyer', 'FR', 7000);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (32, 'Cassard', 'Destroyer', 'FR', 4500);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (4, 'Bismarck', 'Battleship', 'DE', 41700);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (40, 'Tirpitz', 'Battleship', 'DE', 42900);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (41, 'Scharnhorst', 'Battleship', 'DE', 32000);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (42, 'Gneisenau', 'Battleship', 'DE', 32000);
INSERT INTO mission (Mission_ID, Ship_ID, Code, Launched_Year, Location, Speed_knots, Fate) VALUES (101, 4, 'OP-RHEIN', 1941, 'North Atlantic', 30, 'Sunk');
INSERT INTO mission (Mission_ID, Ship_ID, Code, Launched_Year, Location, Speed_knots, Fate) VALUES (102, 10, 'OP-kipion', 2014, 'Persian Gulf', 28, 'Active');
INSERT INTO mission (Mission_ID, Ship_ID, Code, Launched_Year, Location, Speed_knots, Fate) VALUES (103, 10, 'OP-SHADER', 2016, 'Mediterranean', 29, 'Active');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT TYPE FROM (SELECT LHS.nationality AS nationality, LHS.type AS TYPE, LHS.n AS n, RHS.name AS name, RHS.type AS type_other, RHS.tonnage AS tonnage FROM (SELECT nationality, TYPE, COUNT(*) AS n FROM ship GROUP BY nationality, TYPE) AS LHS INNER JOIN ship AS RHS ON (LHS.n = RHS.ship_id AND LHS.nationality = RHS.nationality)) ORDER BY TYPE;

/*
Gold Result:
('Battleship',)
('Destroyer',)
*/

-- Prediction Query
SELECT TYPE FROM ship GROUP BY TYPE ORDER BY COUNT(*) DESC, TYPE NULLS LAST LIMIT 1;

/*
Prediction Result:
('Destroyer',)
*/