-- Schema DDL
CREATE TABLE "city" ("ID" INTEGER PRIMARY KEY, "CountryCode" TEXT(3), "Name" TEXT(35), "District" TEXT(20), "Population" INTEGER, FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

CREATE TABLE "country" ("Code" TEXT(3) PRIMARY KEY, "Name" TEXT(52), "Continent" TEXT, "Region" TEXT(26), "SurfaceArea" REAL(10, 2), "IndepYear" INTEGER, "Population" INTEGER, "LifeExpectancy" REAL(3, 1), "GNP" REAL(10, 2), "GNPOld" REAL(10, 2), "LocalName" TEXT(45), "GovernmentForm" TEXT(45), "HeadOfState" TEXT(60), "Capital" INTEGER, "Code2" TEXT(2));

CREATE TABLE "countrylanguage" ("CountryCode" TEXT(3), "Language" TEXT(30), "IsOfficial" TEXT, "Percentage" REAL(4, 1), PRIMARY KEY ("CountryCode", "Language"), FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests 0 matching rows.
-- A window function COUNT(*) OVER () on an empty result set returns 0 rows (empty set),
-- whereas a standard aggregate SELECT COUNT(*) without GROUP BY would return 1 row with value 0.
INSERT INTO "country" ("Code", "Name", "GovernmentForm") VALUES ('GBR', 'United Kingdom', 'Constitutional Monarchy');
INSERT INTO "country" ("Code", "Name", "GovernmentForm") VALUES ('CAN', 'Canada', 'Constitutional Monarchy, Federation');
INSERT INTO "country" ("Code", "Name", "GovernmentForm") VALUES ('ATA', 'Antarctica', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT COUNT(*) OVER () AS "count___" FROM "country" WHERE ("governmentform" = 'Republic') ORDER BY count___;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(*) FROM country WHERE GovernmentForm = 'Republic';

/*
Prediction Result:
(0,)
*/