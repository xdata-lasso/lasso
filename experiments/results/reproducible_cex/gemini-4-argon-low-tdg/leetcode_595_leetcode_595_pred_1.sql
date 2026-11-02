-- Schema DDL
CREATE TABLE "World" ("name" TEXT(255) PRIMARY KEY, "continent" TEXT(255), "area" INTEGER, "population" INTEGER, "gdp" INTEGER, CHECK ("area" > 0), CHECK ("population" > 0), CHECK ("gdp" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests exact boundary conditions (area = 3000000, population = 25000000) and off-by-one values to kill >, <, <=, and constant-shift mutants.
INSERT INTO "World" ("name", "continent", "area", "population", "gdp") VALUES ('AreaExact_PopLow', 'Asia', 3000000, 10000000, 50000000);
INSERT INTO "World" ("name", "continent", "area", "population", "gdp") VALUES ('AreaJustUnder_PopLow', 'Europe', 2999999, 10000000, 50000000);
INSERT INTO "World" ("name", "continent", "area", "population", "gdp") VALUES ('AreaLow_PopExact', 'Africa', 1000000, 25000000, 50000000);
INSERT INTO "World" ("name", "continent", "area", "population", "gdp") VALUES ('AreaLow_PopJustUnder', 'South America', 1000000, 24999999, 50000000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, population, area FROM world WHERE area >= 3000000 OR population >= 25000000;

/*
Gold Result:
('AreaExact_PopLow', 10000000, 3000000)
('AreaLow_PopExact', 25000000, 1000000)
*/

-- Prediction Query
SELECT WORLD.NAME, WORLD.AREA, WORLD.POPULATION FROM WORLD WHERE AREA > 3000000 OR POPULATION > 25000000;

/*
Prediction Result:
*/