-- Schema DDL
CREATE TABLE "mission" ("Mission_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Code" TEXT, "Launched_Year" INTEGER, "Location" TEXT, "Speed_knots" INTEGER, "Fate" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "ship" ("Ship_ID"));

CREATE TABLE "ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Nationality" TEXT, "Tonnage" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests ties for the maximum count (kills LIMIT 1 mutants) and ordering of multiple winning types (kills missing/DESC ORDER BY mutants).
-- Also includes mission records with skewed references to kill mutants that erroneously join the mission table without deduplication.
INSERT INTO "ship" ("Ship_ID", "Name", "Type", "Nationality", "Tonnage") VALUES (1, 'Alpha', 'Destroyer', 'US', 5000);
INSERT INTO "ship" ("Ship_ID", "Name", "Type", "Nationality", "Tonnage") VALUES (2, 'Beta', 'Destroyer', 'UK', 6000);
INSERT INTO "ship" ("Ship_ID", "Name", "Type", "Nationality", "Tonnage") VALUES (3, 'Gamma', 'Battleship', 'US', 50000);
INSERT INTO "ship" ("Ship_ID", "Name", "Type", "Nationality", "Tonnage") VALUES (4, 'Delta', 'Battleship', 'JP', 60000);
INSERT INTO "ship" ("Ship_ID", "Name", "Type", "Nationality", "Tonnage") VALUES (5, 'Epsilon', 'Cruiser', 'FR', 10000);
INSERT INTO "mission" ("Mission_ID", "Ship_ID", "Code", "Launched_Year", "Location", "Speed_knots", "Fate") VALUES (101, 5, 'M1', 1940, 'Atlantic', 25, 'Survived');
INSERT INTO "mission" ("Mission_ID", "Ship_ID", "Code", "Launched_Year", "Location", "Speed_knots", "Fate") VALUES (102, 5, 'M2', 1941, 'Atlantic', 25, 'Survived');
INSERT INTO "mission" ("Mission_ID", "Ship_ID", "Code", "Launched_Year", "Location", "Speed_knots", "Fate") VALUES (103, 5, 'M3', 1942, 'Pacific', 26, 'Sunk');
INSERT INTO "mission" ("Mission_ID", "Ship_ID", "Code", "Launched_Year", "Location", "Speed_knots", "Fate") VALUES (104, 1, 'M4', 1943, 'Pacific', 30, 'Survived');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT TYPE FROM (SELECT LHS.n AS n, RHS.type AS TYPE FROM (SELECT MAX(n) AS n FROM (SELECT TYPE, COUNT(*) AS n FROM ship GROUP BY TYPE)) AS LHS LEFT JOIN (SELECT TYPE, COUNT(*) AS n FROM ship GROUP BY TYPE) AS RHS ON (LHS.n = RHS.n)) ORDER BY TYPE;

/*
Gold Result:
('Battleship',)
('Destroyer',)
*/

-- Prediction Query
SELECT TYPE FROM ship GROUP BY TYPE ORDER BY COUNT(*) DESC, TYPE NULLS LAST LIMIT 1;

/*
Prediction Result:
('Battleship',)
*/