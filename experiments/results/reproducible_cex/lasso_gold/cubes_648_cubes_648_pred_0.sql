-- Schema DDL
CREATE TABLE "city" ("ID" INTEGER PRIMARY KEY, "CountryCode" TEXT(3), "Name" TEXT(35), "District" TEXT(20), "Population" INTEGER, FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

CREATE TABLE "country" ("Code" TEXT(3) PRIMARY KEY, "Name" TEXT(52), "Continent" TEXT, "Region" TEXT(26), "SurfaceArea" REAL(10, 2), "IndepYear" INTEGER, "Population" INTEGER, "LifeExpectancy" REAL(3, 1), "GNP" REAL(10, 2), "GNPOld" REAL(10, 2), "LocalName" TEXT(45), "GovernmentForm" TEXT(45), "HeadOfState" TEXT(60), "Capital" INTEGER, "Code2" TEXT(2));

CREATE TABLE "countrylanguage" ("CountryCode" TEXT(3), "Language" TEXT(30), "IsOfficial" TEXT, "Percentage" REAL(4, 1), PRIMARY KEY ("CountryCode", "Language"), FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "country" ("code", "name", "continent", "region", "surfacearea", "indepyear", "population", "lifeexpectancy", "gnp", "gnpold", "localname", "governmentform", "headofstate", "capital", "code2") VALUES ('Philippines', 'Aruba', 'sit', 'wait', 1009.5, 1010, 1011, 1012.5, 1013.5, 1014.5, 'Gardner', 'performance', 'Nevada', 1015, 'almost');
INSERT INTO "country" ("code", "name", "continent", "region", "surfacearea", "indepyear", "population", "lifeexpectancy", "gnp", "gnpold", "localname", "governmentform", "headofstate", "capital", "code2") VALUES ('Cuba', 'Aruba', 'early', 'mouth', 1017.5, 1018, 1019, 1020.5, 1021.5, 1022.5, 'Guzman', 'option', 'Illinois', 1023, 'sense');
INSERT INTO "countrylanguage" ("countrycode", "language", "isofficial", "percentage") VALUES ('Philippines', 'all', 'better', 1016.5);
INSERT INTO "countrylanguage" ("countrycode", "language", "isofficial", "percentage") VALUES ('Cuba', 'rate', NULL, 1024.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n" AS "count_t2_language_" FROM (SELECT "countrycode", COUNT(*) AS "n" FROM (SELECT * FROM (SELECT "countrycode", "language", "isofficial", "percentage", "name", "continent", "region", "surfacearea", "indepyear", "population", "lifeexpectancy", "gnp", "gnpold", "localname", "governmentform", "headofstate", "capital", "code2", "countrycode" AS "code" FROM (SELECT "LHS"."countrycode" AS "countrycode", "LHS"."language" AS "language", "LHS"."isofficial" AS "isofficial", "LHS"."percentage" AS "percentage", "RHS"."name" AS "name", "RHS"."continent" AS "continent", "RHS"."region" AS "region", "RHS"."surfacearea" AS "surfacearea", "RHS"."indepyear" AS "indepyear", "RHS"."population" AS "population", "RHS"."lifeexpectancy" AS "lifeexpectancy", "RHS"."gnp" AS "gnp", "RHS"."gnpold" AS "gnpold", "RHS"."localname" AS "localname", "RHS"."governmentform" AS "governmentform", "RHS"."headofstate" AS "headofstate", "RHS"."capital" AS "capital", "RHS"."code2" AS "code2" FROM "countrylanguage" AS "LHS" INNER JOIN "country" AS "RHS" ON ("LHS"."countrycode" = "RHS"."code"))) WHERE ("name" = 'Aruba')) GROUP BY countrycode) ORDER BY count_t2_language_;

/*
Gold Result:
(1,)
(1,)
*/

-- Prediction Query
SELECT COUNT(T2.Language) FROM country AS T1 JOIN countrylanguage AS T2 ON T1.Code = T2.CountryCode WHERE T1.Name = 'Aruba';

/*
Prediction Result:
(2,)
*/