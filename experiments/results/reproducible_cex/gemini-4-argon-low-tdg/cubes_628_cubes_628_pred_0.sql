-- Schema DDL
CREATE TABLE "city" ("ID" INTEGER PRIMARY KEY, "CountryCode" TEXT(3), "Name" TEXT(35), "District" TEXT(20), "Population" INTEGER, FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

CREATE TABLE "country" ("Code" TEXT(3) PRIMARY KEY, "Name" TEXT(52), "Continent" TEXT, "Region" TEXT(26), "SurfaceArea" REAL(10, 2), "IndepYear" INTEGER, "Population" INTEGER, "LifeExpectancy" REAL(3, 1), "GNP" REAL(10, 2), "GNPOld" REAL(10, 2), "LocalName" TEXT(45), "GovernmentForm" TEXT(45), "HeadOfState" TEXT(60), "Capital" INTEGER, "Code2" TEXT(2));

CREATE TABLE "countrylanguage" ("CountryCode" TEXT(3), "Language" TEXT(30), "IsOfficial" TEXT, "Percentage" REAL(4, 1), PRIMARY KEY ("CountryCode", "Language"), FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('NRU', 'Nauru', 'Oceania', 'Micronesia', 21.0, 1968, 12000, 60.8, 197.0, NULL, 'Naoero/Nauru', 'Republic', 'Bernard Dowiyogo', 2728, 'NR');
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('SMR', 'San Marino', 'Europe', 'Southern Europe', 61.0, 885, 27000, 81.1, 510.0, NULL, 'San Marino', 'Republic', NULL, 3171, 'SM');
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('AND', 'Andorra', 'Europe', 'Southern Europe', 468.0, 1278, 78000, 83.5, 1630.0, NULL, 'Andorra', 'Parliamentary Coprincipality', '', 55, 'AD');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT "code", "name", "continent", "region", "surfacearea", "indepyear", "population", "lifeexpectancy", "gnp", "gnpold", "localname", "governmentform", "headofstate", "capital", "code2", MIN("surfacearea") OVER () AS "minsurfacearea" FROM "country") WHERE ("continent" <> 'Europe' OR minsurfacearea < surfacearea) ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
('Andorra',)
('Nauru',)
('San Marino',)
*/

-- Prediction Query
SELECT Name FROM country WHERE SurfaceArea > (SELECT MIN(SurfaceArea) FROM country WHERE Continent = 'Europe');

/*
Prediction Result:
('Andorra',)
*/