-- Schema DDL
CREATE TABLE "World" ("name" TEXT(255) PRIMARY KEY, "continent" TEXT(255), "area" INTEGER, "population" INTEGER, "gdp" INTEGER, CHECK ("area" > 0), CHECK ("population" > 0), CHECK ("gdp" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO world (name, continent, area, population, gdp) VALUES ('default2', NULL, 25000000, 1, NULL), ('default1', 'default1', 24999999, 1, 25000000), ('unique_2', NULL, 1, 3000000, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, population, area FROM world WHERE area >= 3000000 OR population >= 25000000;

/*
Gold Result:
('default2', 1, 25000000)
('default1', 1, 24999999)
*/

-- Prediction Query
SELECT NAME, POPULATION, AREA FROM WORLD WHERE AREA >= 3000000 OR POPULATION >= 25000000 ORDER BY NAME;

/*
Prediction Result:
('default1', 1, 24999999)
('default2', 1, 25000000)
*/