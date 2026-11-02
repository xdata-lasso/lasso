-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (1, 'Black Pearl', 'Galleon', 1700.0, 'A', 'Pirate');
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (2, 'Interceptor', 'Sloop', 1740.0, 'B', 'Royal Navy');
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (3, 'Flying Dutchman', 'Galleon', 1650.0, 'A', 'Ghost');
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (4, 'Endeavour', 'Bark', 1764.0, 'C', 'British');
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (5, 'Dauntless', 'Ship of the line', 1730.0, 'A', 'Royal Navy');
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (101, 2, 'Jack', '40', 'A', 'Captain');
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (102, 2, 'Hector', '55', 'A', 'Admiral');
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (103, 3, 'Will', '25', 'C', 'Midshipman');
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (104, 4, 'Davy', '100', 'A', 'Captain');
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (105, 4, 'Pintel', '35', 'C', 'Midshipman');
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (106, 5, 'Norrington', '38', 'A', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name", "flag" FROM (SELECT * FROM "ship" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "captain" WHERE ("rank" = 'Midshipman')) AS RHS WHERE (LHS.ship_id = RHS.ship_id))) ORDER BY name, "name" NULLS LAST, "flag" NULLS LAST;

/*
Gold Result:
('Black Pearl', 'Pirate')
('Dauntless', 'Royal Navy')
('Interceptor', 'Royal Navy')
*/

-- Prediction Query
SELECT name, flag FROM ship WHERE NOT ship_id IN (SELECT ship_id FROM captain WHERE rank = 'Midshipman');

/*
Prediction Result:
('Black Pearl', 'Pirate')
('Interceptor', 'Royal Navy')
('Dauntless', 'Royal Navy')
*/