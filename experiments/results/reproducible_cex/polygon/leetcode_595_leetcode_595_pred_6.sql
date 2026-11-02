-- Schema DDL
CREATE TABLE "World" ("name" TEXT(255) PRIMARY KEY, "continent" TEXT(255), "area" INTEGER, "population" INTEGER, "gdp" INTEGER, CHECK ("area" > 0), CHECK ("population" > 0), CHECK ("gdp" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "World" ("name", "continent", "area", "population", "gdp") VALUES ('6', '1', 1, 1, 1);
INSERT INTO "World" ("name", "continent", "area", "population", "gdp") VALUES ('7', NULL, 1, 25000000, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, population, area FROM world WHERE area >= 3000000 OR population >= 25000000;

/*
Gold Result:
('7', 25000000, 1)
*/

-- Prediction Query
SELECT W.NAME, W.POPULATION, W.AREA FROM WORLD AS W WHERE W.AREA > 3000000 OR W.POPULATION > 25000000;

/*
Prediction Result:
*/