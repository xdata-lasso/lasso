-- Schema DDL
CREATE TABLE "city" ("ID" INTEGER PRIMARY KEY, "CountryCode" TEXT(3), "Name" TEXT(35), "District" TEXT(20), "Population" INTEGER, FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

CREATE TABLE "country" ("Code" TEXT(3) PRIMARY KEY, "Name" TEXT(52), "Continent" TEXT, "Region" TEXT(26), "SurfaceArea" REAL(10, 2), "IndepYear" INTEGER, "Population" INTEGER, "LifeExpectancy" REAL(3, 1), "GNP" REAL(10, 2), "GNPOld" REAL(10, 2), "LocalName" TEXT(45), "GovernmentForm" TEXT(45), "HeadOfState" TEXT(60), "Capital" INTEGER, "Code2" TEXT(2));

CREATE TABLE "countrylanguage" ("CountryCode" TEXT(3), "Language" TEXT(30), "IsOfficial" TEXT, "Percentage" REAL(4, 1), PRIMARY KEY ("CountryCode", "Language"), FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: country --
INSERT INTO "country" ("code", "name", "continent", "region", "surfacearea", "indepyear", "population", "lifeexpectancy", "gnp", "gnpold", "localname", "governmentform", "headofstate", "capital", "code2") VALUES ('rhs_55c74e', 'Aruba', 'rhs_83b41b', 'rhs_d8454e', 1.0, 1, 1, 1.0, 1.0, 1.0, 'rhs_4f785b', 'rhs_2753d6', 'rhs_f3879b', 1, 'rhs_0bea1d');

INSERT INTO "country" ("code", "name", "continent", "region", "surfacearea", "indepyear", "population", "lifeexpectancy", "gnp", "gnpold", "localname", "governmentform", "headofstate", "capital", "code2") VALUES ('lhs_b2739b', 'Aruba', 'rhs_83b41b', 'rhs_d8454e', 1.0, 1, 1, 1.0, 1.0, 1.0, 'rhs_4f785b', 'rhs_2753d6', 'rhs_f3879b', 1, 'rhs_0bea1d');

INSERT INTO "country" ("code", "name", "continent", "region", "surfacearea", "indepyear", "population", "lifeexpectancy", "gnp", "gnpold", "localname", "governmentform", "headofstate", "capital", "code2") VALUES ('c_2', 'Aruba', 'rhs_c91d5f', 'rhs_aab6e4', 1.0, 1, 1, 1.0, 1.0, 1.0, 'rhs_2f98e1', 'rhs_8dfa97', 'rhs_18041b', 1, 'rhs_42539b');

INSERT INTO "country" ("code", "name", "continent", "region", "surfacearea", "indepyear", "population", "lifeexpectancy", "gnp", "gnpold", "localname", "governmentform", "headofstate", "capital", "code2") VALUES ('lhs_f6704f', 'value', 'value', 'value', 1.0, 1, 1, 1.0, 1.0, 1.0, 'value', 'value', 'value', 1, 'value');

INSERT INTO "country" ("code", "name", "continent", "region", "surfacearea", "indepyear", "population", "lifeexpectancy", "gnp", "gnpold", "localname", "governmentform", "headofstate", "capital", "code2") VALUES ('C', 'Aruba', 'rhs_83b41b', 'rhs_d8454e', 1.0, 1, 1, 1.0, 1.0, 1.0, 'rhs_4f785b', 'rhs_2753d6', 'rhs_f3879b', 1, 'rhs_0bea1d');

INSERT INTO "country" ("code", "name", "continent", "region", "surfacearea", "indepyear", "population", "lifeexpectancy", "gnp", "gnpold", "localname", "governmentform", "headofstate", "capital", "code2") VALUES ('A', 'cou_4b102e', '5k5swwqcgs', 'cou_732d66', 0.06, 247012447, -1980249628, 0.6, 0.06, 0.06, 'cou_246f4b', 'cou_f0aa95', 'cou_fe861e', -734455130, '03');

INSERT INTO "country" ("code", "name", "continent", "region", "surfacearea", "indepyear", "population", "lifeexpectancy", "gnp", "gnpold", "localname", "governmentform", "headofstate", "capital", "code2") VALUES ('O', 'Aruba', 'rhs_83b41b', 'rhs_d8454e', 1.0, 1, 1, 1.0, 1.0, 1.0, 'rhs_4f785b', 'rhs_2753d6', 'rhs_f3879b', 1, 'rhs_0bea1d');

INSERT INTO "country" ("code", "name", "continent", "region", "surfacearea", "indepyear", "population", "lifeexpectancy", "gnp", "gnpold", "localname", "governmentform", "headofstate", "capital", "code2") VALUES ('G', 'Aruba', 'rhs_83b41b', 'rhs_d8454e', 1.0, 1, 1, 1.0, 1.0, 1.0, 'rhs_4f785b', 'rhs_2753d6', 'rhs_f3879b', 1, 'rhs_0bea1d');

-- Inserting into table: countrylanguage --
INSERT INTO "countrylanguage" ("countrycode", "language", "isofficial", "percentage") VALUES ('rhs_55c74e', 'lhs_5e8c5e', 'lhs_923853', 1.0);

INSERT INTO "countrylanguage" ("countrycode", "language", "isofficial", "percentage") VALUES ('lhs_b2739b', 'lhs_5e8c5e', 'lhs_923853', 1.0);

INSERT INTO "countrylanguage" ("countrycode", "language", "isofficial", "percentage") VALUES ('lhs_f6704f', 'lhs_e4c7ff', 'lhs_f21323', 1.0);

INSERT INTO "countrylanguage" ("countrycode", "language", "isofficial", "percentage") VALUES ('A', 'lhs_5e8c5e', 'lhs_923853', 1.0);

INSERT INTO "countrylanguage" ("countrycode", "language", "isofficial", "percentage") VALUES ('rhs_55c74e', 'lhs_e4c7ff', 'lhs_f21323', 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n" AS "count_t2_language_" FROM (SELECT "countrycode", COUNT(*) AS "n" FROM (SELECT * FROM (SELECT "countrycode", "language", "isofficial", "percentage", "name", "continent", "region", "surfacearea", "indepyear", "population", "lifeexpectancy", "gnp", "gnpold", "localname", "governmentform", "headofstate", "capital", "code2", "countrycode" AS "code" FROM (SELECT "LHS"."countrycode" AS "countrycode", "LHS"."language" AS "language", "LHS"."isofficial" AS "isofficial", "LHS"."percentage" AS "percentage", "RHS"."name" AS "name", "RHS"."continent" AS "continent", "RHS"."region" AS "region", "RHS"."surfacearea" AS "surfacearea", "RHS"."indepyear" AS "indepyear", "RHS"."population" AS "population", "RHS"."lifeexpectancy" AS "lifeexpectancy", "RHS"."gnp" AS "gnp", "RHS"."gnpold" AS "gnpold", "RHS"."localname" AS "localname", "RHS"."governmentform" AS "governmentform", "RHS"."headofstate" AS "headofstate", "RHS"."capital" AS "capital", "RHS"."code2" AS "code2" FROM "countrylanguage" AS "LHS" INNER JOIN "country" AS "RHS" ON ("LHS"."countrycode" = "RHS"."code"))) WHERE ("name" = 'Aruba')) GROUP BY countrycode) ORDER BY count_t2_language_;

/*
Gold Result:
(1,)
(2,)
*/

-- Prediction Query
SELECT COUNT(T2.Language) FROM country AS T1 JOIN countrylanguage AS T2 ON T1.Code = T2.CountryCode WHERE T1.Name = 'Aruba';

/*
Prediction Result:
(3,)
*/