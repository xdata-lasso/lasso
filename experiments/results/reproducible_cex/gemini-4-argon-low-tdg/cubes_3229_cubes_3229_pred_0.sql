-- Schema DDL
CREATE TABLE "mission" ("Mission_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Code" TEXT, "Launched_Year" INTEGER, "Location" TEXT, "Speed_knots" INTEGER, "Fate" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "ship" ("Ship_ID"));

CREATE TABLE "ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Nationality" TEXT, "Tonnage" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (2, 'ShipA', 'Submarine', 'US', 2000);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (5, 'ShipB', 'Submarine', 'US', 2000);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (3, 'ShipC', 'Destroyer', 'UK', 4000);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (6, 'ShipD', 'Destroyer', 'UK', 4500);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (1, 'ShipE', 'Cruiser', 'France', 6000);
INSERT INTO mission (Mission_ID, Ship_ID, Code, Launched_Year, Location, Speed_knots, Fate) VALUES (1, 2, 'Alpha', 2000, 'Pacific', 25, 'Sunk');
INSERT INTO mission (Mission_ID, Ship_ID, Code, Launched_Year, Location, Speed_knots, Fate) VALUES (2, 2, 'Beta', 2001, 'Pacific', 25, 'Active');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT nationality FROM (SELECT LHS.nationality AS nationality, LHS.type AS TYPE, LHS.n AS n, RHS.name AS name, RHS.type AS type_other, RHS.tonnage AS tonnage FROM (SELECT nationality, TYPE, COUNT(*) AS n FROM ship GROUP BY nationality, TYPE) AS LHS INNER JOIN ship AS RHS ON (LHS.n = RHS.ship_id AND LHS.nationality = RHS.nationality)) ORDER BY nationality;

/*
Gold Result:
('France',)
('US',)
*/

-- Prediction Query
SELECT Nationality FROM ship GROUP BY Nationality HAVING COUNT(*) > 2;

/*
Prediction Result:
*/