-- Schema DDL
CREATE TABLE "World" ("name" TEXT(255) PRIMARY KEY, "continent" TEXT(255), "area" INTEGER, "population" INTEGER, "gdp" INTEGER, CHECK ("area" > 0), CHECK ("population" > 0), CHECK ("gdp" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "World" ("name", "continent", "area", "population", "gdp") VALUES (NULL, 'Asia', 100, 30000000, 100);
INSERT INTO "World" ("name", "continent", "area", "population", "gdp") VALUES (NULL, 'Europe', 200, 30000000, 100);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, population, area FROM world WHERE area >= 3000000 OR population >= 25000000;

/*
Gold Result:
(None, 30000000, 100)
(None, 30000000, 200)
*/

-- Prediction Query
SELECT NAME, POPULATION, SUM(AREA) AS AREA FROM WORLD WHERE AREA >= 3000000 OR POPULATION >= 25000000 GROUP BY 1, 2;

/*
Prediction Result:
(None, 30000000, 300)
*/