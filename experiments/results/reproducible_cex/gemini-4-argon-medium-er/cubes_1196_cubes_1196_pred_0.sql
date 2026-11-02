-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (1, 'Ship A', 'Type A', 2000.0, 'Cutter', 'Flag A');
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (1, 1, 'John', '40', 'Cutter', 'Commander');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "rank" FROM "captain" WHERE ("class" = 'Cutter' OR "class" = 'Armed schooner') ORDER BY rank, "rank" NULLS LAST;

/*
Gold Result:
('Commander',)
*/

-- Prediction Query
SELECT rank FROM captain WHERE CLASS = 'Cutter' INTERSECT SELECT rank FROM captain WHERE CLASS = 'Armed schooner';

/*
Prediction Result:
*/