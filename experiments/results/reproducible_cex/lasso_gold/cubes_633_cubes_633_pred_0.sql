-- Schema DDL
CREATE TABLE "city" ("ID" INTEGER PRIMARY KEY, "CountryCode" TEXT(3), "Name" TEXT(35), "District" TEXT(20), "Population" INTEGER, FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

CREATE TABLE "country" ("Code" TEXT(3) PRIMARY KEY, "Name" TEXT(52), "Continent" TEXT, "Region" TEXT(26), "SurfaceArea" REAL(10, 2), "IndepYear" INTEGER, "Population" INTEGER, "LifeExpectancy" REAL(3, 1), "GNP" REAL(10, 2), "GNPOld" REAL(10, 2), "LocalName" TEXT(45), "GovernmentForm" TEXT(45), "HeadOfState" TEXT(60), "Capital" INTEGER, "Code2" TEXT(2));

CREATE TABLE "countrylanguage" ("CountryCode" TEXT(3), "Language" TEXT(30), "IsOfficial" TEXT, "Percentage" REAL(4, 1), PRIMARY KEY ("CountryCode", "Language"), FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "country" ("code", "name", "continent", "region", "surfacearea", "indepyear", "population", "lifeexpectancy", "gnp", "gnpold", "localname", "governmentform", "headofstate", "capital", "code2") VALUES ('bar', 'John Jones', 'soon', 'no', 1135.5, 1136, 1137, 1138.5, 1139.5, 1140.5, 'Cannon', 'career', 'Texas', 1141, 'may');
INSERT INTO "country" ("code", "name", "continent", "region", "surfacearea", "indepyear", "population", "lifeexpectancy", "gnp", "gnpold", "localname", "governmentform", "headofstate", "capital", "code2") VALUES ('rate', 'Steven Hayes', 'end', 'down', 1153.5, 1154, 1155, 1156.5, 1157.5, 1158.5, 'Brown', 'against', 'Pennsylvania', 1159, 'once');
INSERT INTO "countrylanguage" ("countrycode", "language", "isofficial", "percentage") VALUES ('bar', 'Dutch', 'often', 1142.5);
INSERT INTO "countrylanguage" ("countrycode", "language", "isofficial", "percentage") VALUES ('bar', 'English', 'company', 1151.5);
INSERT INTO "countrylanguage" ("countrycode", "language", "isofficial", "percentage") VALUES ('rate', 'Dutch', 'per', 1160.5);
INSERT INTO "countrylanguage" ("countrycode", "language", "isofficial", "percentage") VALUES ('rate', 'English', 'discussion', 1169.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "region" FROM (SELECT "LHS"."countrycode" AS "countrycode", "LHS"."language" AS "language", "LHS"."isofficial" AS "isofficial", "LHS"."percentage" AS "percentage", "RHS"."name" AS "name", "RHS"."continent" AS "continent", "RHS"."region" AS "region", "RHS"."surfacearea" AS "surfacearea", "RHS"."indepyear" AS "indepyear", "RHS"."population" AS "population", "RHS"."lifeexpectancy" AS "lifeexpectancy", "RHS"."gnp" AS "gnp", "RHS"."gnpold" AS "gnpold", "RHS"."localname" AS "localname", "RHS"."governmentform" AS "governmentform", "RHS"."headofstate" AS "headofstate", "RHS"."capital" AS "capital", "RHS"."code2" AS "code2" FROM (SELECT * FROM "countrylanguage" WHERE ("language" = 'Dutch' OR "language" = 'English')) AS LHS INNER JOIN country AS RHS ON (LHS.countrycode = RHS.code)) ORDER BY region, "region" NULLS LAST;

/*
Gold Result:
('down',)
('no',)
*/

-- Prediction Query
SELECT DISTINCT T1.Region FROM country AS T1 JOIN countrylanguage AS T2 ON T1.Code = T2.CountryCode WHERE T2.Language = 'English' OR T2.Language = 'Dutch';

/*
Prediction Result:
('no',)
('down',)
*/