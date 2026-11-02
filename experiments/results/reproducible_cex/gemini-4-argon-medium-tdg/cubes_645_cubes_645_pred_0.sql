-- Schema DDL
CREATE TABLE "city" ("ID" INTEGER PRIMARY KEY, "CountryCode" TEXT(3), "Name" TEXT(35), "District" TEXT(20), "Population" INTEGER, FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

CREATE TABLE "country" ("Code" TEXT(3) PRIMARY KEY, "Name" TEXT(52), "Continent" TEXT, "Region" TEXT(26), "SurfaceArea" REAL(10, 2), "IndepYear" INTEGER, "Population" INTEGER, "LifeExpectancy" REAL(3, 1), "GNP" REAL(10, 2), "GNPOld" REAL(10, 2), "LocalName" TEXT(45), "GovernmentForm" TEXT(45), "HeadOfState" TEXT(60), "Capital" INTEGER, "Code2" TEXT(2));

CREATE TABLE "countrylanguage" ("CountryCode" TEXT(3), "Language" TEXT(30), "IsOfficial" TEXT, "Percentage" REAL(4, 1), PRIMARY KEY ("CountryCode", "Language"), FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('AAA', 'CountryA', 'Asia', 'Z_Region', 100.00, 2000, 1000, 70.0, 100.00, 90.00, 'LocalA', 'Republic', 'HeadA', 1, 'AA');
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('BBB', 'CountryB', 'Europe', 'A_Region', 200.00, 2000, 2000, 75.0, 200.00, 190.00, 'LocalB', 'Republic', 'HeadB', 2, 'BB');
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('CCC', 'CountryC', 'Africa', NULL, 300.00, 2000, 3000, 60.0, 300.00, 290.00, 'LocalC', 'Republic', 'HeadC', 3, 'CC');
INSERT INTO "city" ("ID", "CountryCode", "Name", "District", "Population") VALUES (1, 'AAA', 'Kabul', 'DistA', 500);
INSERT INTO "city" ("ID", "CountryCode", "Name", "District", "Population") VALUES (2, 'BBB', 'Kabul', 'DistB', 600);
INSERT INTO "city" ("ID", "CountryCode", "Name", "District", "Population") VALUES (3, 'CCC', 'Kabul', 'DistC', 700);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "region" FROM (SELECT "LHS"."id" AS "id", "LHS"."name" AS "name", "LHS"."countrycode" AS "countrycode", "LHS"."district" AS "district", "LHS"."population" AS "population", "RHS"."name" AS "name_other", "RHS"."continent" AS "continent", "RHS"."region" AS "region", "RHS"."surfacearea" AS "surfacearea", "RHS"."indepyear" AS "indepyear", "RHS"."population" AS "population_other", "RHS"."lifeexpectancy" AS "lifeexpectancy", "RHS"."gnp" AS "gnp", "RHS"."gnpold" AS "gnpold", "RHS"."localname" AS "localname", "RHS"."governmentform" AS "governmentform", "RHS"."headofstate" AS "headofstate", "RHS"."capital" AS "capital", "RHS"."code2" AS "code2" FROM (SELECT * FROM "city" WHERE ("name" = 'Kabul')) AS LHS INNER JOIN country AS RHS ON (LHS.countrycode = RHS.code)) ORDER BY region, "region" NULLS LAST;

/*
Gold Result:
(None,)
('A_Region',)
('Z_Region',)
*/

-- Prediction Query
SELECT Region FROM country AS T1 JOIN city AS T2 ON T1.Code = T2.CountryCode WHERE T2.Name = 'Kabul';

/*
Prediction Result:
('Z_Region',)
('A_Region',)
(None,)
*/