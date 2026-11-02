-- Schema DDL
CREATE TABLE "city" ("ID" INTEGER PRIMARY KEY, "CountryCode" TEXT(3), "Name" TEXT(35), "District" TEXT(20), "Population" INTEGER, FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

CREATE TABLE "country" ("Code" TEXT(3) PRIMARY KEY, "Name" TEXT(52), "Continent" TEXT, "Region" TEXT(26), "SurfaceArea" REAL(10, 2), "IndepYear" INTEGER, "Population" INTEGER, "LifeExpectancy" REAL(3, 1), "GNP" REAL(10, 2), "GNPOld" REAL(10, 2), "LocalName" TEXT(45), "GovernmentForm" TEXT(45), "HeadOfState" TEXT(60), "Capital" INTEGER, "Code2" TEXT(2));

CREATE TABLE "countrylanguage" ("CountryCode" TEXT(3), "Language" TEXT(30), "IsOfficial" TEXT, "Percentage" REAL(4, 1), PRIMARY KEY ("CountryCode", "Language"), FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Join Type & NULL Handling Mutations:
-- Tests LEFT JOIN between "countrylanguage" and "city" (country with no cities producing NULL "name"),
-- and ORDER BY "name" NULLS LAST vs NULLS FIRST / INNER JOIN mutants.
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('SGP', 'Singapore_Country', 'Asia', 'Southeast Asia', 618.0, 1965, 3567000, 80.1, 86503.0, 96318.0, 'Singapore/Singapura', 'Republic', 'Sellapan Rama Nathan', 3208, 'SG');
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('TWN', 'Taiwan_Country', 'Asia', 'Eastern Asia', 36188.0, 1945, 22256000, 76.4, 256254.0, 263451.0, 'T’ai-wan', 'Republic', 'Chen Shui-bian', 3263, 'TW');
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('MAC', 'Macao_Country', 'Asia', 'Eastern Asia', 18.0, NULL, 473000, 81.6, 5749.0, 5940.0, 'Macau/Aomen', 'Special Administrative Region of China', 'Jiang Zemin', 2454, 'MO');
-- SGP has NO rows in "city" table (produces NULL for city.Name via LEFT JOIN)
-- TWN has a city with NULL Name explicitly, and a city with 'Z_Taipei'
INSERT INTO "city" ("ID", "CountryCode", "Name", "District", "Population") VALUES (10, 'TWN', 'Z_Taipei', 'Taipei', 2641312);
-- MAC has a city 'A_Macao'
INSERT INTO "city" ("ID", "CountryCode", "Name", "District", "Population") VALUES (20, 'MAC', 'A_Macao', 'Macau', 437500);
INSERT INTO "countrylanguage" ("CountryCode", "Language", "IsOfficial", "Percentage") VALUES ('SGP', 'Chinese', 'T', 77.1);
INSERT INTO "countrylanguage" ("CountryCode", "Language", "IsOfficial", "Percentage") VALUES ('TWN', 'Chinese', 'T', 95.0);
INSERT INTO "countrylanguage" ("CountryCode", "Language", "IsOfficial", "Percentage") VALUES ('MAC', 'Chinese', 'T', 85.6);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "name" FROM (SELECT * FROM (SELECT "countrycode", "language", "isofficial", "percentage", "id", "name", "district", "population", "name_other", "continent", "region", "surfacearea", "indepyear", "population_other", "lifeexpectancy", "gnp", "gnpold", "localname", "governmentform", "headofstate", "capital", "code2", "countrycode" AS "code" FROM (SELECT "LHS"."countrycode" AS "countrycode", "LHS"."language" AS "language", "LHS"."isofficial" AS "isofficial", "LHS"."percentage" AS "percentage", "LHS"."id" AS "id", "LHS"."name" AS "name", "LHS"."district" AS "district", "LHS"."population" AS "population", "RHS"."name" AS "name_other", "RHS"."continent" AS "continent", "RHS"."region" AS "region", "RHS"."surfacearea" AS "surfacearea", "RHS"."indepyear" AS "indepyear", "RHS"."population" AS "population_other", "RHS"."lifeexpectancy" AS "lifeexpectancy", "RHS"."gnp" AS "gnp", "RHS"."gnpold" AS "gnpold", "RHS"."localname" AS "localname", "RHS"."governmentform" AS "governmentform", "RHS"."headofstate" AS "headofstate", "RHS"."capital" AS "capital", "RHS"."code2" AS "code2" FROM (SELECT "LHS"."countrycode" AS "countrycode", "LHS"."language" AS "language", "LHS"."isofficial" AS "isofficial", "LHS"."percentage" AS "percentage", "RHS"."id" AS "id", "RHS"."name" AS "name", "RHS"."district" AS "district", "RHS"."population" AS "population" FROM "countrylanguage" AS "LHS" LEFT JOIN "city" AS "RHS" ON ("LHS"."countrycode" = "RHS"."countrycode")) AS "LHS" INNER JOIN "country" AS "RHS" ON ("LHS"."countrycode" = "RHS"."code"))) WHERE ("continent" = 'Asia' AND "isofficial" = 'T')) WHERE ("continent" = 'Asia' AND "language" = 'Chinese') ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
(None,)
('A_Macao',)
('Z_Taipei',)
*/

-- Prediction Query
SELECT DISTINCT T3.Name FROM country AS T1 JOIN countrylanguage AS T2 ON T1.Code = T2.CountryCode JOIN city AS T3 ON T1.Code = T3.CountryCode WHERE T2.IsOfficial = 'T' AND T2.Language = 'Chinese' AND T1.Continent = 'Asia';

/*
Prediction Result:
('Z_Taipei',)
('A_Macao',)
*/