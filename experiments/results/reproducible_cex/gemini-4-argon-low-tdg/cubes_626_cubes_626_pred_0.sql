-- Schema DDL
CREATE TABLE "city" ("ID" INTEGER PRIMARY KEY, "CountryCode" TEXT(3), "Name" TEXT(35), "District" TEXT(20), "Population" INTEGER, FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

CREATE TABLE "country" ("Code" TEXT(3) PRIMARY KEY, "Name" TEXT(52), "Continent" TEXT, "Region" TEXT(26), "SurfaceArea" REAL(10, 2), "IndepYear" INTEGER, "Population" INTEGER, "LifeExpectancy" REAL(3, 1), "GNP" REAL(10, 2), "GNPOld" REAL(10, 2), "LocalName" TEXT(45), "GovernmentForm" TEXT(45), "HeadOfState" TEXT(60), "Capital" INTEGER, "Code2" TEXT(2));

CREATE TABLE "countrylanguage" ("CountryCode" TEXT(3), "Language" TEXT(30), "IsOfficial" TEXT, "Percentage" REAL(4, 1), PRIMARY KEY ("CountryCode", "Language"), FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('USA', 'United States', 'North America', 'North America', 9363520.0, 1776, 278357000, 77.1, 8510700.0, 8110900.0, 'United States', 'Federal Republic', 'George W. Bush', 1, 'US');
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('CAN', 'Canada', 'North America', 'North America', 9970610.0, 1867, 31147000, 79.4, 598862.0, 625626.0, 'Canada', 'Constitutional Monarchy', 'Elizabeth II', 2, 'CA');
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