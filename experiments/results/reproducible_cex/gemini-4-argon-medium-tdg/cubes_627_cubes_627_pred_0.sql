-- Schema DDL
CREATE TABLE "city" ("ID" INTEGER PRIMARY KEY, "CountryCode" TEXT(3), "Name" TEXT(35), "District" TEXT(20), "Population" INTEGER, FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

CREATE TABLE "country" ("Code" TEXT(3) PRIMARY KEY, "Name" TEXT(52), "Continent" TEXT, "Region" TEXT(26), "SurfaceArea" REAL(10, 2), "IndepYear" INTEGER, "Population" INTEGER, "LifeExpectancy" REAL(3, 1), "GNP" REAL(10, 2), "GNPOld" REAL(10, 2), "LocalName" TEXT(45), "GovernmentForm" TEXT(45), "HeadOfState" TEXT(60), "Capital" INTEGER, "Code2" TEXT(2));

CREATE TABLE "countrylanguage" ("CountryCode" TEXT(3), "Language" TEXT(30), "IsOfficial" TEXT, "Percentage" REAL(4, 1), PRIMARY KEY ("CountryCode", "Language"), FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests behavior when 0 rows match the WHERE clause (Window function returns 0 rows vs standard aggregate COUNT(*) returning 0). Also tests NULL, case sensitivity, and substring matching.
INSERT INTO "country" ("Code", "Name", "GovernmentForm") VALUES ('C01', 'Alpha', 'Monarchy');
INSERT INTO "country" ("Code", "Name", "GovernmentForm") VALUES ('C02', 'Beta', 'Federal Republic');
INSERT INTO "country" ("Code", "Name", "GovernmentForm") VALUES ('C03', 'Gamma', 'Republica');
INSERT INTO "country" ("Code", "Name", "GovernmentForm") VALUES ('C04', 'Delta', 'republic');
INSERT INTO "country" ("Code", "Name", "GovernmentForm") VALUES ('C05', 'Epsilon', NULL);
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