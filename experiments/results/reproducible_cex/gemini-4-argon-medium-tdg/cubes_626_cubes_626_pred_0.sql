-- Schema DDL
CREATE TABLE "city" ("ID" INTEGER PRIMARY KEY, "CountryCode" TEXT(3), "Name" TEXT(35), "District" TEXT(20), "Population" INTEGER, FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

CREATE TABLE "country" ("Code" TEXT(3) PRIMARY KEY, "Name" TEXT(52), "Continent" TEXT, "Region" TEXT(26), "SurfaceArea" REAL(10, 2), "IndepYear" INTEGER, "Population" INTEGER, "LifeExpectancy" REAL(3, 1), "GNP" REAL(10, 2), "GNPOld" REAL(10, 2), "LocalName" TEXT(45), "GovernmentForm" TEXT(45), "HeadOfState" TEXT(60), "Capital" INTEGER, "Code2" TEXT(2));

CREATE TABLE "countrylanguage" ("CountryCode" TEXT(3), "Language" TEXT(30), "IsOfficial" TEXT, "Percentage" REAL(4, 1), PRIMARY KEY ("CountryCode", "Language"), FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests empty result set when 'Caribbean' is absent, plus string boundary/case-sensitivity/LIKE mutations
-- Distinguishes GROUP BY + WHERE (returns 0 rows) from ungrouped SELECT SUM(...) WHERE ... (returns 1 row with NULL)
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('C1', 'Country1', 'North America', 'caribbean', 100.0, 1900, 1000, 70.0, 100.0, 90.0, 'C1', 'Republic', 'H1', NULL, 'C1');
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('C2', 'Country2', 'North America', 'Caribbean ', 200.0, 1900, 1000, 70.0, 100.0, 90.0, 'C2', 'Republic', 'H2', NULL, 'C2');
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('C3', 'Country3', 'North America', 'West Caribbean', 300.0, 1900, 1000, 70.0, 100.0, 90.0, 'C3', 'Republic', 'H3', NULL, 'C3');
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('C4', 'Caribbean', 'Caribbean', 'Central America', 400.0, 1900, 1000, 70.0, 100.0, 90.0, 'Caribbean', 'Caribbean', 'Caribbean', NULL, 'C4');
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