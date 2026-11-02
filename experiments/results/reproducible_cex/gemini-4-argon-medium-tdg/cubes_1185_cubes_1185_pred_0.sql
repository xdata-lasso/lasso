-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (1, 'Alpha', 'Destroyer', 2000.0, 'X', 'US');
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (2, 'Beta', 'Cruiser', 2010.0, 'Y', 'UK');
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (3, 'Gamma', 'Submarine', 2015.0, 'Z', 'FR');
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (1, NULL, 'Orphan Midshipman', '18', 'C', 'Midshipman');
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (2, 1, 'Null Rank Captain', '50', 'A', NULL);
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (3, 2, 'Midshipman', '35', 'A', 'Captain');
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (4, 3, 'Wrong Case', '22', 'C', 'midshipman');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name", "flag" FROM (SELECT * FROM "ship" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "captain" WHERE ("rank" = 'Midshipman')) AS RHS WHERE (LHS.ship_id = RHS.ship_id))) ORDER BY name, "name" NULLS LAST, "flag" NULLS LAST;

/*
Gold Result:
('Alpha', 'US')
('Beta', 'UK')
('Gamma', 'FR')
*/

-- Prediction Query
SELECT name, flag FROM ship WHERE NOT ship_id IN (SELECT ship_id FROM captain WHERE rank = 'Midshipman');

/*
Prediction Result:
*/