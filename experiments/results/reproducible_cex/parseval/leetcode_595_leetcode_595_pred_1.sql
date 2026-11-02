-- Schema DDL
CREATE TABLE "World" ("name" TEXT(255) PRIMARY KEY, "continent" TEXT(255), "area" INTEGER, "population" INTEGER, "gdp" INTEGER, CHECK ("area" > 0), CHECK ("population" > 0), CHECK ("gdp" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: world --
INSERT INTO "world" ("name", "continent", "area", "population", "gdp") VALUES ('wor_988c7b', 'wor_dfbfb3', 3000000, 1, 247012447);

INSERT INTO "world" ("name", "continent", "area", "population", "gdp") VALUES ('A', 'wor_dfbfb3', 1644814318, 25000000, 1465859724);

INSERT INTO "world" ("name", "continent", "area", "population", "gdp") VALUES ('@', 'wor_dfbfb3', 3000000, NULL, 247012447);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, population, area FROM world WHERE area >= 3000000 OR population >= 25000000;

/*
Gold Result:
('wor_988c7b', 1, 3000000)
('A', 25000000, 1644814318)
('@', None, 3000000)
*/

-- Prediction Query
SELECT WORLD.NAME, WORLD.AREA, WORLD.POPULATION FROM WORLD WHERE AREA > 3000000 OR POPULATION > 25000000;

/*
Prediction Result:
('A', 1644814318, 25000000)
*/