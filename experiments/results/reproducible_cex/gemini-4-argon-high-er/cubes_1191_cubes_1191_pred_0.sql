-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (1, 'B', 'T1', 2000.0, 'C1', 'F1');
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (2, 'A', 'T1', 2000.0, 'C1', 'F1');
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (1, NULL, 'Cap1', '40', 'C1', 'R1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, CLASS FROM (SELECT * FROM ship AS LHS WHERE NOT EXISTS(SELECT 1 FROM captain AS RHS WHERE (LHS.ship_id = RHS.ship_id))) ORDER BY name, CLASS NULLS LAST;

/*
Gold Result:
('A', 'C1')
('B', 'C1')
*/

-- Prediction Query
SELECT name, CLASS FROM ship WHERE NOT ship_id IN (SELECT ship_id FROM captain);

/*
Prediction Result:
*/