-- Schema DDL
CREATE TABLE "World" ("name" TEXT(255) PRIMARY KEY, "continent" TEXT(255), "area" INTEGER, "population" INTEGER, "gdp" INTEGER, CHECK ("area" > 0), CHECK ("population" > 0), CHECK ("gdp" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO World (name, continent, area, population, gdp) VALUES ('CountryA', 'Asia', 4000000, 30000000, 100000000);
INSERT INTO World (name, continent, area, population, gdp) VALUES ('CountryB', 'Europe', 3500000, 10000000, 200000000);
INSERT INTO World (name, continent, area, population, gdp) VALUES ('CountryC', 'Africa', 1000000, 40000000, 150000000);
INSERT INTO World (name, continent, area, population, gdp) VALUES ('CountryD', 'Oceania', 500000, 5000000, 50000000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, population, area FROM world WHERE area >= 3000000 OR population >= 25000000;

/*
Gold Result:
('CountryA', 30000000, 4000000)
('CountryB', 10000000, 3500000)
('CountryC', 40000000, 1000000)
*/

-- Prediction Query
SELECT NAME, AREA, POPULATION FROM WORLD WHERE AREA >= 3000000 OR POPULATION >= 25000000;

/*
Prediction Result:
('CountryA', 4000000, 30000000)
('CountryB', 3500000, 10000000)
('CountryC', 1000000, 40000000)
*/