-- Schema DDL
CREATE TABLE "city" ("ID" INTEGER PRIMARY KEY, "CountryCode" TEXT(3), "Name" TEXT(35), "District" TEXT(20), "Population" INTEGER, FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

CREATE TABLE "country" ("Code" TEXT(3) PRIMARY KEY, "Name" TEXT(52), "Continent" TEXT, "Region" TEXT(26), "SurfaceArea" REAL(10, 2), "IndepYear" INTEGER, "Population" INTEGER, "LifeExpectancy" REAL(3, 1), "GNP" REAL(10, 2), "GNPOld" REAL(10, 2), "LocalName" TEXT(45), "GovernmentForm" TEXT(45), "HeadOfState" TEXT(60), "Capital" INTEGER, "Code2" TEXT(2));

CREATE TABLE "countrylanguage" ("CountryCode" TEXT(3), "Language" TEXT(30), "IsOfficial" TEXT, "Percentage" REAL(4, 1), PRIMARY KEY ("CountryCode", "Language"), FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests ORDER BY ASC vs DESC, NULLS LAST vs NULLS FIRST, and INNER JOIN vs RIGHT/OUTER JOIN (countries with no languages).
INSERT INTO "country" ("Code", "Name", "Continent", "Region") VALUES ('AUS', 'Australia', 'Oceania', 'Australia and New Zealand');
INSERT INTO "country" ("Code", "Name", "Continent", "Region") VALUES ('BEL', 'Belgium', 'Europe', 'Western Europe');
INSERT INTO "country" ("Code", "Name", "Continent", "Region") VALUES ('ZAF', 'South Africa', 'Africa', 'Southern Africa');
INSERT INTO "country" ("Code", "Name", "Continent", "Region") VALUES ('ANT', 'Antarctica', 'Antarctica', NULL);
INSERT INTO "country" ("Code", "Name", "Continent", "Region") VALUES ('BRA', 'Brazil', 'South America', 'South America');
INSERT INTO "countrylanguage" ("CountryCode", "Language", "IsOfficial", "Percentage") VALUES ('AUS', 'English', 'T', 81.2);
INSERT INTO "countrylanguage" ("CountryCode", "Language", "IsOfficial", "Percentage") VALUES ('BEL', 'Dutch', 'T', 59.2);
INSERT INTO "countrylanguage" ("CountryCode", "Language", "IsOfficial", "Percentage") VALUES ('ZAF', 'English', 'T', 8.5);
INSERT INTO "countrylanguage" ("CountryCode", "Language", "IsOfficial", "Percentage") VALUES ('ANT', 'Dutch', 'F', 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "region" FROM (SELECT "LHS"."countrycode" AS "countrycode", "LHS"."language" AS "language", "LHS"."isofficial" AS "isofficial", "LHS"."percentage" AS "percentage", "RHS"."name" AS "name", "RHS"."continent" AS "continent", "RHS"."region" AS "region", "RHS"."surfacearea" AS "surfacearea", "RHS"."indepyear" AS "indepyear", "RHS"."population" AS "population", "RHS"."lifeexpectancy" AS "lifeexpectancy", "RHS"."gnp" AS "gnp", "RHS"."gnpold" AS "gnpold", "RHS"."localname" AS "localname", "RHS"."governmentform" AS "governmentform", "RHS"."headofstate" AS "headofstate", "RHS"."capital" AS "capital", "RHS"."code2" AS "code2" FROM (SELECT * FROM "countrylanguage" WHERE ("language" = 'Dutch' OR "language" = 'English')) AS LHS INNER JOIN country AS RHS ON (LHS.countrycode = RHS.code)) ORDER BY region, "region" NULLS LAST;

/*
Gold Result:
(None,)
('Australia and New Zealand',)
('Southern Africa',)
('Western Europe',)
*/

-- Prediction Query
SELECT DISTINCT T1.Region FROM country AS T1 JOIN countrylanguage AS T2 ON T1.Code = T2.CountryCode WHERE T2.Language = 'English' OR T2.Language = 'Dutch';

/*
Prediction Result:
(None,)
('Australia and New Zealand',)
('Western Europe',)
('Southern Africa',)
*/