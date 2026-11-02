-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (1, 'Victory', 'Warship', 1765.0, 'First-rate', 'UK');
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (1, NULL, 'John', '20', 'A', 'Midshipman');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name", "flag" FROM (SELECT * FROM "ship" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "captain" WHERE ("rank" = 'Midshipman')) AS RHS WHERE (LHS.ship_id = RHS.ship_id))) ORDER BY name, "name" NULLS LAST, "flag" NULLS LAST;

/*
Gold Result:
('Victory', 'UK')
*/

-- Prediction Query
SELECT name, flag FROM ship WHERE NOT ship_id IN (SELECT ship_id FROM captain WHERE rank = 'Midshipman');

/*
Prediction Result:
*/