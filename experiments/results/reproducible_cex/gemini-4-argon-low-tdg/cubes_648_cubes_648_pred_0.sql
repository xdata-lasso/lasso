-- Schema DDL
CREATE TABLE "city" ("ID" INTEGER PRIMARY KEY, "CountryCode" TEXT(3), "Name" TEXT(35), "District" TEXT(20), "Population" INTEGER, FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

CREATE TABLE "country" ("Code" TEXT(3) PRIMARY KEY, "Name" TEXT(52), "Continent" TEXT, "Region" TEXT(26), "SurfaceArea" REAL(10, 2), "IndepYear" INTEGER, "Population" INTEGER, "LifeExpectancy" REAL(3, 1), "GNP" REAL(10, 2), "GNPOld" REAL(10, 2), "LocalName" TEXT(45), "GovernmentForm" TEXT(45), "HeadOfState" TEXT(60), "Capital" INTEGER, "Code2" TEXT(2));

CREATE TABLE "countrylanguage" ("CountryCode" TEXT(3), "Language" TEXT(30), "IsOfficial" TEXT, "Percentage" REAL(4, 1), PRIMARY KEY ("CountryCode", "Language"), FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO country (Code, Name, Continent, Region, SurfaceArea, IndepYear, Population, LifeExpectancy, GNP, GNPOld, LocalName, GovernmentForm, HeadOfState, Capital, Code2) VALUES ('AB1', 'Aruba', 'North America', 'Caribbean', 193.0, 1986, 100000, 78.0, 800.0, 750.0, 'Aruba1', 'Republic', 'Head1', 1, 'A1');
INSERT INTO country (Code, Name, Continent, Region, SurfaceArea, IndepYear, Population, LifeExpectancy, GNP, GNPOld, LocalName, GovernmentForm, HeadOfState, Capital, Code2) VALUES ('AB2', 'Aruba', 'South America', 'Caribbean', 200.0, 1990, 50000, 75.0, 500.0, 450.0, 'Aruba2', 'Republic', 'Head2', 2, 'A2');
INSERT INTO country (Code, Name, Continent, Region, SurfaceArea, IndepYear, Population, LifeExpectancy, GNP, GNPOld, LocalName, GovernmentForm, HeadOfState, Capital, Code2) VALUES ('AB3', 'Aruba', 'Europe', 'Southern Europe', 150.0, 2000, 25000, 80.0, 300.0, 250.0, 'Aruba3', 'Monarchy', 'Head3', 3, 'A3');
INSERT INTO country (Code, Name, Continent, Region, SurfaceArea, IndepYear, Population, LifeExpectancy, GNP, GNPOld, LocalName, GovernmentForm, HeadOfState, Capital, Code2) VALUES ('XYZ', 'NotAruba', 'Asia', 'Eastern Asia', 500.0, 1950, 200000, 70.0, 1000.0, 900.0, 'Aruba', 'Republic', 'Aruba', 4, 'XY');
INSERT INTO countrylanguage (CountryCode, Language, IsOfficial, Percentage) VALUES ('AB1', 'Lang1', 'T', 50.0);
INSERT INTO countrylanguage (CountryCode, Language, IsOfficial, Percentage) VALUES ('AB1', 'Lang2', 'F', 30.0);
INSERT INTO countrylanguage (CountryCode, Language, IsOfficial, Percentage) VALUES ('AB1', 'Lang3', 'F', 20.0);
INSERT INTO countrylanguage (CountryCode, Language, IsOfficial, Percentage) VALUES ('AB2', 'Lang1', 'T', 100.0);
INSERT INTO countrylanguage (CountryCode, Language, IsOfficial, Percentage) VALUES ('AB3', 'Lang1', 'T', 60.0);
INSERT INTO countrylanguage (CountryCode, Language, IsOfficial, Percentage) VALUES ('AB3', 'Lang4', 'F', 40.0);
INSERT INTO countrylanguage (CountryCode, Language, IsOfficial, Percentage) VALUES ('XYZ', 'Aruba', 'T', 100.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n" AS "count_t2_language_" FROM (SELECT "countrycode", COUNT(*) AS "n" FROM (SELECT * FROM (SELECT "countrycode", "language", "isofficial", "percentage", "name", "continent", "region", "surfacearea", "indepyear", "population", "lifeexpectancy", "gnp", "gnpold", "localname", "governmentform", "headofstate", "capital", "code2", "countrycode" AS "code" FROM (SELECT "LHS"."countrycode" AS "countrycode", "LHS"."language" AS "language", "LHS"."isofficial" AS "isofficial", "LHS"."percentage" AS "percentage", "RHS"."name" AS "name", "RHS"."continent" AS "continent", "RHS"."region" AS "region", "RHS"."surfacearea" AS "surfacearea", "RHS"."indepyear" AS "indepyear", "RHS"."population" AS "population", "RHS"."lifeexpectancy" AS "lifeexpectancy", "RHS"."gnp" AS "gnp", "RHS"."gnpold" AS "gnpold", "RHS"."localname" AS "localname", "RHS"."governmentform" AS "governmentform", "RHS"."headofstate" AS "headofstate", "RHS"."capital" AS "capital", "RHS"."code2" AS "code2" FROM "countrylanguage" AS "LHS" INNER JOIN "country" AS "RHS" ON ("LHS"."countrycode" = "RHS"."code"))) WHERE ("name" = 'Aruba')) GROUP BY countrycode) ORDER BY count_t2_language_;

/*
Gold Result:
(1,)
(2,)
(3,)
*/

-- Prediction Query
SELECT COUNT(T2.Language) FROM country AS T1 JOIN countrylanguage AS T2 ON T1.Code = T2.CountryCode WHERE T1.Name = 'Aruba';

/*
Prediction Result:
(6,)
*/