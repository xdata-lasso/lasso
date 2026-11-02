-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (1, 'Zebra', 'Cargo', 2010.0, 'Panamax', 'Malta');
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (2, 'Alpha', 'Barge', 2005.0, 'Sub-Panamax', 'Liberia');
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (3, 'Midway', 'Tanker', 1990.0, 'Aframax', 'Malta');
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (4, 'Omega', 'Ferry', 2015.0, 'Malta', 'Panama');
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (5, 'Delta', 'Cargo', 2000.0, 'Handymax', 'Greece');
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (6, 'Ghost', 'Tug', 1985.0, 'Small', NULL);
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (101, 1, 'John Smith', '45', 'A', 'Captain');
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (102, 1, 'Maria Garcia', '39', 'B', 'Co-Captain');
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (103, 4, 'Chen Wei', '52', 'A', 'Fleet Admiral');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "type" FROM "ship" WHERE ("flag" <> 'Panama' OR "flag" = 'Malta') ORDER BY TYPE, ship.ship_id NULLS LAST;

/*
Gold Result:
('Barge',)
('Cargo',)
('Cargo',)
('Tanker',)
*/

-- Prediction Query
SELECT TYPE FROM ship WHERE flag = 'Panama' INTERSECT SELECT TYPE FROM ship WHERE flag = 'Malta';

/*
Prediction Result:
*/