-- Schema DDL
CREATE TABLE "World" ("name" TEXT(255) PRIMARY KEY, "continent" TEXT(255), "area" INTEGER, "population" INTEGER, "gdp" INTEGER, CHECK ("area" > 0), CHECK ("population" > 0), CHECK ("gdp" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO World (name, continent, area, population, gdp) VALUES ('BoundAreaExact', 'Asia', 3000000, 100000, 5000000);
INSERT INTO World (name, continent, area, population, gdp) VALUES ('BoundAreaBelow', 'Asia', 2999999, 100000, 5000000);
INSERT INTO World (name, continent, area, population, gdp) VALUES ('BoundAreaAbove', 'Asia', 3000001, 100000, 5000000);
INSERT INTO World (name, continent, area, population, gdp) VALUES ('BoundPopExact', 'Europe', 100000, 25000000, 5000000);
INSERT INTO World (name, continent, area, population, gdp) VALUES ('BoundPopBelow', 'Europe', 100000, 24999999, 5000000);
INSERT INTO World (name, continent, area, population, gdp) VALUES ('BoundPopAbove', 'Europe', 100000, 25000001, 5000000);
INSERT INTO World (name, continent, area, population, gdp) VALUES ('BoundBothExact', 'Africa', 3000000, 25000000, 5000000);
INSERT INTO World (name, continent, area, population, gdp) VALUES ('BoundBothBelow', 'Africa', 2999999, 24999999, 5000000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, population, area FROM world WHERE area >= 3000000 OR population >= 25000000;

/*
Gold Result:
('BoundAreaExact', 100000, 3000000)
('BoundAreaAbove', 100000, 3000001)
('BoundPopExact', 25000000, 100000)
('BoundPopAbove', 25000001, 100000)
('BoundBothExact', 25000000, 3000000)
*/

-- Prediction Query
SELECT NAME, POPULATION, AREA FROM WORLD WHERE AREA > 3000000 OR POPULATION > 25000000 ORDER BY 1, 2, 3, WORLD.name NULLS LAST;

/*
Prediction Result:
('BoundAreaAbove', 100000, 3000001)
('BoundPopAbove', 25000001, 100000)
*/