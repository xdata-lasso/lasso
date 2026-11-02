-- Schema DDL
CREATE TABLE "mission" ("Mission_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Code" TEXT, "Launched_Year" INTEGER, "Location" TEXT, "Speed_knots" INTEGER, "Fate" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "ship" ("Ship_ID"));

CREATE TABLE "ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Nationality" TEXT, "Tonnage" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests ORDER BY specifications: ASC vs DESC, column precedence (Code -> Fate -> Name), and NULLS LAST vs NULLS FIRST on Code, Fate, and Name.
INSERT INTO "ship" ("Ship_ID", "Name", "Type", "Nationality", "Tonnage") VALUES (1, 'A_Ship', 'Frigate', 'USA', 15000);
INSERT INTO "ship" ("Ship_ID", "Name", "Type", "Nationality", "Tonnage") VALUES (2, 'B_Ship', 'Corvette', 'UK', 12000);
INSERT INTO "ship" ("Ship_ID", "Name", "Type", "Nationality", "Tonnage") VALUES (3, NULL, 'Submarine', 'USSR', 18000);
INSERT INTO "mission" ("Mission_ID", "Ship_ID", "Code", "Launched_Year", "Location", "Speed_knots", "Fate") VALUES (1, 1, NULL, 1950, 'Loc1', 20, 'Active');
INSERT INTO "mission" ("Mission_ID", "Ship_ID", "Code", "Launched_Year", "Location", "Speed_knots", "Fate") VALUES (2, 1, 'M1', 1951, 'Loc2', 20, 'Destroyed');
INSERT INTO "mission" ("Mission_ID", "Ship_ID", "Code", "Launched_Year", "Location", "Speed_knots", "Fate") VALUES (3, 1, 'M1', 1952, 'Loc3', 20, 'Active');
INSERT INTO "mission" ("Mission_ID", "Ship_ID", "Code", "Launched_Year", "Location", "Speed_knots", "Fate") VALUES (4, 2, 'M1', 1953, 'Loc4', 20, 'Active');
INSERT INTO "mission" ("Mission_ID", "Ship_ID", "Code", "Launched_Year", "Location", "Speed_knots", "Fate") VALUES (5, 3, 'M1', 1954, 'Loc5', 20, 'Active');
INSERT INTO "mission" ("Mission_ID", "Ship_ID", "Code", "Launched_Year", "Location", "Speed_knots", "Fate") VALUES (6, 2, 'M1', 1955, 'Loc6', 20, NULL);
INSERT INTO "mission" ("Mission_ID", "Ship_ID", "Code", "Launched_Year", "Location", "Speed_knots", "Fate") VALUES (7, 1, 'M2', 1956, 'Loc7', 20, 'Active');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT code, fate, name FROM (SELECT LHS.mission_id AS mission_id, LHS.ship_id AS ship_id, LHS.code AS code, LHS.launched_year AS launched_year, LHS.location AS LOCATION, LHS.speed_knots AS speed_knots, LHS.fate AS fate, RHS.name AS name, RHS.type AS TYPE, RHS.nationality AS nationality, RHS.tonnage AS tonnage FROM mission AS LHS INNER JOIN ship AS RHS ON (LHS.ship_id = RHS.ship_id)) ORDER BY code, fate NULLS LAST, name NULLS LAST;

/*
Gold Result:
(None, 'Active', 'A_Ship')
('M1', 'Active', 'A_Ship')
('M1', 'Active', 'B_Ship')
('M1', 'Active', None)
('M1', 'Destroyed', 'A_Ship')
('M1', None, 'B_Ship')
('M2', 'Active', 'A_Ship')
*/

-- Prediction Query
SELECT T1.Code, T1.Fate, T2.Name FROM mission AS T1 JOIN ship AS T2 ON T1.Ship_ID = T2.Ship_ID;

/*
Prediction Result:
(None, 'Active', 'A_Ship')
('M1', 'Destroyed', 'A_Ship')
('M1', 'Active', 'A_Ship')
('M1', 'Active', 'B_Ship')
('M1', 'Active', None)
('M1', None, 'B_Ship')
('M2', 'Active', 'A_Ship')
*/