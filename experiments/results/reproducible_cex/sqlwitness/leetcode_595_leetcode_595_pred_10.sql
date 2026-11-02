-- Schema DDL
CREATE TABLE "World" ("name" TEXT(255) PRIMARY KEY, "continent" TEXT(255), "area" INTEGER, "population" INTEGER, "gdp" INTEGER, CHECK ("area" > 0), CHECK ("population" > 0), CHECK ("gdp" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO world (name, continent, area, population, gdp) VALUES ('default1', NULL, 3000000, 25000000, 7), ('default2', NULL, 7, 9, 6), ('unique_2', 'default2', 25000000, 10, 5), ('unique_3', 'default2', 24999999, 3000001, 25000001);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, population, area FROM world WHERE area >= 3000000 OR population >= 25000000;

/*
Gold Result:
('default1', 25000000, 3000000)
('unique_2', 10, 25000000)
('unique_3', 3000001, 24999999)
*/

-- Prediction Query
SELECT NAME, POPULATION, AREA FROM WORLD WHERE AREA > (3 * POWER(10, 6)) OR POPULATION > (25 * POWER(10, 6));

/*
Prediction Result:
('unique_2', 10, 25000000)
('unique_3', 3000001, 24999999)
*/