-- Schema DDL
CREATE TABLE "city" ("ID" INTEGER PRIMARY KEY, "CountryCode" TEXT(3), "Name" TEXT(35), "District" TEXT(20), "Population" INTEGER, FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

CREATE TABLE "country" ("Code" TEXT(3) PRIMARY KEY, "Name" TEXT(52), "Continent" TEXT, "Region" TEXT(26), "SurfaceArea" REAL(10, 2), "IndepYear" INTEGER, "Population" INTEGER, "LifeExpectancy" REAL(3, 1), "GNP" REAL(10, 2), "GNPOld" REAL(10, 2), "LocalName" TEXT(45), "GovernmentForm" TEXT(45), "HeadOfState" TEXT(60), "Capital" INTEGER, "Code2" TEXT(2));

CREATE TABLE "countrylanguage" ("CountryCode" TEXT(3), "Language" TEXT(30), "IsOfficial" TEXT, "Percentage" REAL(4, 1), PRIMARY KEY ("CountryCode", "Language"), FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "country" ("code", "name", "continent", "region", "surfacearea", "indepyear", "population", "lifeexpectancy", "gnp", "gnpold", "localname", "governmentform", "headofstate", "capital", "code2") VALUES ('Rwanda', 'Zachary Santos', 'left', 'we', 1169.5, 1170, 1171, 1172.5, 1173.5, 1174.5, 'Holmes', 'camera', 'Beatrix', 1175, 'end');
INSERT INTO "country" ("code", "name", "continent", "region", "surfacearea", "indepyear", "population", "lifeexpectancy", "gnp", "gnpold", "localname", "governmentform", "headofstate", "capital", "code2") VALUES ('Bangladesh', 'Shannon Jones', 'economy', 'family', 1185.5, 1186, 1187, 1188.5, 1189.5, 1190.5, 'Caldwell', 'difficult', 'Beatrix', 1191, 'notice');
INSERT INTO "countrylanguage" ("countrycode", "language", "isofficial", "percentage") VALUES ('Rwanda', 'down', 'T', 1176.5);
INSERT INTO "countrylanguage" ("countrycode", "language", "isofficial", "percentage") VALUES ('Rwanda', 'drop', 'T', 1184.5);
INSERT INTO "countrylanguage" ("countrycode", "language", "isofficial", "percentage") VALUES ('Bangladesh', 'cause', 'T', 1192.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "language" FROM (SELECT "countrycode", "language", "isofficial", "percentage", "name", "continent", "region", "surfacearea", "indepyear", "population", "lifeexpectancy", "gnp", "gnpold", "localname", "governmentform", "headofstate", "capital", "code2", "countrycode" AS "code" FROM (SELECT "LHS"."countrycode" AS "countrycode", "LHS"."language" AS "language", "LHS"."isofficial" AS "isofficial", "LHS"."percentage" AS "percentage", "RHS"."name" AS "name", "RHS"."continent" AS "continent", "RHS"."region" AS "region", "RHS"."surfacearea" AS "surfacearea", "RHS"."indepyear" AS "indepyear", "RHS"."population" AS "population", "RHS"."lifeexpectancy" AS "lifeexpectancy", "RHS"."gnp" AS "gnp", "RHS"."gnpold" AS "gnpold", "RHS"."localname" AS "localname", "RHS"."governmentform" AS "governmentform", "RHS"."headofstate" AS "headofstate", "RHS"."capital" AS "capital", "RHS"."code2" AS "code2" FROM "countrylanguage" AS "LHS" INNER JOIN "country" AS "RHS" ON ("LHS"."countrycode" = "RHS"."code"))) WHERE ("isofficial" = 'T' AND "headofstate" = 'Beatrix') ORDER BY LANGUAGE, "language" NULLS LAST;

/*
Gold Result:
('cause',)
('down',)
('drop',)
*/

-- Prediction Query
SELECT T2.Language FROM country AS T1 JOIN countrylanguage AS T2 ON T1.Code = T2.CountryCode WHERE T1.HeadOfState = 'Beatrix' AND T2.IsOfficial = 'T';

/*
Prediction Result:
('down',)
('drop',)
('cause',)
*/