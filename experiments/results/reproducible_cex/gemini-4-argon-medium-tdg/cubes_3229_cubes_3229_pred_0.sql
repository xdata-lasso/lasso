-- Schema DDL
CREATE TABLE "mission" ("Mission_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Code" TEXT, "Launched_Year" INTEGER, "Location" TEXT, "Speed_knots" INTEGER, "Fate" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "ship" ("Ship_ID"));

CREATE TABLE "ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Nationality" TEXT, "Tonnage" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (10, 'ShipA', 'Type1', 'Japan', 1000);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (20, 'ShipB', 'Type2', 'Japan', 2000);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (1, 'ShipC', 'Type3', 'Japan', 3000);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (30, 'ShipD', 'Type1', 'Germany', 1500);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (40, 'ShipE', 'Type1', 'Germany', 1600);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (2, 'ShipF', 'Type1', 'Italy', 1700);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT nationality FROM (SELECT LHS.nationality AS nationality, LHS.type AS TYPE, LHS.n AS n, RHS.name AS name, RHS.type AS type_other, RHS.tonnage AS tonnage FROM (SELECT nationality, TYPE, COUNT(*) AS n FROM ship GROUP BY nationality, TYPE) AS LHS INNER JOIN ship AS RHS ON (LHS.n = RHS.ship_id AND LHS.nationality = RHS.nationality)) ORDER BY nationality;

/*
Gold Result:
('Japan',)
('Japan',)
('Japan',)
*/

-- Prediction Query
SELECT Nationality FROM ship GROUP BY Nationality HAVING COUNT(*) > 2;

/*
Prediction Result:
('Japan',)
*/