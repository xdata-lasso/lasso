-- Schema DDL
CREATE TABLE "mission" ("Mission_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Code" TEXT, "Launched_Year" INTEGER, "Location" TEXT, "Speed_knots" INTEGER, "Fate" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "ship" ("Ship_ID"));

CREATE TABLE "ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Nationality" TEXT, "Tonnage" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (1, 'Enterprise', 'Submarine', 'US', 4000);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (2, 'Nimitz', 'Carrier', 'US', 10000);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (3, 'Ford', 'Carrier', 'US', 10500);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (10, 'Victory', 'Destroyer', 'UK', 5000);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (11, 'Daring', 'Destroyer', 'UK', 5500);
INSERT INTO mission (Mission_ID, Ship_ID, Code, Launched_Year, Location, Speed_knots, Fate) VALUES (1, 1, 'M1', 1990, 'Pacific', 25, 'Returned');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT TYPE FROM (SELECT LHS.nationality AS nationality, LHS.type AS TYPE, LHS.n AS n, RHS.name AS name, RHS.type AS type_other, RHS.tonnage AS tonnage FROM (SELECT nationality, TYPE, COUNT(*) AS n FROM ship GROUP BY nationality, TYPE) AS LHS INNER JOIN ship AS RHS ON (LHS.n = RHS.ship_id AND LHS.nationality = RHS.nationality)) ORDER BY TYPE;

/*
Gold Result:
('Carrier',)
('Submarine',)
*/

-- Prediction Query
SELECT TYPE FROM ship GROUP BY TYPE ORDER BY COUNT(*) DESC, TYPE NULLS LAST LIMIT 1;

/*
Prediction Result:
('Carrier',)
*/