-- Schema DDL
CREATE TABLE "city" ("ID" INTEGER PRIMARY KEY, "CountryCode" TEXT(3), "Name" TEXT(35), "District" TEXT(20), "Population" INTEGER, FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

CREATE TABLE "country" ("Code" TEXT(3) PRIMARY KEY, "Name" TEXT(52), "Continent" TEXT, "Region" TEXT(26), "SurfaceArea" REAL(10, 2), "IndepYear" INTEGER, "Population" INTEGER, "LifeExpectancy" REAL(3, 1), "GNP" REAL(10, 2), "GNPOld" REAL(10, 2), "LocalName" TEXT(45), "GovernmentForm" TEXT(45), "HeadOfState" TEXT(60), "Capital" INTEGER, "Code2" TEXT(2));

CREATE TABLE "countrylanguage" ("CountryCode" TEXT(3), "Language" TEXT(30), "IsOfficial" TEXT, "Percentage" REAL(4, 1), PRIMARY KEY ("CountryCode", "Language"), FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('AAA', 'Caribbean', 'Caribbean', 'caribbean', 100.00, 1900, 1000, 70.0, 500.00, 450.00, 'Caribbean', 'Republic', 'Leader A', 1, 'AA');
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('BBB', 'Country B', 'North America', 'East Caribbean', 200.00, 1950, 2000, 75.0, 600.00, 550.00, 'Local B', 'Republic', 'Leader B', 2, 'BB');
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('CCC', 'Country C', 'South America', NULL, 300.00, 1980, 3000, 80.0, 700.00, 650.00, 'Local C', 'Republic', 'Leader C', NULL, 'CC');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "sumsurfacearea" AS "sum_surfacearea_" FROM (SELECT "region", SUM("surfacearea") AS "sumsurfacearea" FROM "country" GROUP BY "region") WHERE ("region" = 'Caribbean') ORDER BY sum_surfacearea_;

/*
Gold Result:
*/

-- Prediction Query
SELECT SUM(SurfaceArea) FROM country WHERE Region = 'Caribbean';

/*
Prediction Result:
(None,)
*/