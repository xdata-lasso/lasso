-- Schema DDL
CREATE TABLE "World" ("name" TEXT(255) PRIMARY KEY, "continent" TEXT(255), "area" INTEGER, "population" INTEGER, "gdp" INTEGER, CHECK ("area" > 0), CHECK ("population" > 0), CHECK ("gdp" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: world --
INSERT INTO "world" ("name", "continent", "area", "population", "gdp") VALUES ('wor_e3897f', 'wor_dfbfb3', 3000000, 1, 247012447);

INSERT INTO "world" ("name", "continent", "area", "population", "gdp") VALUES ('A', 'wor_dfbfb3', 1644814318, 25000000, 1465859724);

INSERT INTO "world" ("name", "continent", "area", "population", "gdp") VALUES ('@', 'wor_dfbfb3', 3000000, NULL, 247012447);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, population, area FROM world WHERE area >= 3000000 OR population >= 25000000;

/*
Gold Result:
('wor_e3897f', 1, 3000000)
('A', 25000000, 1644814318)
('@', None, 3000000)
*/

-- Prediction Query
WITH POP AS (SELECT NAME, POPULATION, AREA FROM WORLD WHERE POPULATION > 25000000), AREA AS (SELECT NAME, POPULATION, AREA FROM WORLD WHERE AREA > 3000000) SELECT * FROM POP UNION SELECT * FROM AREA;

/*
Prediction Result:
('A', 25000000, 1644814318)
*/