-- Schema DDL
CREATE TABLE "mission" ("Mission_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Code" TEXT, "Launched_Year" INTEGER, "Location" TEXT, "Speed_knots" INTEGER, "Fate" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "ship" ("Ship_ID"));

CREATE TABLE "ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Nationality" TEXT, "Tonnage" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Ties for maximum count (tests LIMIT 1 vs ALL ties, and ORDER BY TYPE)
-- Also tests INNER JOIN vs LEFT JOIN with mission table (some ships have 0 missions, some have multiple)
INSERT INTO "ship" ("Ship_ID", "Name", "Type", "Nationality", "Tonnage") VALUES (1, 'Alpha', 'Destroyer', 'USA', 2000);
INSERT INTO "ship" ("Ship_ID", "Name", "Type", "Nationality", "Tonnage") VALUES (2, 'Beta', 'Destroyer', 'UK', 2000);
INSERT INTO "ship" ("Ship_ID", "Name", "Type", "Nationality", "Tonnage") VALUES (3, 'Gamma', 'Destroyer', 'USA', 2500);
INSERT INTO "ship" ("Ship_ID", "Name", "Type", "Nationality", "Tonnage") VALUES (4, 'Delta', 'Battleship', 'USA', 5000);
INSERT INTO "ship" ("Ship_ID", "Name", "Type", "Nationality", "Tonnage") VALUES (5, 'Epsilon', 'Battleship', 'UK', 5000);
INSERT INTO "ship" ("Ship_ID", "Name", "Type", "Nationality", "Tonnage") VALUES (6, 'Zeta', 'Battleship', 'France', 5500);
INSERT INTO "ship" ("Ship_ID", "Name", "Type", "Nationality", "Tonnage") VALUES (7, 'Eta', 'Cruiser', 'USA', 3000);
INSERT INTO "mission" ("Mission_ID", "Ship_ID", "Code", "Launched_Year", "Location", "Speed_knots", "Fate") VALUES (101, 7, 'M1', 1940, 'Pacific', 25, 'Survived');
INSERT INTO "mission" ("Mission_ID", "Ship_ID", "Code", "Launched_Year", "Location", "Speed_knots", "Fate") VALUES (102, 7, 'M2', 1941, 'Atlantic', 25, 'Survived');
INSERT INTO "mission" ("Mission_ID", "Ship_ID", "Code", "Launched_Year", "Location", "Speed_knots", "Fate") VALUES (103, 7, 'M3', 1942, 'Pacific', 26, 'Survived');
INSERT INTO "mission" ("Mission_ID", "Ship_ID", "Code", "Launched_Year", "Location", "Speed_knots", "Fate") VALUES (104, 7, 'M4', 1943, 'Indian', 24, 'Sunk');
INSERT INTO "mission" ("Mission_ID", "Ship_ID", "Code", "Launched_Year", "Location", "Speed_knots", "Fate") VALUES (105, 1, 'M5', 1944, 'Atlantic', 30, 'Survived');
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