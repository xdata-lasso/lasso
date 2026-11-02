-- Schema DDL
CREATE TABLE "city" ("ID" INTEGER PRIMARY KEY, "CountryCode" TEXT(3), "Name" TEXT(35), "District" TEXT(20), "Population" INTEGER, FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

CREATE TABLE "country" ("Code" TEXT(3) PRIMARY KEY, "Name" TEXT(52), "Continent" TEXT, "Region" TEXT(26), "SurfaceArea" REAL(10, 2), "IndepYear" INTEGER, "Population" INTEGER, "LifeExpectancy" REAL(3, 1), "GNP" REAL(10, 2), "GNPOld" REAL(10, 2), "LocalName" TEXT(45), "GovernmentForm" TEXT(45), "HeadOfState" TEXT(60), "Capital" INTEGER, "Code2" TEXT(2));

CREATE TABLE "countrylanguage" ("CountryCode" TEXT(3), "Language" TEXT(30), "IsOfficial" TEXT, "Percentage" REAL(4, 1), PRIMARY KEY ("CountryCode", "Language"), FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('C01', 'Country One', 'ZetaContinent', 'Central Africa', 1000.0, 1990, 100000, 40.0, 500.0, 400.0, 'C1', 'Republic', 'Leader 1', 1, 'C1');
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('C02', 'Country Two', 'ZetaContinent', 'Central Africa', 2000.0, 1991, 200000, 50.0, 600.0, 500.0, 'C2', 'Republic', 'Leader 2', 2, 'C2');
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('C03', 'Country Three', 'AlphaContinent', 'Central Africa', 3000.0, 1992, 300000, 70.0, 700.0, 600.0, 'C3', 'Republic', 'Leader 3', 3, 'C3');
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('C04', 'Country Four', 'AlphaContinent', 'Central Africa', 4000.0, 1993, 400000, 80.0, 800.0, 700.0, 'C4', 'Republic', 'Leader 4', 4, 'C4');
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('C05', 'Country Five', 'BetaContinent', 'Central Africa', 5000.0, 1994, 500000, 45.0, 900.0, 800.0, 'C5', 'Republic', 'Leader 5', 5, 'C5');
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('C06', 'Country Six', 'AlphaContinent', 'Eastern Africa', 6000.0, 1995, 600000, 20.0, 100.0, 100.0, 'C6', 'Republic', 'Leader 6', 6, 'C6');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "meanlifeexpectancy" AS "avg_lifeexpectancy_" FROM (SELECT "continent", AVG("lifeexpectancy") AS "meanlifeexpectancy" FROM (SELECT * FROM "country" WHERE ("region" = 'Central Africa')) GROUP BY continent) ORDER BY avg_lifeexpectancy_;

/*
Gold Result:
(45.0,)
(45.0,)
(75.0,)
*/

-- Prediction Query
SELECT AVG(LifeExpectancy) FROM country WHERE Region = 'Central Africa';

/*
Prediction Result:
(57.0,)
*/