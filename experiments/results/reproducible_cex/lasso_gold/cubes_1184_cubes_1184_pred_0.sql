-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (1, 'Allison Hill', 'dog', 1001.5, 'chair', 'since');
INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (1002, 'Patrick Gardner', 'performance', 1003.5, 'chair', 'knowledge');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT built_year FROM (SELECT LHS.ship_id AS ship_id, LHS.name AS name, LHS.type AS TYPE, LHS.built_year AS built_year, LHS.class AS CLASS, LHS.flag AS flag, RHS.flag AS flag_other FROM ship AS LHS INNER JOIN (SELECT CLASS, flag, COUNT(*) AS n FROM ship GROUP BY CLASS, flag) AS RHS ON (LHS.ship_id = RHS.n AND LHS.class = RHS.class)) ORDER BY built_year;

/*
Gold Result:
(1001.5,)
(1001.5,)
*/

-- Prediction Query
SELECT built_year FROM ship GROUP BY built_year ORDER BY COUNT(*) DESC, built_year NULLS LAST LIMIT 1;

/*
Prediction Result:
(1001.5,)
*/