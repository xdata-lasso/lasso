-- Schema DDL
CREATE TABLE "city" ("ID" INTEGER PRIMARY KEY, "CountryCode" TEXT(3), "Name" TEXT(35), "District" TEXT(20), "Population" INTEGER, FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

CREATE TABLE "country" ("Code" TEXT(3) PRIMARY KEY, "Name" TEXT(52), "Continent" TEXT, "Region" TEXT(26), "SurfaceArea" REAL(10, 2), "IndepYear" INTEGER, "Population" INTEGER, "LifeExpectancy" REAL(3, 1), "GNP" REAL(10, 2), "GNPOld" REAL(10, 2), "LocalName" TEXT(45), "GovernmentForm" TEXT(45), "HeadOfState" TEXT(60), "Capital" INTEGER, "Code2" TEXT(2));

CREATE TABLE "countrylanguage" ("CountryCode" TEXT(3), "Language" TEXT(30), "IsOfficial" TEXT, "Percentage" REAL(4, 1), PRIMARY KEY ("CountryCode", "Language"), FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('C01', 'Beatrix', 'Europe', 'RegionA', 100.0, 1900, 1000, 70.0, 100.0, 90.0, 'Beatrix', 'Republic', 'John Doe', 1, 'C1');
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('C02', 'CountryTwo', 'Asia', 'RegionB', 200.0, 1950, 2000, 75.0, 200.0, 180.0, 'LocalTwo', 'Monarchy', 'Beatrix', 2, 'C2');
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('C03', 'CountryThree', 'Africa', 'RegionC', 300.0, 1960, 3000, 65.0, 300.0, 250.0, 'LocalThree', 'Monarchy', 'beatrix', 3, 'C3');
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('C04', 'CountryFour', 'Europe', 'RegionD', 400.0, NULL, 4000, NULL, 400.0, NULL, 'LocalFour', 'Republic', NULL, NULL, 'C4');
INSERT INTO "countrylanguage" ("CountryCode", "Language", "IsOfficial", "Percentage") VALUES ('C01', 'LangA', 'T', 50.0);
INSERT INTO "countrylanguage" ("CountryCode", "Language", "IsOfficial", "Percentage") VALUES ('C02', 'ZetaLang', 'T', 10.0);
INSERT INTO "countrylanguage" ("CountryCode", "Language", "IsOfficial", "Percentage") VALUES ('C02', 'AlphaLang', 'T', 80.0);
INSERT INTO "countrylanguage" ("CountryCode", "Language", "IsOfficial", "Percentage") VALUES ('C02', 'BetaLang', 't', 5.0);
INSERT INTO "countrylanguage" ("CountryCode", "Language", "IsOfficial", "Percentage") VALUES ('C02', 'GammaLang', NULL, 5.0);
INSERT INTO "countrylanguage" ("CountryCode", "Language", "IsOfficial", "Percentage") VALUES ('C03', 'DeltaLang', 'T', 100.0);
INSERT INTO "countrylanguage" ("CountryCode", "Language", "IsOfficial", "Percentage") VALUES ('C04', 'EpsLang', 'T', 100.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "language" FROM (SELECT "countrycode", "language", "isofficial", "percentage", "name", "continent", "region", "surfacearea", "indepyear", "population", "lifeexpectancy", "gnp", "gnpold", "localname", "governmentform", "headofstate", "capital", "code2", "countrycode" AS "code" FROM (SELECT "LHS"."countrycode" AS "countrycode", "LHS"."language" AS "language", "LHS"."isofficial" AS "isofficial", "LHS"."percentage" AS "percentage", "RHS"."name" AS "name", "RHS"."continent" AS "continent", "RHS"."region" AS "region", "RHS"."surfacearea" AS "surfacearea", "RHS"."indepyear" AS "indepyear", "RHS"."population" AS "population", "RHS"."lifeexpectancy" AS "lifeexpectancy", "RHS"."gnp" AS "gnp", "RHS"."gnpold" AS "gnpold", "RHS"."localname" AS "localname", "RHS"."governmentform" AS "governmentform", "RHS"."headofstate" AS "headofstate", "RHS"."capital" AS "capital", "RHS"."code2" AS "code2" FROM "countrylanguage" AS "LHS" INNER JOIN "country" AS "RHS" ON ("LHS"."countrycode" = "RHS"."code"))) WHERE ("isofficial" = 'T' AND "headofstate" = 'Beatrix') ORDER BY LANGUAGE, "language" NULLS LAST;

/*
Gold Result:
('AlphaLang',)
('ZetaLang',)
*/

-- Prediction Query
SELECT T2.Language FROM country AS T1 JOIN countrylanguage AS T2 ON T1.Code = T2.CountryCode WHERE T1.HeadOfState = 'Beatrix' AND T2.IsOfficial = 'T';

/*
Prediction Result:
('ZetaLang',)
('AlphaLang',)
*/