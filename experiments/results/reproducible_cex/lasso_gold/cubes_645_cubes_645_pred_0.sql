-- Schema DDL
CREATE TABLE "city" ("ID" INTEGER PRIMARY KEY, "CountryCode" TEXT(3), "Name" TEXT(35), "District" TEXT(20), "Population" INTEGER, FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

CREATE TABLE "country" ("Code" TEXT(3) PRIMARY KEY, "Name" TEXT(52), "Continent" TEXT, "Region" TEXT(26), "SurfaceArea" REAL(10, 2), "IndepYear" INTEGER, "Population" INTEGER, "LifeExpectancy" REAL(3, 1), "GNP" REAL(10, 2), "GNPOld" REAL(10, 2), "LocalName" TEXT(45), "GovernmentForm" TEXT(45), "HeadOfState" TEXT(60), "Capital" INTEGER, "Code2" TEXT(2));

CREATE TABLE "countrylanguage" ("CountryCode" TEXT(3), "Language" TEXT(30), "IsOfficial" TEXT, "Percentage" REAL(4, 1), PRIMARY KEY ("CountryCode", "Language"), FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "country" ("code", "name", "continent", "region", "surfacearea", "indepyear", "population", "lifeexpectancy", "gnp", "gnpold", "localname", "governmentform", "headofstate", "capital", "code2") VALUES ('serve', 'Jonathan White', 'while', 'born', 1119.5, 1120, 1121, 1122.5, 1123.5, 1124.5, 'Harrell', 'fire', 'South Dakota', 1125, 'movement');
INSERT INTO "country" ("code", "name", "continent", "region", "surfacearea", "indepyear", "population", "lifeexpectancy", "gnp", "gnpold", "localname", "governmentform", "headofstate", "capital", "code2") VALUES ('serve_z', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "city" ("id", "countrycode", "name", "district", "population") VALUES (1126, 'serve', 'Kabul', 'politics', 1127);
INSERT INTO "city" ("id", "countrycode", "name", "district", "population") VALUES (1128, 'serve_z', 'Kabul', 'politics', 1127);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "region" FROM (SELECT "LHS"."id" AS "id", "LHS"."name" AS "name", "LHS"."countrycode" AS "countrycode", "LHS"."district" AS "district", "LHS"."population" AS "population", "RHS"."name" AS "name_other", "RHS"."continent" AS "continent", "RHS"."region" AS "region", "RHS"."surfacearea" AS "surfacearea", "RHS"."indepyear" AS "indepyear", "RHS"."population" AS "population_other", "RHS"."lifeexpectancy" AS "lifeexpectancy", "RHS"."gnp" AS "gnp", "RHS"."gnpold" AS "gnpold", "RHS"."localname" AS "localname", "RHS"."governmentform" AS "governmentform", "RHS"."headofstate" AS "headofstate", "RHS"."capital" AS "capital", "RHS"."code2" AS "code2" FROM (SELECT * FROM "city" WHERE ("name" = 'Kabul')) AS LHS INNER JOIN country AS RHS ON (LHS.countrycode = RHS.code)) ORDER BY region, "region" NULLS LAST;

/*
Gold Result:
(None,)
('born',)
*/

-- Prediction Query
SELECT Region FROM country AS T1 JOIN city AS T2 ON T1.Code = T2.CountryCode WHERE T2.Name = 'Kabul';

/*
Prediction Result:
('born',)
(None,)
*/