-- Schema DDL
CREATE TABLE "city" ("ID" INTEGER PRIMARY KEY, "CountryCode" TEXT(3), "Name" TEXT(35), "District" TEXT(20), "Population" INTEGER, FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

CREATE TABLE "country" ("Code" TEXT(3) PRIMARY KEY, "Name" TEXT(52), "Continent" TEXT, "Region" TEXT(26), "SurfaceArea" REAL(10, 2), "IndepYear" INTEGER, "Population" INTEGER, "LifeExpectancy" REAL(3, 1), "GNP" REAL(10, 2), "GNPOld" REAL(10, 2), "LocalName" TEXT(45), "GovernmentForm" TEXT(45), "HeadOfState" TEXT(60), "Capital" INTEGER, "Code2" TEXT(2));

CREATE TABLE "countrylanguage" ("CountryCode" TEXT(3), "Language" TEXT(30), "IsOfficial" TEXT, "Percentage" REAL(4, 1), PRIMARY KEY ("CountryCode", "Language"), FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('CHN', 'China', 'Asia', 'Eastern Asia', 9572900.0, -1523, 1277558000, 71.4, 982268.0, 917719.0, 'Zhongquo', 'PeoplesRepublic', 'Jiang Zemin', 1, 'CN');
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('JPN', 'Japan', 'Asia', 'Eastern Asia', 377829.0, -660, 126714000, 80.7, 3787042.0, 4192638.0, 'Nihon', 'Constitutional Monarchy', 'Akihito', 3, 'JP');
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('HKG', 'Hong Kong', 'Asia', 'Eastern Asia', 1075.0, NULL, 6782000, 79.5, 166448.0, 173610.0, 'Xianggang', 'Special Administrative Region', 'Jiang Zemin', 4, 'HK');
INSERT INTO "country" ("Code", "Name", "Continent", "Region", "SurfaceArea", "IndepYear", "Population", "LifeExpectancy", "GNP", "GNPOld", "LocalName", "GovernmentForm", "HeadOfState", "Capital", "Code2") VALUES ('GBR', 'United Kingdom', 'Europe', 'British Islands', 242900.0, 1066, 59623400, 77.7, 1378330.0, 1296830.0, 'United Kingdom', 'Constitutional Monarchy', 'Elisabeth II', 5, 'GB');
INSERT INTO "city" ("ID", "CountryCode", "Name", "District", "Population") VALUES (1, 'CHN', 'Shanghai', 'Shanghai', 9696300);
INSERT INTO "city" ("ID", "CountryCode", "Name", "District", "Population") VALUES (2, 'CHN', 'Beijing', 'Peking', 7472000);
INSERT INTO "city" ("ID", "CountryCode", "Name", "District", "Population") VALUES (3, 'JPN', 'Tokyo', 'Tokyo-to', 7980230);
INSERT INTO "city" ("ID", "CountryCode", "Name", "District", "Population") VALUES (4, 'HKG', 'Kowloon', 'Kowloon', 1987996);
INSERT INTO "city" ("ID", "CountryCode", "Name", "District", "Population") VALUES (5, 'GBR', 'London', 'England', 7285000);
INSERT INTO "countrylanguage" ("CountryCode", "Language", "IsOfficial", "Percentage") VALUES ('CHN', 'Chinese', 'T', 92.0);
INSERT INTO "countrylanguage" ("CountryCode", "Language", "IsOfficial", "Percentage") VALUES ('JPN', 'Japanese', 'T', 99.1);
INSERT INTO "countrylanguage" ("CountryCode", "Language", "IsOfficial", "Percentage") VALUES ('HKG', 'Chinese', 'F', 88.7);
INSERT INTO "countrylanguage" ("CountryCode", "Language", "IsOfficial", "Percentage") VALUES ('GBR', 'Chinese', 'T', 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "name" FROM (SELECT * FROM (SELECT "countrycode", "language", "isofficial", "percentage", "id", "name", "district", "population", "name_other", "continent", "region", "surfacearea", "indepyear", "population_other", "lifeexpectancy", "gnp", "gnpold", "localname", "governmentform", "headofstate", "capital", "code2", "countrycode" AS "code" FROM (SELECT "LHS"."countrycode" AS "countrycode", "LHS"."language" AS "language", "LHS"."isofficial" AS "isofficial", "LHS"."percentage" AS "percentage", "LHS"."id" AS "id", "LHS"."name" AS "name", "LHS"."district" AS "district", "LHS"."population" AS "population", "RHS"."name" AS "name_other", "RHS"."continent" AS "continent", "RHS"."region" AS "region", "RHS"."surfacearea" AS "surfacearea", "RHS"."indepyear" AS "indepyear", "RHS"."population" AS "population_other", "RHS"."lifeexpectancy" AS "lifeexpectancy", "RHS"."gnp" AS "gnp", "RHS"."gnpold" AS "gnpold", "RHS"."localname" AS "localname", "RHS"."governmentform" AS "governmentform", "RHS"."headofstate" AS "headofstate", "RHS"."capital" AS "capital", "RHS"."code2" AS "code2" FROM (SELECT "LHS"."countrycode" AS "countrycode", "LHS"."language" AS "language", "LHS"."isofficial" AS "isofficial", "LHS"."percentage" AS "percentage", "RHS"."id" AS "id", "RHS"."name" AS "name", "RHS"."district" AS "district", "RHS"."population" AS "population" FROM "countrylanguage" AS "LHS" LEFT JOIN "city" AS "RHS" ON ("LHS"."countrycode" = "RHS"."countrycode")) AS "LHS" INNER JOIN "country" AS "RHS" ON ("LHS"."countrycode" = "RHS"."code"))) WHERE ("continent" = 'Asia' AND "isofficial" = 'T')) WHERE ("continent" = 'Asia' AND "language" = 'Chinese') ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
('Beijing',)
('Shanghai',)
*/

-- Prediction Query
SELECT DISTINCT T3.Name FROM country AS T1 JOIN countrylanguage AS T2 ON T1.Code = T2.CountryCode JOIN city AS T3 ON T1.Code = T3.CountryCode WHERE T2.IsOfficial = 'T' AND T2.Language = 'Chinese' AND T1.Continent = 'Asia';

/*
Prediction Result:
('Shanghai',)
('Beijing',)
*/