-- Schema DDL
CREATE TABLE "mission" ("Mission_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Code" TEXT, "Launched_Year" INTEGER, "Location" TEXT, "Speed_knots" INTEGER, "Fate" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "ship" ("Ship_ID"));

CREATE TABLE "ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Nationality" TEXT, "Tonnage" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (1, 'Zebra', 'Destroyer', 'USA', 5000);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (2, 'Alpha', 'Destroyer', 'France', 1000);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (3, 'Beta', 'Battleship', 'UK', 40000);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (4, 'Gamma', 'Cargo', 'Panama', 8000);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (5, 'Delta', 'Cargo', 'Panama', 9000);
INSERT INTO mission (Mission_ID, Ship_ID, Code, Launched_Year, Location, Speed_knots, Fate) VALUES (101, 1, 'M-01', 1942, 'Atlantic', 30, 'Survived');
INSERT INTO mission (Mission_ID, Ship_ID, Code, Launched_Year, Location, Speed_knots, Fate) VALUES (102, 1, 'M-02', 1944, 'Pacific', 28, 'Survived');
INSERT INTO mission (Mission_ID, Ship_ID, Code, Launched_Year, Location, Speed_knots, Fate) VALUES (103, 3, 'M-03', 1941, 'North Sea', 25, 'Sunk');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT TYPE, nationality FROM ship ORDER BY TYPE, ship.ship_id NULLS LAST;

/*
Gold Result:
('Battleship', 'UK')
('Cargo', 'Panama')
('Cargo', 'Panama')
('Destroyer', 'USA')
('Destroyer', 'France')
*/

-- Prediction Query
SELECT TYPE, Nationality FROM ship;

/*
Prediction Result:
('Destroyer', 'USA')
('Destroyer', 'France')
('Battleship', 'UK')
('Cargo', 'Panama')
('Cargo', 'Panama')
*/