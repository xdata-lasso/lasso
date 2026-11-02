-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic GROUP BY (Class, Flag), join on (LHS.Ship_ID = RHS.n AND LHS.Class = RHS.Class),
-- duplicate output rows (1-to-many join when multiple flags have the same count in the same class),
-- and ordering (DESC vs ASC, insertion order vs sorted order).
-- Also ensures LHS.Flag does NOT need to equal RHS.Flag, and Captain table is ignored.
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (1, 'Alpha', 'Cargo', 2005.0, 'A', 'US');
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (2, 'Beta', 'Cargo', 1995.0, 'A', 'UK');
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (3, 'Gamma', 'Cargo', 2010.0, 'B', 'US');
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (1, 1, 'Smith', '45', 'A', 'Captain');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT built_year FROM (SELECT LHS.ship_id AS ship_id, LHS.name AS name, LHS.type AS TYPE, LHS.built_year AS built_year, LHS.class AS CLASS, LHS.flag AS flag, RHS.flag AS flag_other FROM ship AS LHS INNER JOIN (SELECT CLASS, flag, COUNT(*) AS n FROM ship GROUP BY CLASS, flag) AS RHS ON (LHS.ship_id = RHS.n AND LHS.class = RHS.class)) ORDER BY built_year;

/*
Gold Result:
(2005.0,)
(2005.0,)
*/

-- Prediction Query
SELECT built_year FROM ship GROUP BY built_year ORDER BY COUNT(*) DESC, built_year NULLS LAST LIMIT 1;

/*
Prediction Result:
(1995.0,)
*/