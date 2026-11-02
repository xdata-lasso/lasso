-- Schema DDL
CREATE TABLE "city" ("ID" INTEGER PRIMARY KEY, "CountryCode" TEXT(3), "Name" TEXT(35), "District" TEXT(20), "Population" INTEGER, FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

CREATE TABLE "country" ("Code" TEXT(3) PRIMARY KEY, "Name" TEXT(52), "Continent" TEXT, "Region" TEXT(26), "SurfaceArea" REAL(10, 2), "IndepYear" INTEGER, "Population" INTEGER, "LifeExpectancy" REAL(3, 1), "GNP" REAL(10, 2), "GNPOld" REAL(10, 2), "LocalName" TEXT(45), "GovernmentForm" TEXT(45), "HeadOfState" TEXT(60), "Capital" INTEGER, "Code2" TEXT(2));

CREATE TABLE "countrylanguage" ("CountryCode" TEXT(3), "Language" TEXT(30), "IsOfficial" TEXT, "Percentage" REAL(4, 1), PRIMARY KEY ("CountryCode", "Language"), FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "country" ("Code", "Name", "Continent", "GNPOld", "Population") VALUES ('AF1', 'Zambia', 'Africa', 100.0, 5000);
INSERT INTO "country" ("Code", "Name", "Continent", "GNPOld", "Population") VALUES ('AF2', 'Algeria', 'Africa', 200.0, 10000);
INSERT INTO "country" ("Code", "Name", "Continent", "GNPOld", "Population") VALUES ('AS1', 'China', 'Asia', 300.0, 20000);
INSERT INTO "country" ("Code", "Name", "Continent", "GNPOld", "Population") VALUES ('EU1', 'France', 'Europe', 400.0, 15000);
INSERT INTO "country" ("Code", "Name", "Continent", "GNPOld", "Population") VALUES ('NA1', 'Canada', NULL, 500.0, 8000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT "gnpold", "name", MAX("population") AS "population" FROM (SELECT * FROM "country" WHERE ("continent" <> 'Asia' AND "continent" = 'Africa')) GROUP BY gnpold, name) ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
('Algeria',)
('Zambia',)
*/

-- Prediction Query
SELECT Name FROM country WHERE Continent = 'Africa' AND population < (SELECT MAX(population) FROM country WHERE Continent = 'Asia');

/*
Prediction Result:
('Zambia',)
('Algeria',)
*/