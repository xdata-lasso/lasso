-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (1, 'Aurora', 'Cargo', 2000.0, 'B', 'US');
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (2, 'Aurora', 'Cargo', 2005.0, 'A', 'UK');
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (3, 'Aurora', 'Cargo', 2005.0, 'A', 'FR');
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (4, 'Aurora', 'Cargo', 2010.0, NULL, 'DE');
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (5, 'Borealis', 'Tanker', 1995.0, 'C', 'US');
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (6, 'Calypso', 'Cruiser', 2015.0, 'A', 'IT');
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (7, NULL, 'Tug', 1980.0, 'Z', 'PA');
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (1, 5, 'Smith', '45', 'C', 'Captain');
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (2, 6, 'Jones', '50', 'A', 'Commander');
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (3, 6, 'Taylor', '38', 'B', 'Lieutenant');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, CLASS FROM (SELECT * FROM ship AS LHS WHERE NOT EXISTS(SELECT 1 FROM captain AS RHS WHERE (LHS.ship_id = RHS.ship_id))) ORDER BY name, CLASS NULLS LAST;

/*
Gold Result:
(None, 'Z')
('Aurora', 'A')
('Aurora', 'A')
('Aurora', 'B')
('Aurora', None)
*/

-- Prediction Query
SELECT name, CLASS FROM ship WHERE NOT ship_id IN (SELECT ship_id FROM captain);

/*
Prediction Result:
('Aurora', 'B')
('Aurora', 'A')
('Aurora', 'A')
('Aurora', None)
(None, 'Z')
*/