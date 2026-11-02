-- Schema DDL
CREATE TABLE "city" ("ID" INTEGER PRIMARY KEY, "CountryCode" TEXT(3), "Name" TEXT(35), "District" TEXT(20), "Population" INTEGER, FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

CREATE TABLE "country" ("Code" TEXT(3) PRIMARY KEY, "Name" TEXT(52), "Continent" TEXT, "Region" TEXT(26), "SurfaceArea" REAL(10, 2), "IndepYear" INTEGER, "Population" INTEGER, "LifeExpectancy" REAL(3, 1), "GNP" REAL(10, 2), "GNPOld" REAL(10, 2), "LocalName" TEXT(45), "GovernmentForm" TEXT(45), "HeadOfState" TEXT(60), "Capital" INTEGER, "Code2" TEXT(2));

CREATE TABLE "countrylanguage" ("CountryCode" TEXT(3), "Language" TEXT(30), "IsOfficial" TEXT, "Percentage" REAL(4, 1), PRIMARY KEY ("CountryCode", "Language"), FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO country (Code, Name, Continent, Region, SurfaceArea, IndepYear, Population, LifeExpectancy, GNP, GNPOld, LocalName, GovernmentForm, HeadOfState, Capital, Code2) VALUES ('AAA', 'AlphaLand', 'Europe', 'Western Europe', 1000.0, 1900, 999999, 80.0, 100.0, 90.0, 'Alpha', 'Republic', 'Leader A', 1, 'AA');
INSERT INTO country (Code, Name, Continent, Region, SurfaceArea, IndepYear, Population, LifeExpectancy, GNP, GNPOld, LocalName, GovernmentForm, HeadOfState, Capital, Code2) VALUES ('MMM', 'MiddleLand', 'Europe', 'Western Europe', 2000.0, 1950, 888888, 75.0, 200.0, 180.0, 'Middle', 'Republic', 'Leader M', 3, 'MM');
INSERT INTO country (Code, Name, Continent, Region, SurfaceArea, IndepYear, Population, LifeExpectancy, GNP, GNPOld, LocalName, GovernmentForm, HeadOfState, Capital, Code2) VALUES ('ZZZ', 'ZetaLand', 'Europe', 'Western Europe', 3000.0, 2000, 777777, 70.0, 300.0, 270.0, 'Zeta', 'Republic', 'Leader Z', 5, 'ZZ');
INSERT INTO city (ID, CountryCode, Name, District, Population) VALUES (1, 'AAA', 'AlphaCity1', 'Gelderland', 250);
INSERT INTO city (ID, CountryCode, Name, District, Population) VALUES (2, 'AAA', 'AlphaCity2', 'Gelderland', 350);
INSERT INTO city (ID, CountryCode, Name, District, Population) VALUES (3, 'MMM', 'MiddleCity1', 'Gelderland', 400);
INSERT INTO city (ID, CountryCode, Name, District, Population) VALUES (4, 'MMM', 'MiddleCity2', 'OtherDistrict', 900);
INSERT INTO city (ID, CountryCode, Name, District, Population) VALUES (5, 'ZZZ', 'ZetaCity1', 'Gelderland', 100);
INSERT INTO city (ID, CountryCode, Name, District, Population) VALUES (6, 'ZZZ', 'ZetaCity2', 'Gelderland', 100);
INSERT INTO countrylanguage (CountryCode, Language, IsOfficial, Percentage) VALUES ('ZZZ', 'Zetan', 'T', 60.0);
INSERT INTO countrylanguage (CountryCode, Language, IsOfficial, Percentage) VALUES ('ZZZ', 'English', 'F', 40.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "sumpopulation" AS "sum_population_" FROM (SELECT "countrycode", "district", SUM("population") AS "sumpopulation" FROM "city" GROUP BY "countrycode", "district") WHERE ("district" = 'Gelderland') ORDER BY sum_population_;

/*
Gold Result:
(200,)
(400,)
(600,)
*/

-- Prediction Query
SELECT SUM(Population) FROM city WHERE District = 'Gelderland';

/*
Prediction Result:
(1200,)
*/