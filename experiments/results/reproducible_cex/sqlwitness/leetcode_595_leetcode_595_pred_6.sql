-- Schema DDL
CREATE TABLE "World" ("name" TEXT(255) PRIMARY KEY, "continent" TEXT(255), "area" INTEGER, "population" INTEGER, "gdp" INTEGER, CHECK ("area" > 0), CHECK ("population" > 0), CHECK ("gdp" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO world (name, continent, area, population, gdp) VALUES ('default1', 'default2', 3000000, NULL, 3000000), ('default2', NULL, 3000001, 3000001, NULL), ('unique_2', NULL, 2999999, NULL, 3000000), ('unique_3', NULL, 25000000, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, population, area FROM world WHERE area >= 3000000 OR population >= 25000000;

/*
Gold Result:
('default1', None, 3000000)
('default2', 3000001, 3000001)
('unique_3', None, 25000000)
*/

-- Prediction Query
SELECT W.NAME, W.POPULATION, W.AREA FROM WORLD AS W WHERE W.AREA > 3000000 OR W.POPULATION > 25000000;

/*
Prediction Result:
('default2', 3000001, 3000001)
('unique_3', None, 25000000)
*/