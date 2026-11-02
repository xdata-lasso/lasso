-- Schema DDL
CREATE TABLE "World" ("name" TEXT(255) PRIMARY KEY, "continent" TEXT(255), "area" INTEGER, "population" INTEGER, "gdp" INTEGER, CHECK ("area" > 0), CHECK ("population" > 0), CHECK ("gdp" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO world (name, continent, area, population, gdp) VALUES ('default2', 'default2', 25000001, 25000001, 24999999), ('default1', NULL, 3000000, 2, 2999999), ('unique_2', 'default2', 24999999, 4, 3000000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, population, area FROM world WHERE area >= 3000000 OR population >= 25000000;

/*
Gold Result:
('default2', 25000001, 25000001)
('default1', 2, 3000000)
('unique_2', 4, 24999999)
*/

-- Prediction Query
SELECT NAME, POPULATION, AREA FROM WORLD WHERE AREA > 3000000 OR POPULATION > 25000000 ORDER BY 1, 2, 3, WORLD.name NULLS LAST;

/*
Prediction Result:
('default2', 25000001, 25000001)
('unique_2', 4, 24999999)
*/