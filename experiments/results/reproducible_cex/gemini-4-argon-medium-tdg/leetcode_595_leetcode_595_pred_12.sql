-- Schema DDL
CREATE TABLE "World" ("name" TEXT(255) PRIMARY KEY, "continent" TEXT(255), "area" INTEGER, "population" INTEGER, "gdp" INTEGER, CHECK ("area" > 0), CHECK ("population" > 0), CHECK ("gdp" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO World (name, continent, area, population, gdp) VALUES ('ExactAreaOnly', 'Asia', 3000000, 10000000, 100000000);
INSERT INTO World (name, continent, area, population, gdp) VALUES ('ExactPopOnly', 'Europe', 1000000, 25000000, 200000000);
INSERT INTO World (name, continent, area, population, gdp) VALUES ('JustBelowBoth', 'Africa', 2999999, 24999999, 300000000);
INSERT INTO World (name, continent, area, population, gdp) VALUES ('ExactBoth', 'Americas', 3000000, 25000000, 400000000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, population, area FROM world WHERE area >= 3000000 OR population >= 25000000;

/*
Gold Result:
('ExactAreaOnly', 10000000, 3000000)
('ExactPopOnly', 25000000, 1000000)
('ExactBoth', 25000000, 3000000)
*/

-- Prediction Query
SELECT NAME, AREA, POPULATION FROM WORLD WHERE AREA >= 3000000 OR POPULATION >= 25000000;

/*
Prediction Result:
('ExactAreaOnly', 3000000, 10000000)
('ExactPopOnly', 1000000, 25000000)
('ExactBoth', 3000000, 25000000)
*/