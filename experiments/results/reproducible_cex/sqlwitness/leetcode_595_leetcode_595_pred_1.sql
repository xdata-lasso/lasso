-- Schema DDL
CREATE TABLE "World" ("name" TEXT(255) PRIMARY KEY, "continent" TEXT(255), "area" INTEGER, "population" INTEGER, "gdp" INTEGER, CHECK ("area" > 0), CHECK ("population" > 0), CHECK ("gdp" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO world (name, continent, area, population, gdp) VALUES ('default2', 'default1', 2999999, 25000000, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, population, area FROM world WHERE area >= 3000000 OR population >= 25000000;

/*
Gold Result:
('default2', 25000000, 2999999)
*/

-- Prediction Query
SELECT WORLD.NAME, WORLD.AREA, WORLD.POPULATION FROM WORLD WHERE AREA > 3000000 OR POPULATION > 25000000;

/*
Prediction Result:
*/