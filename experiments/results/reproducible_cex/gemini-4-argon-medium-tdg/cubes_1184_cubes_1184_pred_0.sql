-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Ship (Ship_ID, Name, Type, Built_Year, Class, Flag) VALUES (1, 'S1', 'T1', 2010.0, 'C1', 'F1');
INSERT INTO Ship (Ship_ID, Name, Type, Built_Year, Class, Flag) VALUES (2, 'S2', 'T1', 1995.0, 'C1', 'F2');
INSERT INTO Ship (Ship_ID, Name, Type, Built_Year, Class, Flag) VALUES (3, 'S3', 'T1', 1980.0, 'C1', 'F2');
INSERT INTO Ship (Ship_ID, Name, Type, Built_Year, Class, Flag) VALUES (4, 'S4', 'T2', 2020.0, 'C2', 'F1');
INSERT INTO captain (Captain_ID, Ship_ID, Name, age, Class, Rank) VALUES (101, 1, 'Cap1', '40', 'C1', 'R1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT built_year FROM (SELECT LHS.ship_id AS ship_id, LHS.name AS name, LHS.type AS TYPE, LHS.built_year AS built_year, LHS.class AS CLASS, LHS.flag AS flag, RHS.flag AS flag_other FROM ship AS LHS INNER JOIN (SELECT CLASS, flag, COUNT(*) AS n FROM ship GROUP BY CLASS, flag) AS RHS ON (LHS.ship_id = RHS.n AND LHS.class = RHS.class)) ORDER BY built_year;

/*
Gold Result:
(1995.0,)
(2010.0,)
*/

-- Prediction Query
SELECT built_year FROM ship GROUP BY built_year ORDER BY COUNT(*) DESC, built_year NULLS LAST LIMIT 1;

/*
Prediction Result:
(1980.0,)
*/