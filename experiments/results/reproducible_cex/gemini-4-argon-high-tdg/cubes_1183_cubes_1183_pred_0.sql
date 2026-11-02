-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (1, 'Voyager', 'Cargo', 1998.0, 'Panamax', 'Panama');
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (2, 'Liberty One', 'Tanker', 2005.0, 'Aframax', 'Liberia');
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (3, NULL, 'Tanker', 2005.0, NULL, 'Liberia');
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (4, 'Eagle', 'Container', 2010.0, 'Post-Panamax', 'USA');
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (5, 'Eagle', NULL, NULL, 'Post-Panamax', 'USA');
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (6, 'Ghost', 'Ferry', 1990.0, 'Ro-Ro', NULL);
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (7, 'Phantom', 'Ferry', 1990.0, 'Ro-Ro', NULL);
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (8, 'Sun', 'Cruise', 2015.0, 'Oasis', 'Bahamas');
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (9, 'Moon', 'Cruise', 2018.0, 'Oasis', 'Bahamas');
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (10, 'Star', 'Cruise', 2020.0, 'Oasis', 'Bahamas');
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (1, 1, 'Smith', '45', 'Panamax', 'Captain');
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (2, 1, 'Jones', '38', 'First', 'Commander');
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (3, 2, 'Adams', '50', 'Aframax', 'Captain');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, flag FROM (SELECT flag, COUNT(*) AS n FROM ship GROUP BY flag) ORDER BY count___, flag NULLS LAST;

/*
Gold Result:
(1, 'Panama')
(2, 'Liberia')
(2, 'USA')
(2, None)
(3, 'Bahamas')
*/

-- Prediction Query
SELECT COUNT(*), flag FROM ship GROUP BY flag;

/*
Prediction Result:
(2, None)
(3, 'Bahamas')
(2, 'Liberia')
(1, 'Panama')
(2, 'USA')
*/