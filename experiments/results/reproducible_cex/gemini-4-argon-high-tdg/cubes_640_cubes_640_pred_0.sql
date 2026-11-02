-- Schema DDL
CREATE TABLE "city" ("ID" INTEGER PRIMARY KEY, "CountryCode" TEXT(3), "Name" TEXT(35), "District" TEXT(20), "Population" INTEGER, FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

CREATE TABLE "country" ("Code" TEXT(3) PRIMARY KEY, "Name" TEXT(52), "Continent" TEXT, "Region" TEXT(26), "SurfaceArea" REAL(10, 2), "IndepYear" INTEGER, "Population" INTEGER, "LifeExpectancy" REAL(3, 1), "GNP" REAL(10, 2), "GNPOld" REAL(10, 2), "LocalName" TEXT(45), "GovernmentForm" TEXT(45), "HeadOfState" TEXT(60), "Capital" INTEGER, "Code2" TEXT(2));

CREATE TABLE "countrylanguage" ("CountryCode" TEXT(3), "Language" TEXT(30), "IsOfficial" TEXT, "Percentage" REAL(4, 1), PRIMARY KEY ("CountryCode", "Language"), FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('AG1', 'Angola', 'Africa', 'MediumPopRegion', 1000.0, 1975, 100, 40.0, 500.0, 400.0, 'Angola1', 'Republic', 'Head1', NULL, 'A1');
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('AG2', 'Angola', 'Africa', 'NullPopRegion', 2000.0, 1975, NULL, 41.0, 600.0, 500.0, 'Angola2', 'Republic', 'Head2', NULL, 'A2');
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('AG3', 'Angola', 'Africa', 'LargePopRegion', 3000.0, 1975, 5000, 42.0, 700.0, 600.0, 'Angola3', 'Republic', 'Head3', NULL, 'A3');
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('AG4', 'Angola', 'Africa', 'SmallPopRegion', 4000.0, 1975, 90, 43.0, 800.0, 700.0, 'Angola4', 'Republic', 'Head4', NULL, 'A4');
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('AG5', 'Angola', 'Africa', 'ZeroPopRegion', 5000.0, 1975, 0, 44.0, 900.0, 800.0, 'Angola5', 'Republic', 'Head5', NULL, 'A5');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "population", "region" FROM "country" WHERE ("name" = 'Angola') ORDER BY population, country.code NULLS LAST;

/*
Gold Result:
(None, 'NullPopRegion')
(0, 'ZeroPopRegion')
(90, 'SmallPopRegion')
(100, 'MediumPopRegion')
(5000, 'LargePopRegion')
*/

-- Prediction Query
SELECT Population, Region FROM country WHERE Name = 'Angola';

/*
Prediction Result:
(100, 'MediumPopRegion')
(None, 'NullPopRegion')
(5000, 'LargePopRegion')
(90, 'SmallPopRegion')
(0, 'ZeroPopRegion')
*/