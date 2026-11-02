-- Schema DDL
CREATE TABLE "city" ("ID" INTEGER PRIMARY KEY, "CountryCode" TEXT(3), "Name" TEXT(35), "District" TEXT(20), "Population" INTEGER, FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

CREATE TABLE "country" ("Code" TEXT(3) PRIMARY KEY, "Name" TEXT(52), "Continent" TEXT, "Region" TEXT(26), "SurfaceArea" REAL(10, 2), "IndepYear" INTEGER, "Population" INTEGER, "LifeExpectancy" REAL(3, 1), "GNP" REAL(10, 2), "GNPOld" REAL(10, 2), "LocalName" TEXT(45), "GovernmentForm" TEXT(45), "HeadOfState" TEXT(60), "Capital" INTEGER, "Code2" TEXT(2));

CREATE TABLE "countrylanguage" ("CountryCode" TEXT(3), "Language" TEXT(30), "IsOfficial" TEXT, "Percentage" REAL(4, 1), PRIMARY KEY ("CountryCode", "Language"), FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO country (Code, Name, Continent, Region, SurfaceArea, IndepYear, Population, LifeExpectancy, GNP, GNPOld, LocalName, GovernmentForm, HeadOfState, Capital, Code2) VALUES ('AF1', 'Kingdom A', 'Africa', 'Northern Africa', 1500.0, 1955, 250000, 62.0, 400.0, 380.0, 'Kingdom A', 'Monarchy', 'King A', 1, 'KA');
INSERT INTO country (Code, Name, Continent, Region, SurfaceArea, IndepYear, Population, LifeExpectancy, GNP, GNPOld, LocalName, GovernmentForm, HeadOfState, Capital, Code2) VALUES ('EU1', 'EuroRep', 'Europe', 'Western Europe', 2500.0, 1850, 500000, 79.5, 1500.0, 1400.0, 'EuroRep', 'Republic', 'Pres E', 2, 'ER');
INSERT INTO country (Code, Name, Continent, Region, SurfaceArea, IndepYear, Population, LifeExpectancy, GNP, GNPOld, LocalName, GovernmentForm, HeadOfState, Capital, Code2) VALUES ('AS1', 'AsiaFed', 'Asia', 'Southern Asia', 3500.0, 1947, 900000, 68.0, 1200.0, 1100.0, 'AsiaFed', 'Federal Republic', 'Pres A', 3, 'AF');
INSERT INTO city (ID, CountryCode, Name, District, Population) VALUES (1, 'AF1', 'Royal City', 'Core', 60000);
INSERT INTO city (ID, CountryCode, Name, District, Population) VALUES (2, 'EU1', 'Euro Capital', 'Center', 150000);
INSERT INTO city (ID, CountryCode, Name, District, Population) VALUES (3, 'AS1', 'Fed City', 'Main', 200000);
INSERT INTO countrylanguage (CountryCode, Language, IsOfficial, Percentage) VALUES ('AF1', 'Berber', 'T', 85.0);
INSERT INTO countrylanguage (CountryCode, Language, IsOfficial, Percentage) VALUES ('EU1', 'German', 'T', 95.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "meanlifeexpectancy" AS "avg_lifeexpectancy_" FROM (SELECT "continent", "governmentform", AVG("lifeexpectancy") AS "meanlifeexpectancy" FROM "country" GROUP BY "continent", "governmentform") WHERE ("governmentform" = 'Republic' AND "continent" = 'Africa') ORDER BY avg_lifeexpectancy_;

/*
Gold Result:
*/

-- Prediction Query
SELECT AVG(LifeExpectancy) FROM country WHERE Continent = 'Africa' AND GovernmentForm = 'Republic';

/*
Prediction Result:
(None,)
*/