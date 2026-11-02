-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (1, 'A', 'T', 1990.0, 'Z', 'F');
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (2, 'B', 'T', 2000.0, 'A', 'F');
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (3, 'C', 'T', 2000.0, 'A', 'F');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT built_year FROM (SELECT * FROM (SELECT * FROM (SELECT built_year, CLASS, MAX(n) AS n FROM (SELECT ship_id, name, TYPE, built_year, CLASS, flag, COUNT(*) OVER () AS n FROM ship) GROUP BY built_year, CLASS) ORDER BY CLASS DESC) LIMIT 1);

/*
Gold Result:
(1990.0,)
*/

-- Prediction Query
SELECT built_year FROM ship GROUP BY built_year ORDER BY COUNT(*) DESC, built_year NULLS LAST LIMIT 1;

/*
Prediction Result:
(2000.0,)
*/