-- Schema DDL
CREATE TABLE "city" ("ID" INTEGER PRIMARY KEY, "CountryCode" TEXT(3), "Name" TEXT(35), "District" TEXT(20), "Population" INTEGER, FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

CREATE TABLE "country" ("Code" TEXT(3) PRIMARY KEY, "Name" TEXT(52), "Continent" TEXT, "Region" TEXT(26), "SurfaceArea" REAL(10, 2), "IndepYear" INTEGER, "Population" INTEGER, "LifeExpectancy" REAL(3, 1), "GNP" REAL(10, 2), "GNPOld" REAL(10, 2), "LocalName" TEXT(45), "GovernmentForm" TEXT(45), "HeadOfState" TEXT(60), "Capital" INTEGER, "Code2" TEXT(2));

CREATE TABLE "countrylanguage" ("CountryCode" TEXT(3), "Language" TEXT(30), "IsOfficial" TEXT, "Percentage" REAL(4, 1), PRIMARY KEY ("CountryCode", "Language"), FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "Population") VALUES ('ZWE', 'Angola', 'Africa', 'Region_A', 5000);
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "Population") VALUES ('AAA', 'Angola', 'Africa', 'Region_A', 5000);
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "Population") VALUES ('BBB', 'Angola', 'Africa', 'Region_B', 1000);
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "Population") VALUES ('CCC', 'Angola', 'Africa', 'Region_C', NULL);
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "Population") VALUES ('DDD', 'Other', 'Africa', 'Region_D', 500);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "population", "region" FROM "country" WHERE ("name" = 'Angola') ORDER BY population, country.code NULLS LAST;

/*
Gold Result:
(None, 'Region_C')
(1000, 'Region_B')
(5000, 'Region_A')
(5000, 'Region_A')
*/

-- Prediction Query
SELECT Population, Region FROM country WHERE Name = 'Angola';

/*
Prediction Result:
(5000, 'Region_A')
(5000, 'Region_A')
(1000, 'Region_B')
(None, 'Region_C')
*/