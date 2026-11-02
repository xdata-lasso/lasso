-- Schema DDL
CREATE TABLE "city" ("ID" INTEGER PRIMARY KEY, "CountryCode" TEXT(3), "Name" TEXT(35), "District" TEXT(20), "Population" INTEGER, FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

CREATE TABLE "country" ("Code" TEXT(3) PRIMARY KEY, "Name" TEXT(52), "Continent" TEXT, "Region" TEXT(26), "SurfaceArea" REAL(10, 2), "IndepYear" INTEGER, "Population" INTEGER, "LifeExpectancy" REAL(3, 1), "GNP" REAL(10, 2), "GNPOld" REAL(10, 2), "LocalName" TEXT(45), "GovernmentForm" TEXT(45), "HeadOfState" TEXT(60), "Capital" INTEGER, "Code2" TEXT(2));

CREATE TABLE "countrylanguage" ("CountryCode" TEXT(3), "Language" TEXT(30), "IsOfficial" TEXT, "Percentage" REAL(4, 1), PRIMARY KEY ("CountryCode", "Language"), FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "country" ("Code", "Name", "Population", "LifeExpectancy") VALUES ('BR1', 'Brazil', 200, 70.0);
INSERT INTO "country" ("Code", "Name", "Population", "LifeExpectancy") VALUES ('BR2', 'Brazil', 100, 75.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "population", "lifeexpectancy" FROM "country" WHERE ("name" = 'Brazil') ORDER BY population, country.code NULLS LAST;

/*
Gold Result:
(100, 75.0)
(200, 70.0)
*/

-- Prediction Query
SELECT Population, LifeExpectancy FROM country WHERE Name = 'Brazil';

/*
Prediction Result:
(200, 70.0)
(100, 75.0)
*/