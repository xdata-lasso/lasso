-- Schema DDL
CREATE TABLE "mission" ("Mission_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Code" TEXT, "Launched_Year" INTEGER, "Location" TEXT, "Speed_knots" INTEGER, "Fate" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "ship" ("Ship_ID"));

CREATE TABLE "ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Nationality" TEXT, "Tonnage" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (1, 'HMS Daring', 'Destroyer', 'UK', 1000);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (2, 'HMS Dauntless', 'Destroyer', 'UK', 1000);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (3, 'SS Liberty', 'Cargo', 'US', 500);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (4, 'SS Victory', 'Cargo', 'US', 500);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (5, 'FS Surcouf', 'Frigate', 'FR', 9000);
INSERT INTO mission (Mission_ID, Ship_ID, Code, Launched_Year, Location, Speed_knots, Fate) VALUES (101, 5, 'M-01', 2001, 'Atlantic', 25, 'Completed');
INSERT INTO mission (Mission_ID, Ship_ID, Code, Launched_Year, Location, Speed_knots, Fate) VALUES (102, 5, 'M-02', 2002, 'Pacific', 24, 'Completed');
INSERT INTO mission (Mission_ID, Ship_ID, Code, Launched_Year, Location, Speed_knots, Fate) VALUES (103, 5, 'M-03', 2003, 'Indian', 26, 'Active');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT TYPE FROM (SELECT LHS.n AS n, RHS.type AS TYPE FROM (SELECT MAX(n) AS n FROM (SELECT TYPE, COUNT(*) AS n FROM ship GROUP BY TYPE)) AS LHS LEFT JOIN (SELECT TYPE, COUNT(*) AS n FROM ship GROUP BY TYPE) AS RHS ON (LHS.n = RHS.n)) ORDER BY TYPE;

/*
Gold Result:
('Cargo',)
('Destroyer',)
*/

-- Prediction Query
SELECT TYPE FROM ship GROUP BY TYPE ORDER BY COUNT(*) DESC, TYPE NULLS LAST LIMIT 1;

/*
Prediction Result:
('Cargo',)
*/