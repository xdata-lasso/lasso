-- Schema DDL
CREATE TABLE "mission" ("Mission_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Code" TEXT, "Launched_Year" INTEGER, "Location" TEXT, "Speed_knots" INTEGER, "Fate" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "ship" ("Ship_ID"));

CREATE TABLE "ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Nationality" TEXT, "Tonnage" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (1, 'Enterprise', 'Destroyer', 'USA', 5000);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (2, 'Nimitz', 'Destroyer', 'USA', 6000);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (4, 'Langley', 'Carrier', 'USA', 8000);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (3, 'Surcouf', 'Submarine', 'France', 3000);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (5, 'Redoutable', 'Submarine', 'France', 3500);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (6, 'Triomphant', 'Submarine', 'France', 4000);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (10, 'Hood', 'Cruiser', 'UK', 7000);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (11, 'Belfast', 'Cruiser', 'UK', 7100);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (12, 'Exeter', 'Cruiser', 'UK', 7200);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (13, 'Ajax', 'Cruiser', 'UK', 7300);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (14, 'Achilles', 'Cruiser', 'UK', 7400);
INSERT INTO mission (Mission_ID, Ship_ID, Code, Launched_Year, Location, Speed_knots, Fate) VALUES (101, 1, 'M-Alpha', 1990, 'Pacific', 30, 'Active');
INSERT INTO mission (Mission_ID, Ship_ID, Code, Launched_Year, Location, Speed_knots, Fate) VALUES (102, 3, 'M-Beta', 1995, 'Atlantic', 25, 'Retired');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT nationality FROM (SELECT LHS.nationality AS nationality, LHS.type AS TYPE, LHS.n AS n, RHS.name AS name, RHS.type AS type_other, RHS.tonnage AS tonnage FROM (SELECT nationality, TYPE, COUNT(*) AS n FROM ship GROUP BY nationality, TYPE) AS LHS INNER JOIN ship AS RHS ON (LHS.n = RHS.ship_id AND LHS.nationality = RHS.nationality)) ORDER BY nationality;

/*
Gold Result:
('France',)
('USA',)
('USA',)
*/

-- Prediction Query
SELECT Nationality FROM ship GROUP BY Nationality HAVING COUNT(*) > 2;

/*
Prediction Result:
('France',)
('UK',)
('USA',)
*/