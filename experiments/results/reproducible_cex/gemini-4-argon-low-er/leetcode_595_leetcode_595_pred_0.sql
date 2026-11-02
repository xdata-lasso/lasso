-- Schema DDL
CREATE TABLE "World" ("name" TEXT(255) PRIMARY KEY, "continent" TEXT(255), "area" INTEGER, "population" INTEGER, "gdp" INTEGER, CHECK ("area" > 0), CHECK ("population" > 0), CHECK ("gdp" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "World" ("name", "continent", "area", "population", "gdp") VALUES ('CountryA', 'Asia', 3000000, 1000000, 500000000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, population, area FROM world WHERE area >= 3000000 OR population >= 25000000;

/*
Gold Result:
('CountryA', 1000000, 3000000)
*/

-- Prediction Query
SELECT NAME, POPULATION, AREA FROM WORLD WHERE AREA > 3000000 OR POPULATION > 25000000;

/*
Prediction Result:
*/