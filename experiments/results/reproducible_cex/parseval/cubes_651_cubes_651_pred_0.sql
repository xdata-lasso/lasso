-- Schema DDL
CREATE TABLE "city" ("ID" INTEGER PRIMARY KEY, "CountryCode" TEXT(3), "Name" TEXT(35), "District" TEXT(20), "Population" INTEGER, FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

CREATE TABLE "country" ("Code" TEXT(3) PRIMARY KEY, "Name" TEXT(52), "Continent" TEXT, "Region" TEXT(26), "SurfaceArea" REAL(10, 2), "IndepYear" INTEGER, "Population" INTEGER, "LifeExpectancy" REAL(3, 1), "GNP" REAL(10, 2), "GNPOld" REAL(10, 2), "LocalName" TEXT(45), "GovernmentForm" TEXT(45), "HeadOfState" TEXT(60), "Capital" INTEGER, "Code2" TEXT(2));

CREATE TABLE "countrylanguage" ("CountryCode" TEXT(3), "Language" TEXT(30), "IsOfficial" TEXT, "Percentage" REAL(4, 1), PRIMARY KEY ("CountryCode", "Language"), FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: country --
INSERT INTO "country" ("code", "name", "continent", "region", "surfacearea", "indepyear", "population", "lifeexpectancy", "gnp", "gnpold", "localname", "governmentform", "headofstate", "capital", "code2") VALUES ('rhs_95bce9', 'rhs_4e5287', 'rhs_4d0a13', 'rhs_660a5c', 1.0, 1, 1, 1.0, 1.0, 1.0, 'rhs_d951c8', 'rhs_d7b557', 'rhs_9f7351', 1, 'rhs_0871f7');

INSERT INTO "country" ("code", "name", "continent", "region", "surfacearea", "indepyear", "population", "lifeexpectancy", "gnp", "gnpold", "localname", "governmentform", "headofstate", "capital", "code2") VALUES ('lhs_ff26aa', 'rhs_4e5287', 'rhs_4d0a13', 'rhs_660a5c', 1.0, 1, 1, 1.0, 1.0, 1.0, 'rhs_d951c8', 'rhs_d7b557', 'rhs_9f7351', 1, 'rhs_0871f7');

INSERT INTO "country" ("code", "name", "continent", "region", "surfacearea", "indepyear", "population", "lifeexpectancy", "gnp", "gnpold", "localname", "governmentform", "headofstate", "capital", "code2") VALUES ('c_2', 'rhs_540f48', 'rhs_ab7f15', 'rhs_d98943', 1.0, 1, 1, 1.0, 1.0, 1.0, 'rhs_2d8217', 'rhs_043527', 'rhs_0b1d80', 1, 'rhs_cf2dcc');

INSERT INTO "country" ("code", "name", "continent", "region", "surfacearea", "indepyear", "population", "lifeexpectancy", "gnp", "gnpold", "localname", "governmentform", "headofstate", "capital", "code2") VALUES ('rhs_120b1c', 'value', 'value', 'value', 1.0, 1, 1, 1.0, 1.0, 1.0, 'value', 'value', 'value', 1, 'value');

INSERT INTO "country" ("code", "name", "continent", "region", "surfacearea", "indepyear", "population", "lifeexpectancy", "gnp", "gnpold", "localname", "governmentform", "headofstate", "capital", "code2") VALUES ('A', 'rhs_4e5287', 'rhs_4d0a13', 'rhs_660a5c', 1.0, 1, 1, 1.0, 1.0, 1.0, 'rhs_d951c8', 'rhs_d7b557', 'rhs_9f7351', 1, 'rhs_0871f7');

INSERT INTO "country" ("code", "name", "continent", "region", "surfacearea", "indepyear", "population", "lifeexpectancy", "gnp", "gnpold", "localname", "governmentform", "headofstate", "capital", "code2") VALUES ('C', 'cou_4b102e', '5k5swwqcgs', 'cou_732d66', 0.06, 247012447, -1980249628, 0.6, 0.06, 0.06, 'cou_246f4b', 'cou_f0aa95', 'cou_fe861e', -734455130, '03');

INSERT INTO "country" ("code", "name", "continent", "region", "surfacearea", "indepyear", "population", "lifeexpectancy", "gnp", "gnpold", "localname", "governmentform", "headofstate", "capital", "code2") VALUES ('E', 'cou_4b102e', '4h', 'cou_732d66', 0.07, -992890117, 1914020640, 0.7, 0.07, 0.07, 'cou_246f4b', 'cou_f0aa95', 'cou_fe861e', 1268590800, '03');

INSERT INTO "country" ("code", "name", "continent", "region", "surfacearea", "indepyear", "population", "lifeexpectancy", "gnp", "gnpold", "localname", "governmentform", "headofstate", "capital", "code2") VALUES ('O', 'cou_4b102e', 'puzhsrw', 'cou_732d66', 0.08, 1908028688, 2122220075, 0.8, 0.08, 0.08, 'cou_246f4b', 'cou_f0aa95', 'cou_fe861e', 1072996612, '03');

-- Inserting into table: countrylanguage --
INSERT INTO "countrylanguage" ("countrycode", "language", "isofficial", "percentage") VALUES ('rhs_95bce9', 'lhs_5d4158', 'lhs_bb5c31', 1.0);

INSERT INTO "countrylanguage" ("countrycode", "language", "isofficial", "percentage") VALUES ('lhs_ff26aa', 'lhs_5d4158', 'lhs_bb5c31', 1.0);

INSERT INTO "countrylanguage" ("countrycode", "language", "isofficial", "percentage") VALUES ('rhs_120b1c', 'lhs_ecd7e8', 'lhs_27a9c1', 1.0);

INSERT INTO "countrylanguage" ("countrycode", "language", "isofficial", "percentage") VALUES ('C', 'lhs_5d4158', 'lhs_bb5c31', 1.0);

INSERT INTO "countrylanguage" ("countrycode", "language", "isofficial", "percentage") VALUES ('E', 'lhs_5d4158', 'lhs_bb5c31', 1.0);

INSERT INTO "countrylanguage" ("countrycode", "language", "isofficial", "percentage") VALUES ('O', 'lhs_5d4158', 'lhs_bb5c31', 1.0);

INSERT INTO "countrylanguage" ("countrycode", "language", "isofficial", "percentage") VALUES ('rhs_95bce9', 'lhs_ecd7e8', 'lhs_27a9c1', 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n_distinct AS count_t2_language_, name FROM (SELECT name, COUNT(DISTINCT LANGUAGE) AS n_distinct FROM (SELECT countrycode, LANGUAGE, isofficial, percentage, name, continent, region, surfacearea, indepyear, population, lifeexpectancy, gnp, gnpold, localname, governmentform, headofstate, capital, code2, countrycode AS code FROM (SELECT LHS.countrycode AS countrycode, LHS.language AS LANGUAGE, LHS.isofficial AS isofficial, LHS.percentage AS percentage, RHS.name AS name, RHS.continent AS continent, RHS.region AS region, RHS.surfacearea AS surfacearea, RHS.indepyear AS indepyear, RHS.population AS population, RHS.lifeexpectancy AS lifeexpectancy, RHS.gnp AS gnp, RHS.gnpold AS gnpold, RHS.localname AS localname, RHS.governmentform AS governmentform, RHS.headofstate AS headofstate, RHS.capital AS capital, RHS.code2 AS code2 FROM countrylanguage AS LHS INNER JOIN country AS RHS ON (LHS.countrycode = RHS.code))) GROUP BY name) WHERE (n_distinct > 2) ORDER BY count_t2_language_, name NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(T2.Language), T1.Name FROM country AS T1 JOIN countrylanguage AS T2 ON T1.Code = T2.CountryCode GROUP BY T1.Name HAVING COUNT(*) > 2;

/*
Prediction Result:
(3, 'cou_4b102e')
(3, 'rhs_4e5287')
*/