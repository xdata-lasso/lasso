-- Schema DDL
CREATE TABLE "World" ("name" TEXT(255) PRIMARY KEY, "continent" TEXT(255), "area" INTEGER, "population" INTEGER, "gdp" INTEGER, CHECK ("area" > 0), CHECK ("population" > 0), CHECK ("gdp" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "World" ("name", "continent", "area", "population", "gdp") VALUES ('7', '5', 1, 25000000, 1);
INSERT INTO "World" ("name", "continent", "area", "population", "gdp") VALUES ('8', '6', NULL, 25000000, 853);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, population, area FROM world WHERE area >= 3000000 OR population >= 25000000;

/*
Gold Result:
('7', 25000000, 1)
('8', 25000000, None)
*/

-- Prediction Query
SELECT NAME, AREA, POPULATION FROM WORLD WHERE AREA >= 3000000 OR POPULATION >= 25000000;

/*
Prediction Result:
('7', 1, 25000000)
('8', None, 25000000)
*/