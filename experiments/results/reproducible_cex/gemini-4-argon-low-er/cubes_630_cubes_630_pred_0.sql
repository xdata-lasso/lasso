-- Schema DDL
CREATE TABLE "city" ("ID" INTEGER PRIMARY KEY, "CountryCode" TEXT(3), "Name" TEXT(35), "District" TEXT(20), "Population" INTEGER, FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

CREATE TABLE "country" ("Code" TEXT(3) PRIMARY KEY, "Name" TEXT(52), "Continent" TEXT, "Region" TEXT(26), "SurfaceArea" REAL(10, 2), "IndepYear" INTEGER, "Population" INTEGER, "LifeExpectancy" REAL(3, 1), "GNP" REAL(10, 2), "GNPOld" REAL(10, 2), "LocalName" TEXT(45), "GovernmentForm" TEXT(45), "HeadOfState" TEXT(60), "Capital" INTEGER, "Code2" TEXT(2));

CREATE TABLE "countrylanguage" ("CountryCode" TEXT(3), "Language" TEXT(30), "IsOfficial" TEXT, "Percentage" REAL(4, 1), PRIMARY KEY ("CountryCode", "Language"), FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "LifeExpectancy") VALUES ('AAA', 'CountryA', 'Africa', 'Central Africa', 50.0);
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "LifeExpectancy") VALUES ('BBB', 'CountryB', 'Europe', 'Central Africa', 70.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "meanlifeexpectancy" AS "avg_lifeexpectancy_" FROM (SELECT "continent", AVG("lifeexpectancy") AS "meanlifeexpectancy" FROM (SELECT * FROM "country" WHERE ("region" = 'Central Africa')) GROUP BY continent) ORDER BY avg_lifeexpectancy_;

/*
Gold Result:
(50.0,)
(70.0,)
*/

-- Prediction Query
SELECT AVG(LifeExpectancy) FROM country WHERE Region = 'Central Africa';

/*
Prediction Result:
(60.0,)
*/