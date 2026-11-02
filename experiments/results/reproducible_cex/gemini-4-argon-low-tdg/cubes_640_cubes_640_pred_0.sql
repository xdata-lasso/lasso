-- Schema DDL
CREATE TABLE "city" ("ID" INTEGER PRIMARY KEY, "CountryCode" TEXT(3), "Name" TEXT(35), "District" TEXT(20), "Population" INTEGER, FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

CREATE TABLE "country" ("Code" TEXT(3) PRIMARY KEY, "Name" TEXT(52), "Continent" TEXT, "Region" TEXT(26), "SurfaceArea" REAL(10, 2), "IndepYear" INTEGER, "Population" INTEGER, "LifeExpectancy" REAL(3, 1), "GNP" REAL(10, 2), "GNPOld" REAL(10, 2), "LocalName" TEXT(45), "GovernmentForm" TEXT(45), "HeadOfState" TEXT(60), "Capital" INTEGER, "Code2" TEXT(2));

CREATE TABLE "countrylanguage" ("CountryCode" TEXT(3), "Language" TEXT(30), "IsOfficial" TEXT, "Percentage" REAL(4, 1), PRIMARY KEY ("CountryCode", "Language"), FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('AG3', 'Angola', 'Africa', 'Central Africa', 100.0, 1975, 5000, 40.0, 100.0, 100.0, 'Angola', 'Republic', 'Head1', 1, 'A3');
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('AG1', 'Angola', 'Africa', 'Southern Africa', 200.0, 1975, 1000, 45.0, 200.0, 200.0, 'Angola', 'Republic', 'Head2', 2, 'A1');
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('AG2', 'Angola', 'Africa', 'Central Africa', 150.0, 1975, 1000, 42.0, 150.0, 150.0, 'Angola', 'Republic', 'Head3', 3, 'A2');
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES (NULL, 'Angola', 'Africa', 'Western Africa', 300.0, 1975, 1000, 50.0, 300.0, 300.0, 'Angola', 'Republic', 'Head4', 4, 'A4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "population", "region" FROM "country" WHERE ("name" = 'Angola') ORDER BY population, country.code NULLS LAST;

/*
Gold Result:
(1000, 'Southern Africa')
(1000, 'Central Africa')
(1000, 'Western Africa')
(5000, 'Central Africa')
*/

-- Prediction Query
SELECT Population, Region FROM country WHERE Name = 'Angola';

/*
Prediction Result:
(5000, 'Central Africa')
(1000, 'Southern Africa')
(1000, 'Central Africa')
(1000, 'Western Africa')
*/