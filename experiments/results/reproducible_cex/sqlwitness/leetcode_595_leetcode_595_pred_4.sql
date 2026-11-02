-- Schema DDL
CREATE TABLE "World" ("name" TEXT(255) PRIMARY KEY, "continent" TEXT(255), "area" INTEGER, "population" INTEGER, "gdp" INTEGER, CHECK ("area" > 0), CHECK ("population" > 0), CHECK ("gdp" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO world (name, continent, area, population, gdp) VALUES ('default1', 'default1', 3000000, 2999999, 3000001), ('default2', NULL, 3000000, NULL, 3000000), ('unique_2', NULL, 3000000, 3000000, 25000000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, population, area FROM world WHERE area >= 3000000 OR population >= 25000000;

/*
Gold Result:
('default1', 2999999, 3000000)
('default2', None, 3000000)
('unique_2', 3000000, 3000000)
*/

-- Prediction Query
SELECT NAME, POPULATION, AREA FROM WORLD WHERE AREA > 3000000 UNION SELECT NAME, POPULATION, AREA FROM WORLD WHERE POPULATION > 25000000;

/*
Prediction Result:
*/