-- Schema DDL
CREATE TABLE "city" ("ID" INTEGER PRIMARY KEY, "CountryCode" TEXT(3), "Name" TEXT(35), "District" TEXT(20), "Population" INTEGER, FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

CREATE TABLE "country" ("Code" TEXT(3) PRIMARY KEY, "Name" TEXT(52), "Continent" TEXT, "Region" TEXT(26), "SurfaceArea" REAL(10, 2), "IndepYear" INTEGER, "Population" INTEGER, "LifeExpectancy" REAL(3, 1), "GNP" REAL(10, 2), "GNPOld" REAL(10, 2), "LocalName" TEXT(45), "GovernmentForm" TEXT(45), "HeadOfState" TEXT(60), "Capital" INTEGER, "Code2" TEXT(2));

CREATE TABLE "countrylanguage" ("CountryCode" TEXT(3), "Language" TEXT(30), "IsOfficial" TEXT, "Percentage" REAL(4, 1), PRIMARY KEY ("CountryCode", "Language"), FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('ABW', 'Aruba', 'North America', 'Caribbean', 193.0, NULL, 103000, 78.4, 828.0, 793.0, 'Aruba', 'Territory', 'Beatrix', 1, 'AW');
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('BHS', 'Bahamas', 'North America', 'Caribbean', 13878.0, 1973, 307000, 71.1, 3527.0, 3347.0, 'The Bahamas', 'Constitutional Monarchy', 'Elisabeth II', 2, 'BS');
INSERT INTO "city" ("ID", "CountryCode", "Name", "District", "Population") VALUES (1, 'ABW', 'Oranjestad', 'Oranjestad', 29034);
INSERT INTO "city" ("ID", "CountryCode", "Name", "District", "Population") VALUES (2, 'BHS', 'Nassau', 'New Providence', 172000);
INSERT INTO "countrylanguage" ("CountryCode", "Language", "IsOfficial", "Percentage") VALUES ('BHS', 'Creole English', 'F', 89.7);
INSERT INTO "countrylanguage" ("CountryCode", "Language", "IsOfficial", "Percentage") VALUES ('BHS', 'Creole French', 'F', 10.3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n" AS "count_t2_language_" FROM (SELECT "countrycode", COUNT(*) AS "n" FROM (SELECT * FROM (SELECT "countrycode", "language", "isofficial", "percentage", "name", "continent", "region", "surfacearea", "indepyear", "population", "lifeexpectancy", "gnp", "gnpold", "localname", "governmentform", "headofstate", "capital", "code2", "countrycode" AS "code" FROM (SELECT "LHS"."countrycode" AS "countrycode", "LHS"."language" AS "language", "LHS"."isofficial" AS "isofficial", "LHS"."percentage" AS "percentage", "RHS"."name" AS "name", "RHS"."continent" AS "continent", "RHS"."region" AS "region", "RHS"."surfacearea" AS "surfacearea", "RHS"."indepyear" AS "indepyear", "RHS"."population" AS "population", "RHS"."lifeexpectancy" AS "lifeexpectancy", "RHS"."gnp" AS "gnp", "RHS"."gnpold" AS "gnpold", "RHS"."localname" AS "localname", "RHS"."governmentform" AS "governmentform", "RHS"."headofstate" AS "headofstate", "RHS"."capital" AS "capital", "RHS"."code2" AS "code2" FROM "countrylanguage" AS "LHS" INNER JOIN "country" AS "RHS" ON ("LHS"."countrycode" = "RHS"."code"))) WHERE ("name" = 'Aruba')) GROUP BY countrycode) ORDER BY count_t2_language_;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(T2.Language) FROM country AS T1 JOIN countrylanguage AS T2 ON T1.Code = T2.CountryCode WHERE T1.Name = 'Aruba';

/*
Prediction Result:
(0,)
*/