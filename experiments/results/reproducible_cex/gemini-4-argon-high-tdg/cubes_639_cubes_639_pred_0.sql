-- Schema DDL
CREATE TABLE "city" ("ID" INTEGER PRIMARY KEY, "CountryCode" TEXT(3), "Name" TEXT(35), "District" TEXT(20), "Population" INTEGER, FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

CREATE TABLE "country" ("Code" TEXT(3) PRIMARY KEY, "Name" TEXT(52), "Continent" TEXT, "Region" TEXT(26), "SurfaceArea" REAL(10, 2), "IndepYear" INTEGER, "Population" INTEGER, "LifeExpectancy" REAL(3, 1), "GNP" REAL(10, 2), "GNPOld" REAL(10, 2), "LocalName" TEXT(45), "GovernmentForm" TEXT(45), "HeadOfState" TEXT(60), "Capital" INTEGER, "Code2" TEXT(2));

CREATE TABLE "countrylanguage" ("CountryCode" TEXT(3), "Language" TEXT(30), "IsOfficial" TEXT, "Percentage" REAL(4, 1), PRIMARY KEY ("CountryCode", "Language"), FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('NLD', 'Netherlands', 'Europe', 'Western Europe', 41526.0, 1581, 15864000, 78.3, 371362.0, 360478.0, 'Nederland', 'Constitutional Monarchy', 'Beatrix', 1, 'NL');
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('ANT', 'Netherlands Antilles', 'North America', 'Caribbean', 800.0, NULL, 217000, 74.7, 1941.0, NULL, 'Nederlandse Antillen', 'Nonmetropolitan Territory of The Netherlands', 'Beatrix', NULL, 'AN');
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('BEL', 'Belgium', 'Europe', 'Western Europe', 30518.0, 1830, 10239000, 77.8, 249704.0, 243948.0, 'Belgie/Belgique', 'Constitutional Monarchy, Federation', 'Albert II', 3, 'BE');
INSERT INTO "city" ("ID", "CountryCode", "Name", "District", "Population") VALUES (1, 'NLD', 'Amsterdam', 'Noord-Holland', 731200);
INSERT INTO "city" ("ID", "CountryCode", "Name", "District", "Population") VALUES (2, 'NLD', 'Rotterdam', 'Zuid-Holland', 593321);
INSERT INTO "city" ("ID", "CountryCode", "Name", "District", "Population") VALUES (3, 'BEL', 'Bruxelles', 'Bryssel', 133859);
INSERT INTO "countrylanguage" ("CountryCode", "Language", "IsOfficial", "Percentage") VALUES ('NLD', 'Frisian', 'T', 3.7);
INSERT INTO "countrylanguage" ("CountryCode", "Language", "IsOfficial", "Percentage") VALUES ('NLD', 'Dutch', 'T', 95.6);
INSERT INTO "countrylanguage" ("CountryCode", "Language", "IsOfficial", "Percentage") VALUES ('NLD', 'Turkish', 'F', 0.8);
INSERT INTO "countrylanguage" ("CountryCode", "Language", "IsOfficial", "Percentage") VALUES ('ANT', 'Dutch', 'T', 7.8);
INSERT INTO "countrylanguage" ("CountryCode", "Language", "IsOfficial", "Percentage") VALUES ('ANT', 'Papiamento', 'F', 86.2);
INSERT INTO "countrylanguage" ("CountryCode", "Language", "IsOfficial", "Percentage") VALUES ('BEL', 'French', 'T', 32.6);
INSERT INTO "countrylanguage" ("CountryCode", "Language", "IsOfficial", "Percentage") VALUES ('BEL', 'German', 'F', 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "language" FROM (SELECT "countrycode", "language", "isofficial", "percentage", "name", "continent", "region", "surfacearea", "indepyear", "population", "lifeexpectancy", "gnp", "gnpold", "localname", "governmentform", "headofstate", "capital", "code2", "countrycode" AS "code" FROM (SELECT "LHS"."countrycode" AS "countrycode", "LHS"."language" AS "language", "LHS"."isofficial" AS "isofficial", "LHS"."percentage" AS "percentage", "RHS"."name" AS "name", "RHS"."continent" AS "continent", "RHS"."region" AS "region", "RHS"."surfacearea" AS "surfacearea", "RHS"."indepyear" AS "indepyear", "RHS"."population" AS "population", "RHS"."lifeexpectancy" AS "lifeexpectancy", "RHS"."gnp" AS "gnp", "RHS"."gnpold" AS "gnpold", "RHS"."localname" AS "localname", "RHS"."governmentform" AS "governmentform", "RHS"."headofstate" AS "headofstate", "RHS"."capital" AS "capital", "RHS"."code2" AS "code2" FROM "countrylanguage" AS "LHS" INNER JOIN "country" AS "RHS" ON ("LHS"."countrycode" = "RHS"."code"))) WHERE ("isofficial" = 'T' AND "headofstate" = 'Beatrix') ORDER BY LANGUAGE, "language" NULLS LAST;

/*
Gold Result:
('Dutch',)
('Dutch',)
('Frisian',)
*/

-- Prediction Query
SELECT T2.Language FROM country AS T1 JOIN countrylanguage AS T2 ON T1.Code = T2.CountryCode WHERE T1.HeadOfState = 'Beatrix' AND T2.IsOfficial = 'T';

/*
Prediction Result:
('Frisian',)
('Dutch',)
('Dutch',)
*/