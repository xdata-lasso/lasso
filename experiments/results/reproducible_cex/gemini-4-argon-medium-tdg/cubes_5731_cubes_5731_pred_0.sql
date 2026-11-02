-- Schema DDL
CREATE TABLE "mission" ("Mission_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Code" TEXT, "Launched_Year" INTEGER, "Location" TEXT, "Speed_knots" INTEGER, "Fate" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "ship" ("Ship_ID"));

CREATE TABLE "ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Nationality" TEXT, "Tonnage" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (1, 'Titan', 'Cargo', 'UK', 50000);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (2, 'Goliath', 'Tanker', 'US', 50000);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (3, 'Minnow', 'Tug', 'US', 1000);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (4, 'Ghost', 'Ferry', 'FR', NULL);
INSERT INTO mission (Mission_ID, Ship_ID, Code, Launched_Year, Location, Speed_knots, Fate) VALUES (101, 3, 'M-01', 1999, 'Atlantic', 15, 'Active');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.ship_id AS ship_id, LHS.name AS name, LHS.type AS TYPE, LHS.nationality AS nationality, LHS.tonnage AS tonnage, LHS.maxtonnage AS maxtonnage, RHS.ship_id AS ship_id_other, RHS.name AS name_other, RHS.type AS type_other, RHS.nationality AS nationality_other, RHS.tonnage AS tonnage_other, RHS.maxtonnage AS maxtonnage_other FROM (SELECT ship_id, name, TYPE, nationality, tonnage, MAX(tonnage) OVER () AS maxtonnage FROM ship) AS LHS CROSS JOIN (SELECT ship_id, name, TYPE, nationality, tonnage, MAX(tonnage) OVER () AS maxtonnage FROM ship) AS RHS) WHERE (tonnage = maxtonnage_other AND tonnage_other >= maxtonnage_other) ORDER BY name;

/*
Gold Result:
('Goliath',)
('Goliath',)
('Titan',)
('Titan',)
*/

-- Prediction Query
SELECT Name FROM ship ORDER BY Tonnage DESC, ship.ship_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Titan',)
*/