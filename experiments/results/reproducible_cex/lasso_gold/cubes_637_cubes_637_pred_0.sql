-- Schema DDL
CREATE TABLE "city" ("ID" INTEGER PRIMARY KEY, "CountryCode" TEXT(3), "Name" TEXT(35), "District" TEXT(20), "Population" INTEGER, FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

CREATE TABLE "country" ("Code" TEXT(3) PRIMARY KEY, "Name" TEXT(52), "Continent" TEXT, "Region" TEXT(26), "SurfaceArea" REAL(10, 2), "IndepYear" INTEGER, "Population" INTEGER, "LifeExpectancy" REAL(3, 1), "GNP" REAL(10, 2), "GNPOld" REAL(10, 2), "LocalName" TEXT(45), "GovernmentForm" TEXT(45), "HeadOfState" TEXT(60), "Capital" INTEGER, "Code2" TEXT(2));

CREATE TABLE "countrylanguage" ("CountryCode" TEXT(3), "Language" TEXT(30), "IsOfficial" TEXT, "Percentage" REAL(4, 1), PRIMARY KEY ("CountryCode", "Language"), FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "country" ("code", "name", "continent", "region", "surfacearea", "indepyear", "population", "lifeexpectancy", "gnp", "gnpold", "localname", "governmentform", "headofstate", "capital", "code2") VALUES ('chair', 'Brazil', 'employee', 'past', 1120.5, 1121, 1123, 1123.5, 1124.5, 1125.5, 'Hoffman', 'discuss', 'Florida', 1126, 'Mr');
INSERT INTO "country" ("code", "name", "continent", "region", "surfacearea", "indepyear", "population", "lifeexpectancy", "gnp", "gnpold", "localname", "governmentform", "headofstate", "capital", "code2") VALUES ('later', 'Brazil', 'water', 'size', 1127.5, 1122, 1122, 1130.5, 1131.5, 1132.5, 'Ross', 'everyone', 'West Virginia', 1127, 'pattern');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "population", "lifeexpectancy" FROM "country" WHERE ("name" = 'Brazil') ORDER BY population, country.code NULLS LAST;

/*
Gold Result:
(1122, 1130.5)
(1123, 1123.5)
*/

-- Prediction Query
SELECT Population, LifeExpectancy FROM country WHERE Name = 'Brazil';

/*
Prediction Result:
(1123, 1123.5)
(1122, 1130.5)
*/