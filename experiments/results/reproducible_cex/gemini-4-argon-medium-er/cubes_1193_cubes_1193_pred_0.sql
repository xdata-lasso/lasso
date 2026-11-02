-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (10, 'S1', 'T1', 2000.0, 'A', 'US');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT flag FROM (SELECT LHS.ship_id AS ship_id, LHS.name AS name, LHS.type AS TYPE, LHS.built_year AS built_year, LHS.class AS CLASS, LHS.flag AS flag, RHS.built_year AS built_year_other FROM ship AS LHS INNER JOIN (SELECT built_year, CLASS, COUNT(*) AS n FROM ship GROUP BY built_year, CLASS) AS RHS ON (LHS.ship_id = RHS.n AND LHS.class = RHS.class)) ORDER BY flag;

/*
Gold Result:
*/

-- Prediction Query
SELECT flag FROM ship GROUP BY flag ORDER BY COUNT(*) DESC, flag NULLS LAST LIMIT 1;

/*
Prediction Result:
('US',)
*/