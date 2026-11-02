-- Schema DDL
CREATE TABLE "city" ("ID" INTEGER PRIMARY KEY, "CountryCode" TEXT(3), "Name" TEXT(35), "District" TEXT(20), "Population" INTEGER, FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

CREATE TABLE "country" ("Code" TEXT(3) PRIMARY KEY, "Name" TEXT(52), "Continent" TEXT, "Region" TEXT(26), "SurfaceArea" REAL(10, 2), "IndepYear" INTEGER, "Population" INTEGER, "LifeExpectancy" REAL(3, 1), "GNP" REAL(10, 2), "GNPOld" REAL(10, 2), "LocalName" TEXT(45), "GovernmentForm" TEXT(45), "HeadOfState" TEXT(60), "Capital" INTEGER, "Code2" TEXT(2));

CREATE TABLE "countrylanguage" ("CountryCode" TEXT(3), "Language" TEXT(30), "IsOfficial" TEXT, "Percentage" REAL(4, 1), PRIMARY KEY ("CountryCode", "Language"), FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests duplicate preservation (SELECT vs SELECT DISTINCT), ordering (ASC vs DESC), NULLS LAST vs NULLS FIRST, and INNER JOIN vs LEFT/RIGHT OUTER JOIN with NULL FK.
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('C1', 'Country1', 'Asia', 'Zeta Region', 100.0, 1900, 1000, 60.0, 10.0, 10.0, 'C1', 'Rep', 'H1', 1, 'C1');
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('C2', 'Country2', 'Europe', 'Alpha Region', 200.0, 1900, 2000, 70.0, 20.0, 20.0, 'C2', 'Rep', 'H2', 2, 'C2');
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('C3', 'Country3', 'Africa', NULL, 300.0, 1900, 3000, 50.0, 30.0, 30.0, 'C3', 'Rep', 'H3', 4, 'C3');
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('C4', 'Country4', 'Oceania', 'Unmatched Region', 400.0, 1900, 4000, 80.0, 40.0, 40.0, 'C4', 'Rep', 'H4', NULL, 'C4');
INSERT INTO "city" ("ID", "CountryCode", "Name", "District", "Population") VALUES (1, 'C1', 'Kabul', 'D1', 100);
INSERT INTO "city" ("ID", "CountryCode", "Name", "District", "Population") VALUES (2, 'C2', 'Kabul', 'D2', 200);
INSERT INTO "city" ("ID", "CountryCode", "Name", "District", "Population") VALUES (3, 'C2', 'Kabul', 'D3', 300);
INSERT INTO "city" ("ID", "CountryCode", "Name", "District", "Population") VALUES (4, 'C3', 'Kabul', 'D4', 400);
INSERT INTO "city" ("ID", "CountryCode", "Name", "District", "Population") VALUES (5, NULL, 'Kabul', 'D5', 500);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "region" FROM (SELECT "LHS"."id" AS "id", "LHS"."name" AS "name", "LHS"."countrycode" AS "countrycode", "LHS"."district" AS "district", "LHS"."population" AS "population", "RHS"."name" AS "name_other", "RHS"."continent" AS "continent", "RHS"."region" AS "region", "RHS"."surfacearea" AS "surfacearea", "RHS"."indepyear" AS "indepyear", "RHS"."population" AS "population_other", "RHS"."lifeexpectancy" AS "lifeexpectancy", "RHS"."gnp" AS "gnp", "RHS"."gnpold" AS "gnpold", "RHS"."localname" AS "localname", "RHS"."governmentform" AS "governmentform", "RHS"."headofstate" AS "headofstate", "RHS"."capital" AS "capital", "RHS"."code2" AS "code2" FROM (SELECT * FROM "city" WHERE ("name" = 'Kabul')) AS LHS INNER JOIN country AS RHS ON (LHS.countrycode = RHS.code)) ORDER BY region, "region" NULLS LAST;

/*
Gold Result:
(None,)
('Alpha Region',)
('Alpha Region',)
('Zeta Region',)
*/

-- Prediction Query
SELECT Region FROM country AS T1 JOIN city AS T2 ON T1.Code = T2.CountryCode WHERE T2.Name = 'Kabul';

/*
Prediction Result:
('Zeta Region',)
('Alpha Region',)
('Alpha Region',)
(None,)
*/