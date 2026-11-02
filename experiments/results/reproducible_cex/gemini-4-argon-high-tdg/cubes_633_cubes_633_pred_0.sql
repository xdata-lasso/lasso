-- Schema DDL
CREATE TABLE "city" ("ID" INTEGER PRIMARY KEY, "CountryCode" TEXT(3), "Name" TEXT(35), "District" TEXT(20), "Population" INTEGER, FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

CREATE TABLE "country" ("Code" TEXT(3) PRIMARY KEY, "Name" TEXT(52), "Continent" TEXT, "Region" TEXT(26), "SurfaceArea" REAL(10, 2), "IndepYear" INTEGER, "Population" INTEGER, "LifeExpectancy" REAL(3, 1), "GNP" REAL(10, 2), "GNPOld" REAL(10, 2), "LocalName" TEXT(45), "GovernmentForm" TEXT(45), "HeadOfState" TEXT(60), "Capital" INTEGER, "Code2" TEXT(2));

CREATE TABLE "countrylanguage" ("CountryCode" TEXT(3), "Language" TEXT(30), "IsOfficial" TEXT, "Percentage" REAL(4, 1), PRIMARY KEY ("CountryCode", "Language"), FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO country (Code, Name, Continent, Region, SurfaceArea, IndepYear, Population, LifeExpectancy, GNP, GNPOld, LocalName, GovernmentForm, HeadOfState, Capital, Code2) VALUES ('AAA', 'Alpha', 'Asia', 'Western Europe', 41526.0, 1581, 15864000, 78.3, 371362.0, 360478.0, 'AlphaLocal', 'Constitutional Monarchy', 'Leader A', NULL, 'AA');
INSERT INTO country (Code, Name, Continent, Region, SurfaceArea, IndepYear, Population, LifeExpectancy, GNP, GNPOld, LocalName, GovernmentForm, HeadOfState, Capital, Code2) VALUES ('ZZZ', 'Zeta', 'Europe', 'British Islands', 242900.0, 1066, 59623400, 77.7, 1378330.0, 1296830.0, 'ZetaLocal', 'Constitutional Monarchy', 'Leader Z', NULL, 'ZZ');
INSERT INTO country (Code, Name, Continent, Region, SurfaceArea, IndepYear, Population, LifeExpectancy, GNP, GNPOld, LocalName, GovernmentForm, HeadOfState, Capital, Code2) VALUES ('MMM', 'Middle', 'Africa', 'Central Africa', 551500.0, 1960, 59225700, 78.8, 1424285.0, 1392448.0, 'MiddleLocal', 'Republic', 'Leader M', 1, 'MM');
INSERT INTO city (ID, CountryCode, Name, District, Population) VALUES (1, 'MMM', 'MiddleCity', 'Central', 500000);
INSERT INTO countrylanguage (CountryCode, Language, IsOfficial, Percentage) VALUES ('AAA', 'Dutch', 'F', 5.0);
INSERT INTO countrylanguage (CountryCode, Language, IsOfficial, Percentage) VALUES ('ZZZ', 'English', 'T', 97.3);
INSERT INTO countrylanguage (CountryCode, Language, IsOfficial, Percentage) VALUES ('MMM', 'French', 'T', 100.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "region" FROM (SELECT "LHS"."countrycode" AS "countrycode", "LHS"."language" AS "language", "LHS"."isofficial" AS "isofficial", "LHS"."percentage" AS "percentage", "RHS"."name" AS "name", "RHS"."continent" AS "continent", "RHS"."region" AS "region", "RHS"."surfacearea" AS "surfacearea", "RHS"."indepyear" AS "indepyear", "RHS"."population" AS "population", "RHS"."lifeexpectancy" AS "lifeexpectancy", "RHS"."gnp" AS "gnp", "RHS"."gnpold" AS "gnpold", "RHS"."localname" AS "localname", "RHS"."governmentform" AS "governmentform", "RHS"."headofstate" AS "headofstate", "RHS"."capital" AS "capital", "RHS"."code2" AS "code2" FROM (SELECT * FROM "countrylanguage" WHERE ("language" = 'Dutch' OR "language" = 'English')) AS LHS INNER JOIN country AS RHS ON (LHS.countrycode = RHS.code)) ORDER BY region, "region" NULLS LAST;

/*
Gold Result:
('British Islands',)
('Western Europe',)
*/

-- Prediction Query
SELECT DISTINCT T1.Region FROM country AS T1 JOIN countrylanguage AS T2 ON T1.Code = T2.CountryCode WHERE T2.Language = 'English' OR T2.Language = 'Dutch';

/*
Prediction Result:
('Western Europe',)
('British Islands',)
*/