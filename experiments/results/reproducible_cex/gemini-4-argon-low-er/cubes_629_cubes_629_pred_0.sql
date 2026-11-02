-- Schema DDL
CREATE TABLE "city" ("ID" INTEGER PRIMARY KEY, "CountryCode" TEXT(3), "Name" TEXT(35), "District" TEXT(20), "Population" INTEGER, FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

CREATE TABLE "country" ("Code" TEXT(3) PRIMARY KEY, "Name" TEXT(52), "Continent" TEXT, "Region" TEXT(26), "SurfaceArea" REAL(10, 2), "IndepYear" INTEGER, "Population" INTEGER, "LifeExpectancy" REAL(3, 1), "GNP" REAL(10, 2), "GNPOld" REAL(10, 2), "LocalName" TEXT(45), "GovernmentForm" TEXT(45), "HeadOfState" TEXT(60), "Capital" INTEGER, "Code2" TEXT(2));

CREATE TABLE "countrylanguage" ("CountryCode" TEXT(3), "Language" TEXT(30), "IsOfficial" TEXT, "Percentage" REAL(4, 1), PRIMARY KEY ("CountryCode", "Language"), FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "country" ("Code", "Name", "Continent", "Population", "GNPOld") VALUES ('AFR', 'AfricaCountry', 'Africa', 1000, 100.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT "gnpold", "name", MAX("population") AS "population" FROM (SELECT * FROM "country" WHERE ("continent" <> 'Asia' AND "continent" = 'Africa')) GROUP BY gnpold, name) ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
('AfricaCountry',)
*/

-- Prediction Query
SELECT Name FROM country WHERE Continent = 'Africa' AND population < (SELECT MAX(population) FROM country WHERE Continent = 'Asia');

/*
Prediction Result:
*/