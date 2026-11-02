-- Schema DDL
CREATE TABLE "city" ("ID" INTEGER PRIMARY KEY, "CountryCode" TEXT(3), "Name" TEXT(35), "District" TEXT(20), "Population" INTEGER, FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

CREATE TABLE "country" ("Code" TEXT(3) PRIMARY KEY, "Name" TEXT(52), "Continent" TEXT, "Region" TEXT(26), "SurfaceArea" REAL(10, 2), "IndepYear" INTEGER, "Population" INTEGER, "LifeExpectancy" REAL(3, 1), "GNP" REAL(10, 2), "GNPOld" REAL(10, 2), "LocalName" TEXT(45), "GovernmentForm" TEXT(45), "HeadOfState" TEXT(60), "Capital" INTEGER, "Code2" TEXT(2));

CREATE TABLE "countrylanguage" ("CountryCode" TEXT(3), "Language" TEXT(30), "IsOfficial" TEXT, "Percentage" REAL(4, 1), PRIMARY KEY ("CountryCode", "Language"), FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('BR3', 'Brazil', 'South America', 'South America', 500000.00, 1822, 200000, 72.5, 50000.00, 45000.00, 'Brasil', 'Republic', 'Leader C', 3, 'B3');
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('BR2', 'Brazil', 'South America', 'South America', 400000.00, 1822, 100000, 68.1, 40000.00, 35000.00, 'Brasil', 'Republic', 'Leader B', 2, 'B2');
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('BR1', 'Brazil', 'South America', 'South America', 300000.00, 1822, 100000, 75.4, 30000.00, 25000.00, 'Brasil', 'Republic', 'Leader A', 1, 'B1');
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('CHL', 'Chile', 'South America', 'South America', 756626.00, 1810, 15211000, 75.7, 72949.00, 75780.00, 'Chile', 'Republic', 'Ricardo Lagos Escobar', 554, 'CL');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "population", "lifeexpectancy" FROM "country" WHERE ("name" = 'Brazil') ORDER BY population, country.code NULLS LAST;

/*
Gold Result:
(100000, 75.4)
(100000, 68.1)
(200000, 72.5)
*/

-- Prediction Query
SELECT Population, LifeExpectancy FROM country WHERE Name = 'Brazil';

/*
Prediction Result:
(200000, 72.5)
(100000, 68.1)
(100000, 75.4)
*/