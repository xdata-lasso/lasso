-- Schema DDL
CREATE TABLE "city" ("ID" INTEGER PRIMARY KEY, "CountryCode" TEXT(3), "Name" TEXT(35), "District" TEXT(20), "Population" INTEGER, FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

CREATE TABLE "country" ("Code" TEXT(3) PRIMARY KEY, "Name" TEXT(52), "Continent" TEXT, "Region" TEXT(26), "SurfaceArea" REAL(10, 2), "IndepYear" INTEGER, "Population" INTEGER, "LifeExpectancy" REAL(3, 1), "GNP" REAL(10, 2), "GNPOld" REAL(10, 2), "LocalName" TEXT(45), "GovernmentForm" TEXT(45), "HeadOfState" TEXT(60), "Capital" INTEGER, "Code2" TEXT(2));

CREATE TABLE "countrylanguage" ("CountryCode" TEXT(3), "Language" TEXT(30), "IsOfficial" TEXT, "Percentage" REAL(4, 1), PRIMARY KEY ("CountryCode", "Language"), FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('CAF', 'Central African Republic', 'Africa', 'Central Africa', 622984.0, 1960, 3615000, 40.0, 1054.0, 993.0, 'Centrafrique', 'Republic', 'Ange-Felix Patasse', 1, 'CF');
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('TCD', 'Chad', 'Africa', 'Central Africa', 1284000.0, 1960, 7651000, 50.0, 1208.0, 1102.0, 'Tchad', 'Republic', 'Idriss Deby', 2, 'TD');
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('CMR', 'Cameroon', 'Africa', 'Central Africa', 475442.0, 1960, 15085000, 50.0, 9174.0, 8596.0, 'Cameroun', 'Republic', 'Paul Biya', 3, 'CM');
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('GAB', 'Gabon', 'Africa', 'Central Africa', 267667.0, 1960, 1226000, NULL, 5493.0, 5279.0, 'Le Gabon', 'Republic', 'Omar Bongo', 4, 'GA');
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('NGA', 'Nigeria', 'Africa', 'Western Africa', 923768.0, 1960, 111506000, 51.6, 65707.0, 58623.0, 'Nigeria', 'Federal Republic', 'Olusegun Obasanjo', 5, 'NG');
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('XX1', 'TestLand1', 'Asia', 'Central Africa', 1000.0, 2000, 50000, 30.0, 500.0, 400.0, 'Test1', 'Republic', 'Leader1', 6, 'X1');
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('XX2', 'TestLand2', 'Europe', 'Central Africa', 2000.0, 2000, 60000, 80.0, 600.0, 500.0, 'Test2', 'Republic', 'Leader2', 7, 'X2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "meanlifeexpectancy" AS "avg_lifeexpectancy_" FROM (SELECT "continent", AVG("lifeexpectancy") AS "meanlifeexpectancy" FROM (SELECT * FROM "country" WHERE ("region" = 'Central Africa')) GROUP BY continent) ORDER BY avg_lifeexpectancy_;

/*
Gold Result:
(30.0,)
(46.666666666666664,)
(80.0,)
*/

-- Prediction Query
SELECT AVG(LifeExpectancy) FROM country WHERE Region = 'Central Africa';

/*
Prediction Result:
(50.0,)
*/