-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (1, 'Sea Star', 'Cargo', 1998.0, 'Panamax', 'Panama');
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (2, 'Ocean Breeze', 'Tanker', 2005.0, 'Suezmax', 'Malta');
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (3, 'Wave Runner', 'Cargo', 2010.0, 'Handymax', 'Liberia');
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (4, 'Ghost Ship', 'Barge', 1980.0, 'Small', NULL);
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (1, 1, 'John Smith', '45', 'A', 'Captain');
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (2, 2, 'Maria Borg', '38', 'A', 'Captain');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "type" FROM "ship" WHERE ("flag" <> 'Panama' OR "flag" = 'Malta') ORDER BY TYPE, ship.ship_id NULLS LAST;

/*
Gold Result:
('Cargo',)
('Tanker',)
*/

-- Prediction Query
SELECT TYPE FROM ship WHERE flag = 'Panama' INTERSECT SELECT TYPE FROM ship WHERE flag = 'Malta';

/*
Prediction Result:
*/