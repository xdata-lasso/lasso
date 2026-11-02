-- Schema DDL
CREATE TABLE "World" ("name" TEXT(255) PRIMARY KEY, "continent" TEXT(255), "area" INTEGER, "population" INTEGER, "gdp" INTEGER, CHECK ("area" > 0), CHECK ("population" > 0), CHECK ("gdp" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO world (name, continent, area, population, gdp) VALUES ('default2', 'default2', 25000000, 2999999, 1), ('default1', 'default2', NULL, 1, 24999999), ('unique_2', 'default1', 25000000, 3000001, 25000001), ('unique_3', 'default1', 3000000, 24999999, 1), ('unique_4', NULL, 2999999, 1, 25000001), ('unique_5', 'default1', 3000001, NULL, 2999999), ('unique_6', 'default2', 3000000, 25000001, 3000001);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, population, area FROM world WHERE area >= 3000000 OR population >= 25000000;

/*
Gold Result:
('default2', 2999999, 25000000)
('unique_2', 3000001, 25000000)
('unique_3', 24999999, 3000000)
('unique_5', None, 3000001)
('unique_6', 25000001, 3000000)
*/

-- Prediction Query
WITH POP AS (SELECT NAME, POPULATION, AREA FROM WORLD WHERE POPULATION > 25000000), AREA AS (SELECT NAME, POPULATION, AREA FROM WORLD WHERE AREA > 3000000) SELECT * FROM POP UNION SELECT * FROM AREA;

/*
Prediction Result:
('default2', 2999999, 25000000)
('unique_2', 3000001, 25000000)
('unique_5', None, 3000001)
('unique_6', 25000001, 3000000)
*/