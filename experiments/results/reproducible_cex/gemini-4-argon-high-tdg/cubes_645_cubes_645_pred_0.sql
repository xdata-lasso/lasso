-- Schema DDL
CREATE TABLE "city" ("ID" INTEGER PRIMARY KEY, "CountryCode" TEXT(3), "Name" TEXT(35), "District" TEXT(20), "Population" INTEGER, FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

CREATE TABLE "country" ("Code" TEXT(3) PRIMARY KEY, "Name" TEXT(52), "Continent" TEXT, "Region" TEXT(26), "SurfaceArea" REAL(10, 2), "IndepYear" INTEGER, "Population" INTEGER, "LifeExpectancy" REAL(3, 1), "GNP" REAL(10, 2), "GNPOld" REAL(10, 2), "LocalName" TEXT(45), "GovernmentForm" TEXT(45), "HeadOfState" TEXT(60), "Capital" INTEGER, "Code2" TEXT(2));

CREATE TABLE "countrylanguage" ("CountryCode" TEXT(3), "Language" TEXT(30), "IsOfficial" TEXT, "Percentage" REAL(4, 1), PRIMARY KEY ("CountryCode", "Language"), FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO country (Code, Name, Continent, Region, SurfaceArea, IndepYear, Population, LifeExpectancy, GNP, GNPOld, LocalName, GovernmentForm, HeadOfState, Capital, Code2) VALUES ('AAA', 'Alpha', 'Asia', 'Zeta Region', 100.0, 1900, 1000, 70.0, 100.0, 90.0, 'Alpha', 'Republic', 'Head A', 1, 'AA');
INSERT INTO country (Code, Name, Continent, Region, SurfaceArea, IndepYear, Population, LifeExpectancy, GNP, GNPOld, LocalName, GovernmentForm, HeadOfState, Capital, Code2) VALUES ('BBB', 'Beta', 'Europe', 'Mu Region', 200.0, 1950, 2000, 75.0, 200.0, 190.0, 'Beta', 'Monarchy', 'Head B', 2, 'BB');
INSERT INTO country (Code, Name, Continent, Region, SurfaceArea, IndepYear, Population, LifeExpectancy, GNP, GNPOld, LocalName, GovernmentForm, HeadOfState, Capital, Code2) VALUES ('CCC', 'Gamma', 'Africa', 'Alpha Region', 300.0, 2000, 3000, 80.0, 300.0, 290.0, 'Gamma', 'Republic', 'Head C', 3, 'CC');
INSERT INTO city (ID, CountryCode, Name, District, Population) VALUES (1, 'AAA', 'Kabul', 'DistA', 100);
INSERT INTO city (ID, CountryCode, Name, District, Population) VALUES (2, 'BBB', 'Kabul', 'DistB', 200);
INSERT INTO city (ID, CountryCode, Name, District, Population) VALUES (3, 'CCC', 'Kabul', 'DistC', 300);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "region" FROM (SELECT "LHS"."id" AS "id", "LHS"."name" AS "name", "LHS"."countrycode" AS "countrycode", "LHS"."district" AS "district", "LHS"."population" AS "population", "RHS"."name" AS "name_other", "RHS"."continent" AS "continent", "RHS"."region" AS "region", "RHS"."surfacearea" AS "surfacearea", "RHS"."indepyear" AS "indepyear", "RHS"."population" AS "population_other", "RHS"."lifeexpectancy" AS "lifeexpectancy", "RHS"."gnp" AS "gnp", "RHS"."gnpold" AS "gnpold", "RHS"."localname" AS "localname", "RHS"."governmentform" AS "governmentform", "RHS"."headofstate" AS "headofstate", "RHS"."capital" AS "capital", "RHS"."code2" AS "code2" FROM (SELECT * FROM "city" WHERE ("name" = 'Kabul')) AS LHS INNER JOIN country AS RHS ON (LHS.countrycode = RHS.code)) ORDER BY region, "region" NULLS LAST;

/*
Gold Result:
('Alpha Region',)
('Mu Region',)
('Zeta Region',)
*/

-- Prediction Query
SELECT Region FROM country AS T1 JOIN city AS T2 ON T1.Code = T2.CountryCode WHERE T2.Name = 'Kabul';

/*
Prediction Result:
('Zeta Region',)
('Mu Region',)
('Alpha Region',)
*/