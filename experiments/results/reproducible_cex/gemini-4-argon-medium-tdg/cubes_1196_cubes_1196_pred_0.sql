-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (1, 'Sea Hawk', 'Frigate', 1980.0, 'Frigate', 'UK');
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (2, 'Wave', 'Cutter', 1990.0, 'Cutter', 'US');
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (3, 'Wind', 'Schooner', 1995.0, 'Armed schooner', 'FR');
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (1, 1, 'John', '45', 'Cutter', 'Admiral');
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (2, 1, 'Smith', '50', 'Cutter', 'Admiral');
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (3, 1, 'Alice', '35', 'Armed schooner', 'Commander');
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (4, 2, 'Bob', '40', 'Frigate', 'Lieutenant');
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (5, 3, 'Charlie', '60', NULL, 'Ensign');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "rank" FROM "captain" WHERE ("class" = 'Cutter' OR "class" = 'Armed schooner') ORDER BY rank, "rank" NULLS LAST;

/*
Gold Result:
('Admiral',)
('Commander',)
*/

-- Prediction Query
SELECT rank FROM captain WHERE CLASS = 'Cutter' INTERSECT SELECT rank FROM captain WHERE CLASS = 'Armed schooner';

/*
Prediction Result:
*/