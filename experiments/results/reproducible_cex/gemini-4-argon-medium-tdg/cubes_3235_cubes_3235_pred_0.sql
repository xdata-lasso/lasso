-- Schema DDL
CREATE TABLE "mission" ("Mission_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Code" TEXT, "Launched_Year" INTEGER, "Location" TEXT, "Speed_knots" INTEGER, "Fate" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "ship" ("Ship_ID"));

CREATE TABLE "ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Nationality" TEXT, "Tonnage" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (1, 'Ship A', 'Destroyer', 'USA', 3999);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (2, 'Ship B', 'Cruiser', 'UK', 4000);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (3, 'Ship C', 'Frigate', 'France', 4001);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (4, 'Ship D', 'Submarine', 'Germany', 5999);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (5, 'Ship E', 'Corvette', 'Italy', 6000);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (6, 'Ship F', 'Battleship', 'Japan', 6001);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (7, 'Ship G', 'Carrier', 'USA', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT TYPE FROM ship WHERE (tonnage > 6000 OR tonnage = 4000) ORDER BY TYPE, ship.ship_id NULLS LAST;

/*
Gold Result:
('Battleship',)
('Cruiser',)
*/

-- Prediction Query
SELECT TYPE FROM ship WHERE Tonnage > 6000 INTERSECT SELECT TYPE FROM ship WHERE Tonnage < 4000;

/*
Prediction Result:
*/