-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests COUNT(*) vs COUNT(Flag) on NULLs, NULLS LAST tie-breaking, and multi-column ORDER BY (ascending count, then ascending flag).
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (1, 'Alpha', 'Cargo', 2000.0, 'A', 'USA');
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (2, 'Beta', 'Cargo', 2001.0, 'A', 'UK');
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (3, 'Gamma', 'Cargo', 2002.0, 'B', NULL);
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (4, 'Delta', 'Cargo', 2003.0, 'B', 'Canada');
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (5, 'Epsilon', 'Cargo', 2004.0, 'C', 'Canada');
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (6, 'Zeta', 'Cargo', 2005.0, 'C', 'Brazil');
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (7, 'Eta', 'Cargo', 2006.0, 'A', 'Brazil');
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (8, 'Theta', 'Cargo', 2007.0, 'A', 'Brazil');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, flag FROM (SELECT flag, COUNT(*) AS n FROM ship GROUP BY flag) ORDER BY count___, flag NULLS LAST;

/*
Gold Result:
(1, 'UK')
(1, 'USA')
(1, None)
(2, 'Canada')
(3, 'Brazil')
*/

-- Prediction Query
SELECT COUNT(*), flag FROM ship GROUP BY flag;

/*
Prediction Result:
(1, None)
(3, 'Brazil')
(2, 'Canada')
(1, 'UK')
(1, 'USA')
*/