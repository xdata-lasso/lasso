-- Schema DDL
CREATE TABLE "city" ("ID" INTEGER PRIMARY KEY, "CountryCode" TEXT(3), "Name" TEXT(35), "District" TEXT(20), "Population" INTEGER, FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

CREATE TABLE "country" ("Code" TEXT(3) PRIMARY KEY, "Name" TEXT(52), "Continent" TEXT, "Region" TEXT(26), "SurfaceArea" REAL(10, 2), "IndepYear" INTEGER, "Population" INTEGER, "LifeExpectancy" REAL(3, 1), "GNP" REAL(10, 2), "GNPOld" REAL(10, 2), "LocalName" TEXT(45), "GovernmentForm" TEXT(45), "HeadOfState" TEXT(60), "Capital" INTEGER, "Code2" TEXT(2));

CREATE TABLE "countrylanguage" ("CountryCode" TEXT(3), "Language" TEXT(30), "IsOfficial" TEXT, "Percentage" REAL(4, 1), PRIMARY KEY ("CountryCode", "Language"), FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "country" ("code", "name", "continent", "region", "surfacearea", "indepyear", "population", "lifeexpectancy", "gnp", "gnpold", "localname", "governmentform", "headofstate", "capital", "code2") VALUES ('Morocco', 'Matthew Mejia', 'base', 'trial', 1049.5, 1052, 1055, 1058.5, 1061.5, 1064.5, 'Ramirez', 'hospital', 'Texas', 1067, 'write');
INSERT INTO "country" ("code", "name", "continent", "region", "surfacearea", "indepyear", "population", "lifeexpectancy", "gnp", "gnpold", "localname", "governmentform", "headofstate", "capital", "code2") VALUES ('Congo', 'Matthew Mejia', 'top', 'blood', 1060.5, 1065.0, 1070.0, 1075.5, 1080.5, 1085.5, 'Reid', 'hear', 'Louisiana', 1096.0, 'result');
INSERT INTO "country" ("code", "name", "continent", "region", "surfacearea", "indepyear", "population", "lifeexpectancy", "gnp", "gnpold", "localname", "governmentform", "headofstate", "capital", "code2") VALUES ('Romania', 'Matthew Mejia', 'early', 'husband', 1071.5, 1078.0, 1085.0, 1092.5, 1099.5, 1106.5, 'Diaz', 'determine', 'Vermont', 1125.0, 'raise');
INSERT INTO "country" ("code", "name", "continent", "region", "surfacearea", "indepyear", "population", "lifeexpectancy", "gnp", "gnpold", "localname", "governmentform", "headofstate", "capital", "code2") VALUES ('Ecuador', 'Matthew Mejia', 'base', 'trial', 1049.5, 1052, 1055, 1058.5, 1061.5, 1064.5, 'Ramirez', 'hospital', 'Texas', 1067, 'write');
INSERT INTO "countrylanguage" ("countrycode", "language", "isofficial", "percentage") VALUES ('Morocco', 'away', 'Congress', 1070.5);
INSERT INTO "countrylanguage" ("countrycode", "language", "isofficial", "percentage") VALUES ('Morocco', 'politics', 'none', 1079.5);
INSERT INTO "countrylanguage" ("countrycode", "language", "isofficial", "percentage") VALUES ('Morocco', 'prove', 'shoulder', 1088.5);
INSERT INTO "countrylanguage" ("countrycode", "language", "isofficial", "percentage") VALUES ('Ecuador', 'away', 'Congress', 1070.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n_distinct AS count_t2_language_, name FROM (SELECT name, COUNT(DISTINCT LANGUAGE) AS n_distinct FROM (SELECT countrycode, LANGUAGE, isofficial, percentage, name, continent, region, surfacearea, indepyear, population, lifeexpectancy, gnp, gnpold, localname, governmentform, headofstate, capital, code2, countrycode AS code FROM (SELECT LHS.countrycode AS countrycode, LHS.language AS LANGUAGE, LHS.isofficial AS isofficial, LHS.percentage AS percentage, RHS.name AS name, RHS.continent AS continent, RHS.region AS region, RHS.surfacearea AS surfacearea, RHS.indepyear AS indepyear, RHS.population AS population, RHS.lifeexpectancy AS lifeexpectancy, RHS.gnp AS gnp, RHS.gnpold AS gnpold, RHS.localname AS localname, RHS.governmentform AS governmentform, RHS.headofstate AS headofstate, RHS.capital AS capital, RHS.code2 AS code2 FROM countrylanguage AS LHS INNER JOIN country AS RHS ON (LHS.countrycode = RHS.code))) GROUP BY name) WHERE (n_distinct > 2) ORDER BY count_t2_language_, name NULLS LAST;

/*
Gold Result:
(3, 'Matthew Mejia')
*/

-- Prediction Query
SELECT COUNT(T2.Language), T1.Name FROM country AS T1 JOIN countrylanguage AS T2 ON T1.Code = T2.CountryCode GROUP BY T1.Name HAVING COUNT(*) > 2;

/*
Prediction Result:
(4, 'Matthew Mejia')
*/