-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Ship" ("Ship_ID", "Name", "Flag") VALUES (1, 'B', 'F1');
INSERT INTO "Ship" ("Ship_ID", "Name", "Flag") VALUES (2, 'A', 'F2');
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Rank") VALUES (1, NULL, 'Midshipman');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name", "flag" FROM (SELECT * FROM "ship" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "captain" WHERE ("rank" = 'Midshipman')) AS RHS WHERE (LHS.ship_id = RHS.ship_id))) ORDER BY name, "name" NULLS LAST, "flag" NULLS LAST;

/*
Gold Result:
('A', 'F2')
('B', 'F1')
*/

-- Prediction Query
SELECT name, flag FROM ship WHERE NOT ship_id IN (SELECT ship_id FROM captain WHERE rank = 'Midshipman');

/*
Prediction Result:
*/